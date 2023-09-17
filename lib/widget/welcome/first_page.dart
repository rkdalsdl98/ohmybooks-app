import 'package:flutter/material.dart';
import 'package:ohmybooks_app/system/dimensions.dart';
import 'package:ohmybooks_app/widget/global/long_rounded_button.dart';

class WelcomeFirstPage extends StatelessWidget {
  final Function() onPressButtonEvent;

  const WelcomeFirstPage({
    super.key,
    required this.onPressButtonEvent,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "OhMyBooks!",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 32 * getScaleFactorFromWidth(context),
                  fontFamily: 'SpoqaHanSans',
                  fontWeight: FontWeight.w600,
                  shadows: [
                    BoxShadow(
                      blurRadius: 4,
                      offset: const Offset(4, 4),
                      color:
                          Theme.of(context).colorScheme.shadow.withOpacity(.25),
                    ),
                  ],
                ),
              ),
              Text(
                "나만의 작은 책장을 만들어 보시겠어요?",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 16 * getScaleFactorFromWidth(context),
                  fontFamily: 'SpoqaHanSans',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: LongRoundedButton(
            text: "네",
            onPressEvent: onPressButtonEvent,
          ),
        ),
      ],
    );
  }
}
