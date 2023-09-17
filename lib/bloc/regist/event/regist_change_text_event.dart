import 'package:ohmybooks_app/bloc/regist/event/regist_event.dart';

class RegistChangeTextEvent extends RegistEvent {
  final String text;
  RegistChangeTextEvent(this.text);
  @override
  List<Object?> get props => [text];
}
