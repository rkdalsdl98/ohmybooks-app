import 'package:ohmybooks_app/bloc/story/event/story_event.dart';

class StorySortEvent extends StoryEvent {
  final String category;
  final bool desc;
  StorySortEvent(this.category, this.desc);
  @override
  List<Object?> get props => [category, desc];
}
