import 'package:ohmybooks_app/bloc/regist/event/regist_event.dart';

class RegistChangeBackgroundEvent extends RegistEvent {
  String? imageUrl;
  RegistChangeBackgroundEvent(this.imageUrl);
  @override
  List<Object?> get props => [imageUrl];
}
