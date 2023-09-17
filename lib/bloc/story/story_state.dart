import 'package:ohmybooks_app/bloc/interface/i_bloc_state.dart';
import 'package:ohmybooks_app/model/story_model.dart';

abstract class StoryState extends IBlocState {
  List<StoryModel>? storys;
  StoryState(this.storys);
}

class StoryInitState extends StoryState {
  StoryInitState() : super([]);
  @override
  List<Object?> get props => [storys];
}

class StoryLoadingState extends StoryState {
  StoryLoadingState(super.storys);

  @override
  List<Object?> get props => [storys];
}

class StoryLoadedState extends StoryState {
  StoryLoadedState(super.storys);

  @override
  List<Object?> get props => [storys];
}

class StoryErrorState extends StoryState {
  final String errorMessage;

  StoryErrorState(this.errorMessage, super.storys);

  @override
  List<Object?> get props => [errorMessage];
}
