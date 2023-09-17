import 'package:ohmybooks_app/bloc/shelf/event/shelf_event.dart';

class ShelfChangeImageEvent extends ShelfEvent {
  final String backgroundImage;

  ShelfChangeImageEvent(this.backgroundImage);
  @override
  List<Object?> get props => [backgroundImage];
}
