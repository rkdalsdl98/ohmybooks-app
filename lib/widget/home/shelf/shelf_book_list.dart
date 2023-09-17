import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ohmybooks_app/bloc/shelf/event/shelf_remove_event.dart';
import 'package:ohmybooks_app/bloc/shelf/shelf_bloc.dart';
import 'package:ohmybooks_app/bloc/shelf/shelf_state.dart';
import 'package:ohmybooks_app/model/book_model.dart';
import 'package:ohmybooks_app/system/dimensions.dart';
import 'package:ohmybooks_app/system/message.dart';
import 'package:ohmybooks_app/view/home.dart';
import 'package:ohmybooks_app/widget/global/book.dart';
import 'package:ohmybooks_app/widget/global/circle_button.dart';

class ShelfBookList extends StatelessWidget {
  const ShelfBookList({
    super.key,
  });

  removeBook(BuildContext context, BookModel book) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 80),
        child: Container(
          padding: const EdgeInsets.all(10),
          clipBehavior: Clip.hardEdge,
          width: double.maxFinite,
          height: 120 * getScaleFactorFromWidth(context),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 4,
                color: Theme.of(context).colorScheme.shadow.withOpacity(.25),
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "보관함에서 지우기",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.shadow,
                  fontSize: 12 * getScaleFactorFromWidth(context),
                  fontFamily: 'SpoqaHanSans',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "이 책을 보관함에서 지우시겠어요?",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.shadow,
                  fontSize: 10 * getScaleFactorFromWidth(context),
                  fontFamily: 'SpoqaHanSans',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Spacer(),
                  CircleButton(
                    width: 60,
                    height: 30,
                    text: "확인",
                    onPressEvent: () {
                      final bloc = context.read<ShelfBloc>();
                      bloc.add(ShelfRemoveEvent(book));
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  CircleButton(
                    width: 60,
                    height: 30,
                    text: "닫기",
                    onPressEvent: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = 60 * getScaleFactorFromWidth(context);
    final height = 82.19 *
        getScaleFactorFromHeight(
          context,
          bottomNavigatorHeight: bottomNavigatorHeight,
        );
    final List<Alignment> alignments = [
      Alignment.center,
      Alignment.centerLeft,
      Alignment.centerRight,
      Alignment.bottomCenter,
      Alignment.bottomLeft,
      Alignment.bottomRight,
      Alignment.topCenter,
      Alignment.topLeft,
      Alignment.topRight,
    ];

    final deviceCrossAxisMode =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;
    final EdgeInsetsGeometry padding = deviceCrossAxisMode
        ? const EdgeInsets.symmetric(horizontal: 40, vertical: 40)
        : const EdgeInsets.symmetric(horizontal: 20, vertical: 40);

    return BlocBuilder<ShelfBloc, ShelfState>(
      builder: (builderContext, state) {
        final items = state.shelfItems;
        if (state is ShelfInitState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ShelfLoadingState || state is ShelfLoadedState) {
          return items!.isEmpty
              ? emptyShelfText(context)
              : GridView.builder(
                  padding: padding,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: deviceCrossAxisMode ? 4 : 2,
                    mainAxisSpacing: 48,
                    crossAxisSpacing: 16,
                    childAspectRatio: width / height,
                  ),
                  itemBuilder: (_, index) => Align(
                    alignment: alignments[Random().nextInt(8)],
                    child: GestureDetector(
                      onLongPress: () => removeBook(context, items[index]),
                      onTap: () => Navigator.pushNamed(
                        builderContext,
                        "/detail",
                        arguments: {"data": items[index].toJson()},
                      ),
                      child: Book(
                        rotate: ((index + 1) % 3).toDouble(),
                        isbn: items[index].isbn!,
                        thumbnail: items[index].thumbnail ?? "",
                        width: 90,
                        height: 126.29,
                        errorIconSize: 16,
                      ),
                    ),
                  ),
                  itemCount: items.length,
                );
        } else {
          state = state as ShelfErrorState;
          return errorShelfText(builderContext, state.errorMessage);
        }
      },
    );
  }
}

Widget emptyShelfText(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: 200 *
          getScaleFactorFromHeight(
            context,
            bottomNavigatorHeight: bottomNavigatorHeight,
          ),
    ),
    child: Center(
      child: Text(
        "책장에 무언갈 억지로 담으려 하지 마세요\n무조건 채워야만 하는 것이 아니랍니다 :)",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground.withOpacity(.8),
          fontSize: 12 * getScaleFactorFromWidth(context),
          fontFamily: 'SpoqaHanSans',
          fontWeight: FontWeight.w300,
        ),
      ),
    ),
  );
}

Widget errorShelfText(BuildContext context, String error) {
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
        text: "$error\n\n",
        children: [
          TextSpan(
            text:
                "정보를 가져오는데 실패했습니다.\n앱 재실행 이후에도 같은 현상이 계속 발생한다면,\n해당 상황과 상단에 에러를 포함해 문의해주세요.",
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
