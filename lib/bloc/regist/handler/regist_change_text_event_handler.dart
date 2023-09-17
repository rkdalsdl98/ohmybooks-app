import 'package:ohmybooks_app/bloc/regist/event/regist_change_text_event.dart';
import 'package:ohmybooks_app/bloc/regist/event/regist_event.dart';
import 'package:ohmybooks_app/bloc/regist/handler/regist_event_handler.dart';
import 'package:ohmybooks_app/bloc/regist/regist_state.dart';

class RegistChangeTextEventHandler extends RegistEventHandler {
  @override
  handleEvent(
    RegistEvent event,
    emit, {
    RegistState? state,
  }) {
    try {
      if (state == null) {
        throw Error.safeToString("ShelfStateIsNotFound");
      }

      emit(RegistLoadingState(
        style: state.style,
        imageUrl: state.imageUrl,
        text: state.text,
        backgroundOpacity: state.backgroundOpacity,
      ));

      event = event as RegistChangeTextEvent;
      emit(RegistLoadedState(
        style: state.style,
        imageUrl: state.imageUrl,
        text: event.text,
        backgroundOpacity: state.backgroundOpacity,
      ));
    } catch (e) {
      rethrow;
    }
  }

  @override
  List<Object?> get props => [];
}
