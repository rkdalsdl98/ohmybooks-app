import 'package:flutter/material.dart';
import 'package:ohmybooks_app/system/dimensions.dart';
import 'package:ohmybooks_app/system/message.dart';

onImageError(String error, BuildContext context) {
  error = error.trim();
  if (error.contains("RegistStateIsNotFound")) {
    initSnackBarMessage(context, "이미지를 가져오는데 실패 했습니다");
  } else if (error.contains("PathNotFoundException") ||
      error.contains("Asset not found")) {
  } else {
    initSnackBarErrorMessage(
        context, "알 수 없는 오류", "알 수 없는 오류가 발생했습니다\n해당 오류 발생경로와 함께 문의해주세요");
  }
}

Widget handleImageError(
  BuildContext context,
  Object error,
  StackTrace? stackTrace,
) {
  onImageError(error.toString(), context);
  return Container(
    width: 160 * getScaleFactorFromWidth(context),
    height: 90 * getScaleFactorFromHeight(context),
    decoration: const BoxDecoration(
      color: Color(0xFFD6D6D6),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image,
            color: Colors.black.withOpacity(.5),
            size: 20 * getScaleFactorFromHeight(context),
          ),
          Text(
            "이미지가 존재하지 않습니다",
            style: TextStyle(
              color: Theme.of(context).colorScheme.shadow,
              fontSize: 8 * getScaleFactorFromWidth(context),
              fontFamily: 'SpoqaHanSans',
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    ),
  );
}
