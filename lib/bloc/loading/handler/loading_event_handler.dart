import 'package:equatable/equatable.dart';
import 'package:ohmybooks_app/bloc/loading/event/loading_event.dart';
import 'package:ohmybooks_app/bloc/loading/loading_bloc_state.dart';

abstract class LoadingEventHandler extends Equatable {
  handlerEvent(
    LoadingEvent event,
    emit,
    LoadingState state,
  );
}
