import 'package:ohmybooks_app/bloc/regist/event/regist_event.dart';

class RegistChangeBGOpacityEvent extends RegistEvent {
  final double opacity;
  RegistChangeBGOpacityEvent(this.opacity);
  @override
  List<Object?> get props => [];
}
