import 'package:dio/dio.dart';
import 'package:ohmybooks_app/bloc/book/book_state.dart';
import 'package:ohmybooks_app/bloc/book/event/book_event.dart';

abstract class BookEventHandler {
  handleEvent(
    BookEvent event,
    dynamic emit, {
    Response? body,
    BookListState? state,
  }) {}
}
