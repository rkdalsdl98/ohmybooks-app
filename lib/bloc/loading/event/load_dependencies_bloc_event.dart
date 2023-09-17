import 'package:ohmybooks_app/bloc/loading/event/loading_event.dart';

class LoadingDependenciesBlocEvent extends LoadingEvent {
  List<Map<String, dynamic>> states;
  LoadingDependenciesBlocEvent(this.states);
  @override
  List<Object?> get props => [];
}
