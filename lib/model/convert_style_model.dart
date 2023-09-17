import 'package:flutter/material.dart';

Map<String, FontWeight> strToWeights = {
  "thin": FontWeight.w100,
  "light": FontWeight.w300,
  "regular": FontWeight.w400,
  "medium": FontWeight.w500,
  "semibold": FontWeight.w600,
  "bold": FontWeight.w700,
};

Map<FontWeight, String> fontWeightToStr = {
  FontWeight.w100: "thin",
  FontWeight.w300: "light",
  FontWeight.w400: "regular",
  FontWeight.w500: "medium",
  FontWeight.w600: "semibold",
  FontWeight.w700: "bold",
};

class ConverStyleModel {
  double? size, letterSpacing, wordSpacing, height, opacity;
  String? weight;
  List<dynamic>? color;

  ConverStyleModel({
    this.color,
    this.height,
    this.letterSpacing,
    this.size,
    this.weight,
    this.wordSpacing,
    this.opacity,
  });

  ConverStyleModel.fromStyle(TextStyle style)
      : size = style.fontSize,
        height = style.height,
        letterSpacing = style.letterSpacing,
        wordSpacing = style.wordSpacing,
        opacity = style.color?.opacity ?? 1,
        color = [style.color!.red, style.color!.green, style.color!.blue],
        weight = fontWeightToStr[style.fontWeight];

  ConverStyleModel.fromJson(Map<String, dynamic> json)
      : size = json['size'],
        letterSpacing = json['letterSpacing'],
        weight = json['weight'],
        wordSpacing = json['wordSpacing'],
        height = json['height'],
        color = json['color'],
        opacity = json['opacity'] ?? 1;

  Map<String, dynamic> toJson() => {
        "size": size,
        "letterSpacing": letterSpacing,
        "weight": weight,
        "wordSpacing": wordSpacing,
        "height": height,
        "color": color,
        "opacity": opacity,
      };

  TextStyle toStyle() => TextStyle(
        fontSize: size,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        height: height,
        color: Color.fromRGBO(color![0], color![1], color![2], opacity!),
        fontWeight: strToWeights[weight],
      );
}
