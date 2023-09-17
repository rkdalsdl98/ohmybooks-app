import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ohmybooks_app/bloc/story/story_bloc.dart';
import 'package:ohmybooks_app/model/book_model.dart';
import 'package:ohmybooks_app/system/dimensions.dart';
import 'package:ohmybooks_app/view/regist_story.dart';
import 'package:ohmybooks_app/widget/detail/story_item.dart';
import 'package:ohmybooks_app/widget/global/rounded_button.dart';

class Story extends StatelessWidget {
  final BookModel book;
  EdgeInsetsGeometry padding;

  Story({
    super.key,
    required this.deviceHeight,
    required this.deviceCrossAxisMode,
    required this.book,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  });

  final double deviceHeight;
  final bool deviceCrossAxisMode;

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<StoryBloc>();
    final story = bloc.getStory(book.isbn!);
    return SizedBox(
      width: double.maxFinite,
      height: deviceHeight / 2 - 15,
      child: Column(
        mainAxisAlignment:
            story == null ? MainAxisAlignment.center : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: padding,
            child: Text(
              "책을 읽고 난 나의 이야기",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 12 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Center(
            child: story == null
                ? emptyStoryHelper(context)
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: StoryItem(story: story),
                  ),
          ),
        ],
      ),
    );
  }

  Widget emptyStoryHelper(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "아직 등록한 이야기가 없으시군요?\n책을 읽으며 느낀 감정, 내 생각들을 사진과 함께\n기록 해보면 어떨까요?",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
            fontSize: (deviceCrossAxisMode ? 12 : 16) *
                getScaleFactorFromWidth(context),
            fontFamily: 'SpoqaHanSans',
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20 * getScaleFactorFromHeight(context)),
        RoundedButton(
          text: "내 이야기 기록하기",
          width: deviceCrossAxisMode ? 180 : 160,
          onPressEvent: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider<StoryBloc>.value(
                  value: context.read<StoryBloc>(),
                  child: RegistStory(book: book),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
