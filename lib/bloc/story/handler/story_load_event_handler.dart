import 'package:ohmybooks_app/bloc/story/event/story_event.dart';
import 'package:ohmybooks_app/bloc/story/event/story_load_event.dart';
import 'package:ohmybooks_app/bloc/story/handler/story_event_handler.dart';
import 'package:ohmybooks_app/bloc/story/story_state.dart';
import 'package:ohmybooks_app/model/story_model.dart';
import 'package:ohmybooks_app/repository/story_repository.dart';

class StoryLoadEventHandler extends StoryEventHandler {
  @override
  handleEvent(
    StoryEvent event,
    emit, {
    StoryRepository? repository,
    StoryState? state,
  }) async {
    try {
      if (repository == null) {
        throw Error.safeToString("RepositoryInstanceNotFound");
      } else if (state == null) {
        throw Error.safeToString("StoryStateIsNotFound");
      }
      emit(StoryLoadingState(state.storys));
      event = event as StoryLoadEvent;
      final loadData = await repository.loadStoryData();
      emit(StoryLoadedState(loadData as List<StoryModel>));
    } catch (e) {
      rethrow;
    }
  }

  @override
  List<Object?> get props => [];
}
