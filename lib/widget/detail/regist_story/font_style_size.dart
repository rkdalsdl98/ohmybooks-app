import 'package:flutter/material.dart';
import 'package:ohmybooks_app/system/dimensions.dart';

class FontStyleSize extends StatelessWidget {
  final Function({
    Color? color,
    double? size,
    FontWeight? weight,
    double? height,
    double? wordSpacing,
    double? letterSpacing,
  }) onChangeStyle;

  const FontStyleSize({
    super.key,
    required this.onChangeStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150 * getScaleFactorFromHeight(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "크기 선택",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 10 * getScaleFactorFromWidth(context),
              fontFamily: 'SpoqaHanSans',
              fontWeight: FontWeight.w700,
            ),
          ),
          InkWell(
            onTap: () =>
                onChangeStyle(size: 8 * getScaleFactorFromWidth(context)),
            child: Text(
              "작게",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 8 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          InkWell(
            onTap: () =>
                onChangeStyle(size: 10 * getScaleFactorFromWidth(context)),
            child: Text(
              "조금 작게",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 10 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          InkWell(
            onTap: () =>
                onChangeStyle(size: 12 * getScaleFactorFromWidth(context)),
            child: Text(
              "중간",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 12 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          InkWell(
            onTap: () =>
                onChangeStyle(size: 14 * getScaleFactorFromWidth(context)),
            child: Text(
              "조금 크게",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 14 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          InkWell(
            onTap: () =>
                onChangeStyle(size: 16 * getScaleFactorFromWidth(context)),
            child: Text(
              "크게",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 16 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
