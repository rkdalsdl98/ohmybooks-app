import 'package:flutter/material.dart';
import 'package:ohmybooks_app/system/dimensions.dart';

class CircleButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  Function()? onPressEvent;

  CircleButton({
    super.key,
    required this.width,
    required this.height,
    required this.text,
    this.onPressEvent,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(180),
      onTap: onPressEvent,
      child: Container(
        width: width * getScaleFactorFromWidth(context),
        height: height * getScaleFactorFromWidth(context),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(180),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 4,
                color: Theme.of(context).colorScheme.shadow.withOpacity(.25)),
          ],
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 10 * getScaleFactorFromWidth(context),
              fontFamily: 'SpoqaHanSans',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
