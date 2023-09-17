import 'package:flutter/material.dart';
import 'package:ohmybooks_app/model/story_model.dart';
import 'package:ohmybooks_app/system/dimensions.dart';
import 'package:ohmybooks_app/view/home.dart';
import 'package:ohmybooks_app/widget/global/book.dart';
import 'package:ohmybooks_app/widget/global/rounded_button.dart';
import 'package:ohmybooks_app/widget/home/history/anim_story_text.dart';
import 'package:ohmybooks_app/widget/home/history/history_line.dart';

class HistoryItem extends StatelessWidget {
  final StoryModel story;

  const HistoryItem({
    super.key,
    required this.story,
  });

  String convertTime(List<String> time) {
    int? hour = int.tryParse(time[0]);
    int? minute = int.tryParse(time[1]);
    if (hour == null || minute == null) {
      throw Error.safeToString("NotValidArguments");
    }

    bool isAM = hour - 12 <= 0;
    String hourStr = "${isAM ? hour : (hour - 12)}";

    return "$hourStr : ${"$minute".padLeft(2, "0")} ${isAM ? "AM" : "PM"}";
  }

  @override
  Widget build(BuildContext context) {
    final datetime = story.datetime.split(" ");
    final date = datetime[0];
    final time = convertTime(datetime[1].split(":"));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const HistoryLine(animSeconds: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: "$date\n",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 10 * getScaleFactorFromWidth(context),
                      fontFamily: 'SpoqaHanSans',
                      fontWeight: FontWeight.w600,
                    ),
                    children: [TextSpan(text: time)],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  height: 300 *
                      getScaleFactorFromHeight(
                        context,
                        bottomNavigatorHeight: bottomNavigatorHeight,
                      ),
                  child: SingleChildScrollView(
                    child: AnimStoryText(
                      text: story.text,
                      style: story.style.toStyle(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 100),
            width: 140 * getScaleFactorFromWidth(context),
            height: 450 *
                getScaleFactorFromHeight(
                  context,
                  bottomNavigatorHeight: bottomNavigatorHeight,
                ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Book(
                  thumbnail: story.book.thumbnail!,
                  isbn: story.book.isbn!,
                  width: 160,
                ),
                SizedBox(
                  width: 120 * getScaleFactorFromWidth(context),
                  height: 40 * getScaleFactorFromHeight(context),
                  child: Center(
                    child: Text(
                      story.book.title!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 8 * getScaleFactorFromWidth(context),
                        fontFamily: 'SpoqaHanSans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                RoundedButton(
                  text: "자세한 정보 보기",
                  height: 30,
                  width: 120,
                  onPressEvent: () => Navigator.pushNamed(
                    context,
                    "/detail",
                    arguments: {"data": story.book.toJson()},
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
