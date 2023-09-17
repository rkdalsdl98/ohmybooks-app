import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ohmybooks_app/bloc/regist/regist_bloc.dart';
import 'package:ohmybooks_app/bloc/regist/regist_state.dart';
import 'package:ohmybooks_app/bloc/story/event/story_write_event.dart';
import 'package:ohmybooks_app/bloc/story/story_bloc.dart';
import 'package:ohmybooks_app/model/book_model.dart';
import 'package:ohmybooks_app/model/convert_style_model.dart';
import 'package:ohmybooks_app/model/story_model.dart';
import 'package:ohmybooks_app/system/dimensions.dart';
import 'package:ohmybooks_app/system/message.dart';
import 'package:ohmybooks_app/widget/detail/regist_story/deafult_background_selector.dart';
import 'package:ohmybooks_app/widget/detail/regist_story/font_style.dart';
import 'package:ohmybooks_app/widget/detail/regist_story/story_input_field.dart';
import 'package:ohmybooks_app/widget/detail/regist_story/story_preview.dart';
import 'package:ohmybooks_app/widget/global/long_rounded_button.dart';

class RegistStory extends StatefulWidget {
  final BookModel book;
  const RegistStory({super.key, required this.book});

  @override
  State<RegistStory> createState() => _RegistStoryState();
}

class _RegistStoryState extends State<RegistStory> {
  Color selColor = const Color(0xFFFFFFFF);

  writeStory(BuildContext context) {
    final registBloc = context.read<RegistBloc>();
    if (registBloc.getStoryText() == "") {
      initSnackBarMessage(context, "당신에 이야기를 적어주세요!");
      return;
    }
    final storyBloc = context.read<StoryBloc>();

    storyBloc.add(
      StoryWriteEvent(StoryModel(
        style: ConverStyleModel.fromStyle(registBloc.getStyle()),
        datetime: DateTime.now().toString(),
        imageUrl: registBloc.getImageUrl(),
        text: registBloc.getStoryText(),
        identifier: widget.book.isbn!,
        book: widget.book,
        backgroundOpacity: registBloc.getBGOpacity(),
      )),
    );
    Navigator.pop(context);
    initSnackBarMessage(context, "소중한 이야기가 생겻네요!");
  }

  @override
  Widget build(BuildContext context) {
    final deviceCrossAxisMode =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;
    final double scale = deviceCrossAxisMode ? .8 : 1.0;

    return BlocProvider<RegistBloc>(
      create: (_) => RegistBloc(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.only(
            top: 30,
            left: 10,
            right: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const DefaultBackgroundSelector(),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: (deviceCrossAxisMode ? 450 : 250) *
                      getScaleFactorFromHeight(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "글자 스타일",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 12 * getScaleFactorFromWidth(context),
                          fontFamily: 'SpoqaHanSans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const FontStyle(),
                    ],
                  ),
                ),
                const StoryPreview(),
                const StoryInputField(),
                BlocBuilder<RegistBloc, RegistState>(
                    builder: (builderContext, state) {
                  return LongRoundedButton(
                    text: "기록하기",
                    onPressEvent: () => writeStory(builderContext),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
