import 'package:ohmybooks_app/bloc/regist/event/regist_event.dart';
import 'package:ohmybooks_app/bloc/regist/event/regist_style_apply_event.dart';
import 'package:ohmybooks_app/bloc/regist/handler/regist_event_handler.dart';
import 'package:ohmybooks_app/bloc/regist/regist_state.dart';

class RegistStyleApplyEventHandler extends RegistEventHandler {
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

      event = event as RegistStyleApplyEvent;

      emit(RegistLoadedState(
        style: event.style,
        imageUrl: state.imageUrl,
        text: state.text,
        backgroundOpacity: state.backgroundOpacity,
      ));
    } catch (e) {
      rethrow;
    }
  }

  @override
  List<Object?> get props => [];
}
