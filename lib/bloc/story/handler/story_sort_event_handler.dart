import 'package:flutter/material.dart';
import 'package:ohmybooks_app/bloc/story/event/story_event.dart';
import 'package:ohmybooks_app/bloc/story/event/story_sort_event.dart';
import 'package:ohmybooks_app/bloc/story/handler/story_event_handler.dart';
import 'package:ohmybooks_app/bloc/story/story_state.dart';
import 'package:ohmybooks_app/model/story_model.dart';
import 'package:ohmybooks_app/repository/story_repository.dart';

class StorySortEventHandler extends StoryEventHandler {
  @override
  handleEvent(
    StoryEvent event,
    emit, {
    StoryRepository? repository,
    StoryState? state,
  }) {
    try {
      if (state == null) {
        throw Error.safeToString("StoryStateIsNotFound");
      }
      emit(StoryLoadingState(state.storys));

      event = event as StorySortEvent;
      List<StoryModel> newStroys = state.storys ?? [];

      switch (event.category) {
        case "title":
          int desc = event.desc ? 1 : -1;
          newStroys.sort((a, b) {
            String titleA = a.book.title!;
            String titleB = b.book.title!;
            return titleA.toLowerCase().compareTo(titleB.toLowerCase()) * desc;
          });
          break;
        case "date":
          int desc = event.desc ? 1 : -1;
          newStroys.sort((a, b) {
            var datetimeA = a.datetime.split(" ");
            var datetimeB = b.datetime.split(" ");

            var dateA = datetimeA[0].split("-");
            var dateB = datetimeB[0].split("-");

            int compareToDate = compareToInt(dateA, dateB);
            if (compareToDate == 0) {
              var timeA = datetimeA[1].split(":");
              var timeB = datetimeB[1].split(":");

              int compareToTime = compareToInt(timeA, timeB);
              return compareToTime * desc;
            }
            return compareToDate * desc;
          });
          break;
        default:
          throw Error.safeToString("NotValidCategory");
      }
      emit(StoryLoadedState(newStroys));
    } catch (e) {
      rethrow;
    }
  }

  int compareToInt(List<String> a, List<String> b) {
    if (int.parse(a[0]) > int.parse(b[0])) {
      return 1;
    } else if (int.parse(a[0]) < int.parse(b[0])) {
      return -1;
    } else {
      if (int.parse(a[1]) > int.parse(b[1])) {
        return 1;
      } else if (int.parse(a[1]) < int.parse(b[1])) {
        return -1;
      } else {
        if (int.parse(a[2]) > int.parse(b[2])) {
          return 1;
        } else if (int.parse(a[2]) < int.parse(b[2])) {
          return -1;
        } else {
          return 0;
        }
      }
    }
  }

  @override
  List<Object?> get props => [];
}
