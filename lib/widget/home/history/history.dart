import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ohmybooks_app/bloc/story/story_bloc.dart';
import 'package:ohmybooks_app/bloc/story/story_state.dart';
import 'package:ohmybooks_app/system/dimensions.dart';
import 'package:ohmybooks_app/view/home.dart';
import 'package:ohmybooks_app/widget/home/history/history_item.dart';
import 'package:ohmybooks_app/widget/home/history/sort_dialog.dart';

class History extends StatelessWidget {
  const History({super.key});

  sortHistory(BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) => const SortDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 40),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "나의 기록",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 24 * getScaleFactorFromWidth(context),
                  fontFamily: 'SpoqaHanSans',
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                onPressed: () => sortHistory(context),
                icon: Icon(
                  Icons.sort,
                  size: 16 * getScaleFactorFromWidth(context),
                ),
              ),
            ],
          ),
          SizedBox(
              height: 45 *
                  getScaleFactorFromHeight(
                    context,
                    bottomNavigatorHeight: bottomNavigatorHeight,
                  )),
          Expanded(
            child: BlocBuilder<StoryBloc, StoryState>(
              builder: (_, state) {
                final storys = state.storys;
                if (state is StoryInitState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is StoryLoadingState ||
                    state is StoryLoadedState) {
                  return storys == null || storys.isEmpty
                      ? emptyHistoryText(context)
                      : PageView.builder(
                          scrollDirection: Axis.vertical,
                          itemBuilder: (_, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: HistoryItem(story: storys[index]),
                          ),
                          itemCount: storys.length,
                        );
                } else {
                  state = state as StoryErrorState;
                  return errorHistoryText(context, state.errorMessage);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget emptyHistoryText(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: 200 *
          getScaleFactorFromHeight(
            context,
            bottomNavigatorHeight: bottomNavigatorHeight,
          ),
    ),
    child: Text(
      "아직 등록한 이야기가 없으시군요?\n보관함에서 기록할 책을 선택하고\n책을 읽으며 느낀 감정, 내 생각들을 사진과 함께\n기록 해보면 어떨까요?",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
        fontSize: 12 * getScaleFactorFromWidth(context),
        fontFamily: 'SpoqaHanSans',
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}

Widget errorHistoryText(BuildContext context, String error) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: 200 *
          getScaleFactorFromHeight(
            context,
            bottomNavigatorHeight: bottomNavigatorHeight,
          ),
    ),
    child: RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        text: "$error\n\n",
        children: [
          TextSpan(
            text:
                "정보를 가져오는데 실패했습니다.\n앱 재실행 이후에도 같은 현상이 계속 발생한다면,\n해당 상황과 상단에 에러를 포함해 문의해주세요.",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
              fontSize: 12 * getScaleFactorFromWidth(context),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
        style: TextStyle(
          color: Theme.of(context).colorScheme.errorContainer,
          fontSize: 14 * getScaleFactorFromWidth(context),
          fontFamily: 'SpoqaHanSans',
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
