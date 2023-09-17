import 'package:ohmybooks_app/bloc/shelf/event/shelf_event.dart';
import 'package:ohmybooks_app/model/book_model.dart';

class ShelfRemoveEvent extends ShelfEvent {
  final BookModel book;
  ShelfRemoveEvent(this.book);

  @override
  List<Object?> get props => [];
}
