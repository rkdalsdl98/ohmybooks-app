import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ohmybooks_app/bloc/shelf/shelf_bloc.dart';
import 'package:ohmybooks_app/bloc/shelf/shelf_state.dart';
import 'package:ohmybooks_app/system/dimensions.dart';
import 'package:ohmybooks_app/system/message.dart';
import 'package:ohmybooks_app/widget/global/circle_button.dart';
import 'package:ohmybooks_app/widget/home/shelf/select_background_dialog.dart';
import 'package:ohmybooks_app/widget/home/shelf/shelf_book_list.dart';

class Shelf extends StatefulWidget {
  final Function() hiddenBottomNavigationBar;

  const Shelf({
    super.key,
    required this.hiddenBottomNavigationBar,
  });

  @override
  State<Shelf> createState() => _ShelfState();
}

class _ShelfState extends State<Shelf> {
  bool hiddenMenu = false;

  selectBackgroundImage() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (builderContext) => SelectBackgroundDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<ShelfBloc, ShelfState>(builder: (_, state) {
          return state.backgroundImage == "" || state.backgroundImage == null
              ? const SizedBox()
              : Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Image(
                    image: AssetImage(state.backgroundImage!),
                    fit: BoxFit.fitWidth,
                    errorBuilder: (context, error, stackTrace) {
                      initSnackBarErrorMessage(context, "이미지 로드 에러",
                          "이미지를 로드하는데 실패 했습니다\n앱을 종료한 이후 다시 실행해도 같은 현상이 반복되면\n해당 현상 발생 경로와 함께 문의해주세요");
                      return Align(
                        alignment: Alignment.center,
                        child: Text(
                          "이미지를 로드 하는데 실패 했습니다",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 12 * getScaleFactorFromWidth(context),
                            fontFamily: 'SpoqaHanSans',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  ),
                );
        }),
        const ShelfBookList(),
        Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              "등록된 책을 누르고 있으면 삭제 화면이 나옵니다.\n책장에 책을 삭제 해도 등록한 이야기는 사라지지 않습니다.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 8 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                child: CircleButton(
                  width: 60,
                  height: 30,
                  text: "배경선택",
                  onPressEvent: selectBackgroundImage,
                ),
              ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
              //   child: CircleButton(
              //     width: 60,
              //     height: 30,
              //     text: hiddenMenu ? "메뉴 보이기" : "메뉴 숨기기",
              //     onPressEvent: () {
              //       hiddenMenu = !hiddenMenu;
              //       widget.hiddenBottomNavigationBar();
              //       setState(() {});
              //     },
              //   ),
              // ),
            ],
          ),
        )
      ],
    );
  }
}
