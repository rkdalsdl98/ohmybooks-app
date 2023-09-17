import 'package:ohmybooks_app/bloc/book/event/book_event.dart';

class BookSearchEvent extends BookEvent {
  final String searchTerm;
  String? target;

  BookSearchEvent(this.searchTerm, {this.target});
  @override
  List<Object?> get props => [searchTerm, target];
}
