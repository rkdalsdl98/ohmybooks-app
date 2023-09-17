import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ohmybooks_app/bloc/story/event/story_sort_event.dart';
import 'package:ohmybooks_app/bloc/story/story_bloc.dart';
import 'package:ohmybooks_app/system/dimensions.dart';
import 'package:ohmybooks_app/widget/global/circle_button.dart';

class SortDialog extends StatefulWidget {
  const SortDialog({super.key});

  @override
  State<SortDialog> createState() => _SortDialogState();
}

class _SortDialogState extends State<SortDialog> {
  String showValue = "제목";
  String value = "title";
  bool asc = false;

  setValue(String? newValue) => setState(() {
        showValue = newValue!;
      });
  setSortBy(bool? isDesc) => setState(() {
        asc = isDesc!;
      });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 135),
      child: Container(
        height: 160 * getScaleFactorFromHeight(context),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "정렬기준",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 14 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w600,
              ),
            ),
            Center(
              child: DropdownButton<String>(
                padding: EdgeInsets.zero,
                items: ["제목", "날짜"]
                    .map<DropdownMenuItem<String>>(
                      (category) => DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      ),
                    )
                    .toList(),
                icon: Align(
                  alignment: Alignment.topLeft,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.play_arrow_rounded,
                      size: 10 * getScaleFactorFromWidth(context),
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(.2),
                    ),
                  ),
                ),
                onChanged: (v) {
                  switch (v) {
                    case "제목":
                      value = "title";
                      break;
                    case "날짜":
                      value = "date";
                      break;
                    default:
                      break;
                  }
                  setValue(v);
                },
                elevation: 0,
                underline: Container(
                    decoration: const BoxDecoration(border: Border())),
                alignment: Alignment.center,
                style: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(.5),
                  fontSize: 12 * getScaleFactorFromWidth(context),
                  fontFamily: 'SpoqaHanSans',
                  fontWeight: FontWeight.w600,
                ),
                value: showValue,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "오름차순",
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(.5),
                    fontSize: 10 * getScaleFactorFromWidth(context),
                    fontFamily: 'SpoqaHanSans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Transform.scale(
                  scale: 1,
                  child: CheckboxTheme(
                    data: const CheckboxThemeData(
                      splashRadius: 24,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Checkbox(
                      value: asc,
                      onChanged: setSortBy,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleButton(
                  text: "적용",
                  width: 45,
                  height: 22.5,
                  onPressEvent: () {
                    final bloc = context.read<StoryBloc>();
                    bloc.add(StorySortEvent(value, asc));
                    Navigator.pop(context);
                  },
                ),
                CircleButton(
                  text: "닫기",
                  width: 45,
                  height: 22.5,
                  onPressEvent: () => Navigator.pop(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
