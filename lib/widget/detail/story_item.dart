import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ohmybooks_app/model/story_model.dart';
import 'package:ohmybooks_app/system/dimensions.dart';

class StoryItem extends StatelessWidget {
  final StoryModel story;
  BoxFit fit;

  StoryItem({
    super.key,
    required this.story,
    this.fit = BoxFit.fitWidth,
  });

  @override
  Widget build(BuildContext context) {
    final deviceCrossAxisMode =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;
    final double scale = deviceCrossAxisMode ? .8 : .9;

    TextStyle style = story.style.toStyle();
    List<String> image = story.imageUrl.split(":");

    String category = image[0];
    String path = image[1];

    return Container(
      width: 360 * getScaleFactorFromWidth(context),
      height: 202.5 * getScaleFactorFromHeight(context),
      decoration: BoxDecoration(
        image: path == "null"
            ? null
            : category == "asset"
                ? DecorationImage(
                    image: AssetImage(path),
                    fit: fit,
                    opacity: story.backgroundOpacity,
                  )
                : DecorationImage(
                    image: FileImage(File(path)),
                    fit: BoxFit.fitWidth,
                    opacity: story.backgroundOpacity,
                  ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: SizedBox(
            width: 300 * getScaleFactorFromWidth(context),
            height: 150 * getScaleFactorFromHeight(context),
            child: Center(
              child: Text(
                story.text,
                style: style,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
