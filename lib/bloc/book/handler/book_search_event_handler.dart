import 'package:dio/src/response.dart';
import 'package:ohmybooks_app/bloc/book/book_state.dart';
import 'package:ohmybooks_app/bloc/book/event/book_event.dart';
import 'package:ohmybooks_app/bloc/book/event/book_search_event.dart';
import 'package:ohmybooks_app/bloc/book/handler/book_event_handler.dart';
import 'package:ohmybooks_app/model/book_metadata_model.dart';
import 'package:ohmybooks_app/model/book_model.dart';

class BookSearchEventHandler extends BookEventHandler {
  @override
  handleEvent(
    BookEvent event,
    emit, {
    Response? body,
    BookListState? state,
  }) {
    try {
      event = event as BookSearchEvent;

      if (body == null) {
        emit(
          BookListErrorState(
            "InValidBodyOrStateException",
            maxPage: false,
            page: 1,
            apiMetaData: state!.apiMetaData,
            limitExcessOnDay: state.limitExcessOnDay,
            tooManyRequest: state.tooManyRequest,
          ),
        );
        return;
      }

      switch (body.statusCode) {
        case 200:
          final json = body.data;
          final docs = json['documents'];

          List<BookModel> books = state!.bookList ?? [];

          for (int i = 0; i < docs.length; ++i) {
            books.add(BookModel.fromJson(docs[i]));
          }

          final metadatas = BookMetaDataModel.fromJson(json['meta']);

          emit(BookListLoadedState(
            bookList: books,
            maxPage: metadatas.isEnd ?? false,
            page: state.page,
            searchTerm: event.searchTerm,
            target: event.target,
            apiMetaData: state.apiMetaData!,
            limitExcessOnDay: state.limitExcessOnDay,
            tooManyRequest: state.tooManyRequest,
          ));
          break;
        case 429:
          emit(
            BookListLoadedState(
              maxPage: state!.maxPage,
              page: state.page,
              bookList: state.bookList,
              target: state.target,
              searchTerm: state.searchTerm,
              apiMetaData: state.apiMetaData,
              limitExcessOnDay: state.limitExcessOnDay,
              tooManyRequest: true,
            ),
          );
          break;
      }
    } catch (e) {
      rethrow;
    }
  }
}
