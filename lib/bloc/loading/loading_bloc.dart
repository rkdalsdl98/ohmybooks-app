import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ohmybooks_app/bloc/loading/event/change_is_beginner_event.dart';
import 'package:ohmybooks_app/bloc/loading/event/load_dependencies_bloc_event.dart';
import 'package:ohmybooks_app/bloc/loading/event/loading_event.dart';
import 'package:ohmybooks_app/bloc/loading/handler/load_dependencies_bloc_event_handler.dart';
import 'package:ohmybooks_app/bloc/loading/loading_bloc_state.dart';
import 'package:ohmybooks_app/repository/loading_respository.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  final LoadingRepository repository;

  LoadingBloc(this.repository) : super(InitializeState()) {
    on<LoadingDependenciesBlocEvent>(
      (event, emit) {
        checkDependenciesBlocIsLoaded(event, emit);
      },
      transformer: droppable(),
    );
    on<ChangeIsBeginnerEvent>(
      (event, emit) => changeIsBeginner(event, emit),
      transformer: droppable(),
    );
  }

  getIsBeginner() async => await repository.isBeginner();
  checkDependenciesBlocIsLoaded(LoadingEvent event, emit) {
    try {
      LoadDependenciesBlocEventHandler().handlerEvent(event, emit, state);
    } catch (e) {
      emit(InitializeFailedState(
        "정보를 로드 중 오류가 발생해 앱을 종료합니다",
        state.loadedDependenciesBlocCounts,
      ));
    }
  }

  changeIsBeginner(LoadingEvent event, emit) async {
    await repository.saveWelcomeState(1);
    emit(DependenciesBlocLoadedState(state.loadedDependenciesBlocCounts));
  }
}
