import 'package:flutter/material.dart';
import 'package:ohmybooks_app/system/dimensions.dart';

class FontStyleWeight extends StatelessWidget {
  final Function({
    Color? color,
    double? size,
    FontWeight? weight,
    double? height,
    double? wordSpacing,
    double? letterSpacing,
  }) onChangeStyle;

  const FontStyleWeight({
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
            "굵기 선택",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 10 * getScaleFactorFromWidth(context),
              fontFamily: 'SpoqaHanSans',
              fontWeight: FontWeight.w700,
            ),
          ),
          InkWell(
            onTap: () => onChangeStyle(weight: FontWeight.w100),
            child: Text(
              "Thin",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 10 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
          InkWell(
            onTap: () => onChangeStyle(weight: FontWeight.w300),
            child: Text(
              "Light",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 10 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          InkWell(
            onTap: () => onChangeStyle(weight: FontWeight.w400),
            child: Text(
              "Regular",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 10 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          InkWell(
            onTap: () => onChangeStyle(weight: FontWeight.w500),
            child: Text(
              "Medium",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 10 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          InkWell(
            onTap: () => onChangeStyle(weight: FontWeight.w600),
            child: Text(
              "Semibold",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 10 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          InkWell(
            onTap: () => onChangeStyle(weight: FontWeight.w700),
            child: Text(
              "Bold",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 10 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
