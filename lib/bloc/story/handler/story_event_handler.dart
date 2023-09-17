import 'package:equatable/equatable.dart';
import 'package:ohmybooks_app/bloc/story/event/story_event.dart';
import 'package:ohmybooks_app/bloc/story/story_state.dart';
import 'package:ohmybooks_app/repository/story_repository.dart';

abstract class StoryEventHandler extends Equatable {
  handleEvent(
    StoryEvent event,
    dynamic emit, {
    StoryRepository? repository,
    StoryState? state,
  }) {}
}
