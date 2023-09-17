import 'package:ohmybooks_app/bloc/interface/i_bloc_state.dart';

abstract class LoadingState extends IBlocState {
  int loadedDependenciesBlocCounts;
  LoadingState(this.loadedDependenciesBlocCounts);
}

class InitializeState extends LoadingState {
  InitializeState() : super(0);
  @override
  List<Object?> get props => [loadedDependenciesBlocCounts];
}

class DependenciesBlocLoadingState extends LoadingState {
  DependenciesBlocLoadingState(super.loadedDependenciesBlocCounts);
  @override
  List<Object?> get props => [loadedDependenciesBlocCounts];
}

class DependenciesBlocLoadedState extends LoadingState {
  DependenciesBlocLoadedState(super.dependenciesBlocStates);
  @override
  List<Object?> get props => [loadedDependenciesBlocCounts];
}

class InitializeFailedState extends LoadingState {
  final String errorMessage;
  InitializeFailedState(this.errorMessage, super.loadedDependenciesBlocCounts);
  @override
  List<Object?> get props => [errorMessage];
}
