import 'package:ohmybooks_app/bloc/loading/event/load_dependencies_bloc_event.dart';
import 'package:ohmybooks_app/bloc/loading/event/loading_event.dart';
import 'package:ohmybooks_app/bloc/loading/handler/loading_event_handler.dart';
import 'package:ohmybooks_app/bloc/loading/loading_bloc_state.dart';

class LoadDependenciesBlocEventHandler extends LoadingEventHandler {
  @override
  handlerEvent(
    LoadingEvent event,
    emit,
    LoadingState state,
  ) {
    try {
      emit(DependenciesBlocLoadingState(state.loadedDependenciesBlocCounts));
      event = event as LoadingDependenciesBlocEvent;

      int counts = 0;

      for (var v in event.states) {
        if (v['isLoaded'] == true) {
          ++counts;
        }
      }
      emit(DependenciesBlocLoadedState(counts));
    } catch (e) {
      rethrow;
    }
  }

  @override
  List<Object?> get props => [];
}
