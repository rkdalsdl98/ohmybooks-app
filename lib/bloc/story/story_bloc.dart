import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ohmybooks_app/bloc/story/event/story_event.dart';
import 'package:ohmybooks_app/bloc/story/event/story_load_event.dart';
import 'package:ohmybooks_app/bloc/story/event/story_sort_event.dart';
import 'package:ohmybooks_app/bloc/story/event/story_write_event.dart';
import 'package:ohmybooks_app/bloc/story/handler/story_load_event_handler.dart';
import 'package:ohmybooks_app/bloc/story/handler/story_sort_event_handler.dart';
import 'package:ohmybooks_app/bloc/story/handler/story_write_event_handler.dart';
import 'package:ohmybooks_app/bloc/story/story_state.dart';
import 'package:ohmybooks_app/model/story_model.dart';
import 'package:ohmybooks_app/repository/story_repository.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  final StoryRepository repository;
  StoryBloc(this.repository) : super(StoryInitState()) {
    on<StoryLoadEvent>(
      (event, emit) async {
        await loadStoryData(event, emit);
      },
      transformer: sequential(),
    );
    on<StoryWriteEvent>(
      (event, emit) async {
        if (state is StoryLoadingState) {
          return;
        }
        await saveStoryData(event, emit);
      },
      transformer: restartable(),
    );
    on<StorySortEvent>(
      (event, emit) {
        if (state is StoryLoadingState) {
          return;
        }
        sortStorys(event, emit);
      },
      transformer: restartable(),
    );

    add(StoryLoadEvent());
  }

  getStateIsLoaded() => {
        "name": "StoryBloc",
        "isLoaded": state is StoryLoadedState,
      };

  loadStoryData(StoryEvent event, emit) async {
    try {
      await StoryLoadEventHandler().handleEvent(
        event,
        emit,
        repository: repository,
        state: state,
      );
    } catch (e) {
      var str = e.toString().trim();
      if (str.contains("RepositoryInstanceNotFound")) {
        emit(StoryErrorState("RepositoryInstanceNotFound", state.storys));
      } else if (str.contains("StoryStateIsNotFound")) {
        emit(StoryErrorState("StoryStateIsNotFound", const <StoryModel>[]));
      } else {
        emit(StoryErrorState("UnknownException", state.storys));
      }
    }
  }

  saveStoryData(StoryEvent event, emit) async {
    try {
      await StoryWriteEventHandler().handleEvent(
        event,
        emit,
        repository: repository,
        state: state,
      );
    } catch (e) {
      var str = e.toString().trim();
      if (str.contains("RepositoryInstanceNotFound")) {
        emit(StoryErrorState("RepositoryInstanceNotFound", state.storys));
      } else if (str.contains("StoryStateIsNotFound")) {
        emit(StoryErrorState("StoryStateIsNotFound", const <StoryModel>[]));
      } else {
        emit(StoryErrorState("UnknownException", state.storys));
      }
    }
  }

  sortStorys(StoryEvent event, emit) async {
    try {
      await StorySortEventHandler().handleEvent(
        event,
        emit,
        repository: repository,
        state: state,
      );
    } catch (e) {
      var str = e.toString().trim();
      if (str.contains("StoryStateIsNotFound")) {
        emit(StoryErrorState("StoryStateIsNotFound", const <StoryModel>[]));
      } else if (str.contains("NotValidCategory")) {
        emit(StoryErrorState("NotValidCategory", const <StoryModel>[]));
      } else {
        emit(StoryErrorState("UnknownException", state.storys));
      }
    }
  }

  StoryModel? getStory(String isbn) {
    StoryModel? story;
    for (int i = 0; i < state.storys!.length; ++i) {
      if (state.storys![i].identifier == isbn) {
        story = state.storys![i];
        break;
      }
    }
    return story;
  }
}
