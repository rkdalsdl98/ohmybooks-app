import 'package:equatable/equatable.dart';
import 'package:ohmybooks_app/bloc/regist/event/regist_event.dart';
import 'package:ohmybooks_app/bloc/regist/regist_state.dart';

abstract class RegistEventHandler extends Equatable {
  handleEvent(
    RegistEvent event,
    emit, {
    RegistState? state,
  }) {}
}
