import 'package:flutter/material.dart';

const int baseViewPortWidth = 360;
const int baseViewPortHeight = 640;

double getScaleFactorFromWidth(BuildContext context) {
  final double deviceWidth = MediaQuery.of(context).size.width;
  return deviceWidth / baseViewPortWidth;
}

double getScaleFactorFromHeight(
  BuildContext context, {
  double? bottomNavigatorHeight,
}) {
  final double deviceHeight = MediaQuery.of(context).size.height;
  return (deviceHeight - (bottomNavigatorHeight ?? 0)) / baseViewPortHeight;
}
