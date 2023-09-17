import 'package:ohmybooks_app/bloc/story/event/story_event.dart';
import 'package:ohmybooks_app/model/story_model.dart';

class StoryWriteEvent extends StoryEvent {
  final StoryModel story;
  StoryWriteEvent(this.story);
  @override
  List<Object?> get props => [];
}
