import 'package:flutter/material.dart';
import 'package:ohmybooks_app/system/dimensions.dart';

class RoundedButton extends StatelessWidget {
  double? width;
  double? height;
  final String text;
  Function()? onPressEvent;

  RoundedButton({
    super.key,
    required this.text,
    this.width,
    this.height,
    this.onPressEvent,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressEvent,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: (width ?? 60) * getScaleFactorFromWidth(context),
        height: (height ?? 30) * getScaleFactorFromWidth(context),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              offset: const Offset(0, 4),
              color: Theme.of(context).colorScheme.shadow.withOpacity(.5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 8 * getScaleFactorFromWidth(context),
              fontFamily: 'SpoqaHanSans',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
