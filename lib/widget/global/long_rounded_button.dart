import 'package:flutter/material.dart';
import 'package:ohmybooks_app/system/dimensions.dart';

class LongRoundedButton extends StatelessWidget {
  Function()? onPressEvent;
  Function()? onLongPressEvent;
  final String text;

  LongRoundedButton({
    super.key,
    this.onPressEvent,
    this.onLongPressEvent,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressEvent,
      onLongPress: onLongPressEvent,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        width: double.maxFinite,
        height: 30 * getScaleFactorFromHeight(context),
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
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 12 * getScaleFactorFromWidth(context),
              fontFamily: 'SpoqaHanSans',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
