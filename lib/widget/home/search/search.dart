import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ohmybooks_app/bloc/book/book_bloc.dart';
import 'package:ohmybooks_app/bloc/book/book_state.dart';
import 'package:ohmybooks_app/bloc/book/event/book_add_next_page_event.dart';
import 'package:ohmybooks_app/bloc/book/event/book_search_event.dart';
import 'package:ohmybooks_app/model/exception_model.dart';
import 'package:ohmybooks_app/system/dimensions.dart';
import 'package:ohmybooks_app/system/message.dart';
import 'package:ohmybooks_app/view/home.dart';
import 'package:ohmybooks_app/widget/global/book.dart';
import 'package:ohmybooks_app/widget/global/custom_drop_down_button.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ScrollController controller = ScrollController();
  String searchTerm = "";
  String? target;

  searchBooks(BuildContext context) async {
    final bloc = context.read<BookBloc>();
    bloc.add(BookSearchEvent(searchTerm, target: target));
  }

  addNextPage(BuildContext context) async {
    final bloc = context.read<BookBloc>();
    bloc.add(BookAddNextPageEvent());
  }

  onSubmit(BuildContext context) {
    FocusScope.of(context).unfocus();
    searchBooks(context);
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent * .8) {
        addNextPage(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceCrossAxisMode =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              inputHelper(
                context,
                "search-term",
                hintText: "책의 제목, 출판사, 저자 등을 입력하여 검색해보세요.",
                width: 270,
                onChanged: (value) => searchTerm = value,
                onSubmit: onSubmit,
              ),
              CustomDropDownButton(
                currValue: target,
                setCurrValue: (value) => target = value,
                items: <String>{"검색기준", "제목", "출판사", "저자"}.toList(),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(180),
                onTap: () => searchBooks(context),
                child: Icon(
                  Icons.search,
                  size: 18 * getScaleFactorFromWidth(context),
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<BookBloc, BookListState>(
          buildWhen: (_, bloc) => bloc.maxPage == false,
          builder: (_, state) {
            if (state is BookListInitState) {
              return emptyTextHelper(context);
            } else if (state is BookListLoadingState ||
                state is BookListLoadedState) {
              if (state.maxPage) {
                initSnackBarMessage(context, "마지막 페이지 입니다");
              } else if (state.limitExcessOnDay || state.tooManyRequest) {
                initSnackBarMessage(context, "오늘 검색 횟수를 모두 사용 했습니다");
              }
              final books = state.bookList ?? [];
              return books.isEmpty
                  ? emptyTextHelper(context)
                  : Expanded(
                      child: GridView.builder(
                        controller: controller,
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 20,
                          bottom: 80,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: deviceCrossAxisMode ? 4 : 2,
                          mainAxisSpacing: 64,
                          crossAxisSpacing: 8,
                          mainAxisExtent: 320 *
                              getScaleFactorFromHeight(
                                context,
                                bottomNavigatorHeight: bottomNavigatorHeight,
                              ),
                        ),
                        itemBuilder: (builderContext, index) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                  builderContext,
                                  "/detail",
                                  arguments: {"data": books[index].toJson()},
                                ),
                                child: Book(
                                  thumbnail: books[index].thumbnail ?? "",
                                  isbn: books[index].isbn!,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                width: 100 *
                                    getScaleFactorFromHeight(
                                      context,
                                      bottomNavigatorHeight:
                                          bottomNavigatorHeight,
                                    ),
                                child: bookSimpleInfoHelper(
                                  context,
                                  title: books[index].title,
                                  authors: books[index].authors,
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: books.length,
                      ),
                    );
            } else {
              state = state as BookListErrorState;
              return errorSearchText(context, state.errorType, state.metadata);
            }
          },
        ),
      ],
    );
  }
}

Widget bookSimpleInfoHelper(
  BuildContext context, {
  List<dynamic>? authors,
  String? title,
}) {
  final authorsSplit = authors?.join(",") ?? "";
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      text:
          "${authorsSplit.length > 10 ? authorsSplit.substring(0, 7).padRight(10, ",") : authorsSplit}\n",
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground,
        fontSize: 12 *
            getScaleFactorFromHeight(
              context,
              bottomNavigatorHeight: bottomNavigatorHeight,
            ),
        fontFamily: 'SpoqaHanSans',
        fontWeight: FontWeight.w600,
        height: 1.5,
      ),
      children: [
        TextSpan(
          text: title == null
              ? ""
              : title.length > 20
                  ? title.substring(0, 12).padRight(15, ".")
                  : title,
          style: TextStyle(
            fontSize: 12 *
                getScaleFactorFromHeight(
                  context,
                  bottomNavigatorHeight: bottomNavigatorHeight,
                ),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget emptyTextHelper(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: 150 *
          getScaleFactorFromHeight(
            context,
            bottomNavigatorHeight: bottomNavigatorHeight,
          ),
    ),
    child: Text(
      "검색되는 책이 아무것도 없어요!",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
        fontSize: 12 * getScaleFactorFromWidth(context),
        fontFamily: 'SpoqaHanSans',
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}

Widget errorSearchText(
  BuildContext context,
  String error,
  DioExceptionMetaDataModel? metadata,
) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: 200 *
          getScaleFactorFromHeight(
            context,
            bottomNavigatorHeight: bottomNavigatorHeight,
          ),
    ),
    child: RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        text: metadata == null ? "$error\n\n" : "${metadata.errorTitle}\n\n",
        children: [
          TextSpan(
            text: metadata == null
                ? "정보를 가져오는데 실패했습니다.\n앱 재실행 이후에도 같은 현상이 계속 발생한다면,\n해당 상황과 상단에 에러를 포함해 문의해주세요."
                : metadata.errorMessage,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
              fontSize: 12 * getScaleFactorFromWidth(context),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
        style: TextStyle(
          color: Theme.of(context).colorScheme.errorContainer,
          fontSize: 14 * getScaleFactorFromWidth(context),
          fontFamily: 'SpoqaHanSans',
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

Widget inputHelper(
  BuildContext context,
  String key, {
  int? maxLength,
  TextInputType? inputType,
  String? hintText,
  double? width,
  String? Function(String?)? validator,
  Function(String)? onChanged,
  Function(BuildContext)? onSubmit,
}) {
  return SizedBox(
    width: (width ?? 45) * getScaleFactorFromWidth(context),
    height: 30 * getScaleFactorFromWidth(context),
    child: TextFormField(
      autocorrect: false,
      onChanged: onChanged,
      onEditingComplete: () => onSubmit == null ? null : onSubmit(context),
      validator: validator,
      keyboardType: inputType,
      textAlignVertical: TextAlignVertical.bottom,
      maxLength: maxLength ?? 10,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground,
        fontSize: 8 * getScaleFactorFromWidth(context),
        fontFamily: 'SpoqaHanSans',
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.background,
        counterText: "",
        counterStyle: const TextStyle(height: double.minPositive),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(.5),
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: Color(0xFFD9DDEB),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(.5),
          ),
        ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 1,
            )),
        errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary.withOpacity(.2),
          fontSize: 8 * getScaleFactorFromWidth(context),
          fontFamily: 'SpoqaHanSans',
          fontWeight: FontWeight.w600,
        ),
        hintText: hintText,
      ),
    ),
  );
}
