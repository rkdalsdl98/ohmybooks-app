import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ohmybooks_app/system/dimensions.dart';

initSnackBarErrorMessage(BuildContext context, String message, String error) {
  Future.delayed(Duration.zero).then((_) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        backgroundColor: Theme.of(context).colorScheme.onErrorContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
        content: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.errorContainer,
                  fontWeight: FontWeight.w500,
                  fontSize: 13 * getScaleFactorFromHeight(context),
                  fontFamily: 'SpoqaHanSans',
                ),
              ),
              Text(
                error,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 10 * getScaleFactorFromHeight(context),
                  fontFamily: 'SpoqaHanSans',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  });
}

initSnackBarMessage(BuildContext context, String message, {Icon? icon}) {
  Future.delayed(Duration.zero).then((_) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 3000),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.w500,
                fontSize: 13 * getScaleFactorFromHeight(context),
                fontFamily: 'SpoqaHanSans',
              ),
            ),
            if (icon != null)
              SizedBox(width: 10 * getScaleFactorFromWidth(context)),
            if (icon != null) icon,
          ],
        ),
      ),
    );
  });
}

initWillPopMessage(
  BuildContext context, {
  VoidCallback? onAllow,
}) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text(
        '앱을 완전히 종료 하시겠습니까?',
        style: TextStyle(
          fontSize: 14,
          fontFamily: 'SpoqaHanSans',
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            '예',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 10 * getScaleFactorFromWidth(context),
              fontFamily: 'SpoqaHanSans',
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () => onAllow ?? exit(0),
        ),
        TextButton(
          child: Text(
            '아니오',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 10 * getScaleFactorFromWidth(context),
              fontFamily: 'SpoqaHanSans',
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}
