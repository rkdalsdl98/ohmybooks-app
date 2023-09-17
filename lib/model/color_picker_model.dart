import 'package:flutter/material.dart';

class ColorPickerModel {
  int index;
  Color color;

  ColorPickerModel({
    required this.index,
    required this.color,
  });

  ColorPickerModel copyWith({
    int? index,
    Color? color,
  }) {
    return ColorPickerModel(
      index: index ?? this.index,
      color: color ?? this.color,
    );
  }

  ColorPickerModel.fromJson(Map<String, dynamic> json)
      : index = json['index'],
        color = json['color'];

  Map<String, dynamic> toJson() => {
        "index": index,
        "color": color,
      };
}

const List<List<int>> baseColors = [
  [244, 67, 54],
  [233, 30, 99],
  [255, 87, 34],
  [255, 152, 0],
  [255, 193, 7],
  [255, 235, 59],
  [139, 195, 74],
  [76, 175, 80],
  [0, 150, 136],
  [0, 188, 212],
  [3, 169, 244],
  [33, 150, 243],
  [33, 64, 243],
  [156, 39, 176],
  [103, 58, 183],
  [206, 206, 206],
  [100, 100, 100],
  [49, 49, 49],
];

class ColorType {
  final List<int> rgb;
  ColorType(this.rgb);
}
