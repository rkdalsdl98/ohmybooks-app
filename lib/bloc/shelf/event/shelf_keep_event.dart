import 'package:ohmybooks_app/bloc/shelf/event/shelf_event.dart';
import 'package:ohmybooks_app/model/book_model.dart';

class ShelfKeepEvent extends ShelfEvent {
  final BookModel book;
  ShelfKeepEvent(this.book);

  @override
  List<Object?> get props => [];
}
