import 'package:flutter/material.dart';
import 'package:ohmybooks_app/system/dimensions.dart';
import 'package:ohmybooks_app/widget/global/long_rounded_button.dart';

class WelcomeSecondPage extends StatelessWidget {
  const WelcomeSecondPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "참고사항",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 32 * getScaleFactorFromWidth(context),
                    fontFamily: 'SpoqaHanSans',
                    fontWeight: FontWeight.w600,
                    shadows: [
                      BoxShadow(
                        blurRadius: 4,
                        offset: const Offset(4, 4),
                        color: Theme.of(context)
                            .colorScheme
                            .shadow
                            .withOpacity(.25),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: RichText(
                    text: TextSpan(
                      text:
                          "기기당 검색, 목록 불러오기 등등\n데이터를 불러오는 기능은 일일 100회로\n제한 되어있습니다.\n\n\n",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 18 * getScaleFactorFromWidth(context),
                        fontFamily: 'SpoqaHanSans',
                        fontWeight: FontWeight.w400,
                      ),
                      children: const [
                        TextSpan(
                          text:
                              "담아 둔 책들을 책장 탭에서 확인이 가능하며,\n선택한 책의 연관페이지로 이동이 가능합니다.\n\n\n",
                        ),
                        TextSpan(
                          text:
                              "어플을 삭제 할 경우 모든 정보가 초기화 되니\n이 점을 참고하면서 사용해주세요.\n\n\n",
                        ),
                        TextSpan(
                          text: "나의 기록은 가독성을 위해 색상을 제외한 스타일만 적용 됩니다.\n\n\n",
                        ),
                        TextSpan(
                          text: "한 번 작성한 나의 이야기는 수정, 삭제가\n불가능 합니다.",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: LongRoundedButton(
            text: "시작하기",
            onPressEvent: () => Navigator.pushNamedAndRemoveUntil(
                context, "/home", (_) => false),
          ),
        ),
      ],
    );
  }
}
