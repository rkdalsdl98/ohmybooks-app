import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:ohmybooks_app/bloc/book/book_state.dart';
import 'package:ohmybooks_app/bloc/book/event/book_add_next_page_event.dart';
import 'package:ohmybooks_app/bloc/book/event/book_event.dart';
import 'package:ohmybooks_app/bloc/book/event/book_initialize_event.dart';
import 'package:ohmybooks_app/bloc/book/event/book_save_event.dart';
import 'package:ohmybooks_app/bloc/book/event/book_search_event.dart';
import 'package:ohmybooks_app/bloc/book/exception/book_dio_exception_handler.dart';
import 'package:ohmybooks_app/bloc/book/handler/book_add_next_page_event_handler.dart';
import 'package:ohmybooks_app/bloc/book/handler/book_search_event_handler.dart';
import 'package:ohmybooks_app/model/book_api_metadata_model.dart';
import 'package:ohmybooks_app/repository/book_repository.dart';

class BookBloc extends Bloc<BookEvent, BookListState> {
  final BookRepository repository;
  BookBloc(this.repository) : super(BookListInitState()) {
    on<BookInitializeEvent>(
      (event, emit) async {
        await initialized(event, emit);
      },
      transformer: restartable(),
    );

    on<BookSearchEvent>(
      (event, emit) async => await searchBooks(event, emit),
      transformer: restartable(),
    );

    on<BookAddNextPageEvent>(
      (event, emit) async {
        if (state is BookListLoadingState) {
          return;
        }
        await addNextPage(event, emit);
      },
      transformer: droppable(),
    );
    on<BookSaveEvent>(
      (event, emit) async {
        if (state is BookListLoadingState) {
          return;
        }
        await saveData(event, emit);
      },
      transformer: restartable(),
    );

    add(BookInitializeEvent());
  }

  getStateIsLoaded() => {
        "name": "BookBloc",
        "isLoaded": state is BookListLoadedState,
      };

  int getCurrWeekday() => state.apiMetaData!.weekday!;

  saveData(BookEvent event, emit) async {
    try {
      emit(BookListLoadingState(
        bookList: state.bookList,
        maxPage: state.maxPage,
        page: state.page,
        searchTerm: state.searchTerm,
        target: state.target,
        apiMetaData: state.apiMetaData!,
        limitExcessOnDay: state.limitExcessOnDay,
        tooManyRequest: state.tooManyRequest,
      ));

      await repository.saveMetaData(state.apiMetaData ??
          BookApiMetaDataModel(
            searchCount: 0,
            weekday: DateTime.now().weekday,
          ));

      emit(BookListLoadedState(
        bookList: state.bookList,
        maxPage: state.maxPage,
        page: state.page,
        searchTerm: state.searchTerm,
        target: state.target,
        apiMetaData: state.apiMetaData!,
        limitExcessOnDay: state.limitExcessOnDay,
        tooManyRequest: state.tooManyRequest,
      ));
    } catch (e) {
      emit(
        BookListErrorState(
          "UnknownException",
          maxPage: false,
          page: 1,
          bookList: state.bookList,
          target: state.target,
          searchTerm: state.searchTerm,
          apiMetaData: state.apiMetaData,
          limitExcessOnDay: state.limitExcessOnDay,
          tooManyRequest: state.tooManyRequest,
          metadata: null,
        ),
      );
    }
  }

  initialized(BookEvent event, dynamic emit) async {
    try {
      emit(BookListLoadingState(
        maxPage: state.maxPage,
        page: state.page,
        bookList: state.bookList,
        target: state.target,
        searchTerm: state.searchTerm,
        apiMetaData: state.apiMetaData,
        limitExcessOnDay: state.limitExcessOnDay,
        tooManyRequest: state.tooManyRequest,
      ));

      final apimetadata =
          await repository.loadMetaData() as BookApiMetaDataModel;
      final now = DateTime.now().weekday;

      if (apimetadata.weekday != now) {
        apimetadata.setWeekDay(now);
        apimetadata.searchCount = 0;
      }
      state.limitExcessOnDay = apimetadata.searchCount! >= 100;

      emit(BookListLoadedState(
        maxPage: state.maxPage,
        page: state.page,
        bookList: state.bookList,
        target: state.target,
        searchTerm: state.searchTerm,
        apiMetaData: apimetadata,
        limitExcessOnDay: state.limitExcessOnDay,
        tooManyRequest: state.tooManyRequest,
      ));
    } catch (e) {
      emit(
        BookListErrorState(
          "UnknownException",
          maxPage: false,
          page: 1,
          bookList: state.bookList,
          target: state.target,
          searchTerm: state.searchTerm,
          apiMetaData: state.apiMetaData,
          limitExcessOnDay: state.limitExcessOnDay,
          tooManyRequest: state.tooManyRequest,
          metadata: null,
        ),
      );
    }
  }

  Future<void> searchBooks(BookSearchEvent event, dynamic emit) async {
    try {
      emit(BookListLoadingState(
        maxPage: state.maxPage,
        page: 1,
        target: state.target,
        searchTerm: event.searchTerm,
        apiMetaData: state.apiMetaData,
        limitExcessOnDay: state.limitExcessOnDay,
        tooManyRequest: state.tooManyRequest,
      ));

      if (state.limitExcessOnDay) {
        emit(BookListLoadedState(
          bookList: state.bookList,
          maxPage: state.maxPage,
          page: state.page,
          searchTerm: state.searchTerm,
          target: state.target,
          apiMetaData: state.apiMetaData!,
          limitExcessOnDay: state.limitExcessOnDay,
          tooManyRequest: state.tooManyRequest,
        ));
        return;
      }

      final res = await repository.getSearchBooks(
        event.searchTerm,
        state.page,
        target: event.target,
      );
      state.apiMetaData!.increaseCount();
      state.limitExcessOnDay = state.apiMetaData!.searchCount! >= 100;
      await repository.saveMetaData(state.apiMetaData!);

      BookSearchEventHandler().handleEvent(
        event,
        emit,
        body: res,
        state: state,
      );
    } catch (e) {
      if (e is DioException) {
        BookDioExceptionHandler().handleException(e, event, state, emit);
      } else {
        var str = e.toString().trim();
        if (str.contains("EnvLoadError")) {
          emit(
            BookListErrorState(
              "EnvLoadError",
              maxPage: false,
              page: 1,
              bookList: state.bookList,
              target: state.target,
              searchTerm: state.searchTerm,
              apiMetaData: state.apiMetaData,
              limitExcessOnDay: state.limitExcessOnDay,
              tooManyRequest: state.tooManyRequest,
              metadata: null,
            ),
          );
        } else {
          emit(
            BookListErrorState(
              "UnknownException",
              maxPage: false,
              page: 1,
              bookList: state.bookList,
              target: state.target,
              searchTerm: state.searchTerm,
              apiMetaData: state.apiMetaData,
              limitExcessOnDay: state.limitExcessOnDay,
              tooManyRequest: state.tooManyRequest,
              metadata: null,
            ),
          );
        }
      }
    }
  }

  Future<void> addNextPage(BookAddNextPageEvent event, dynamic emit) async {
    try {
      emit(BookListLoadingState(
        bookList: state.bookList,
        searchTerm: state.searchTerm,
        maxPage: state.maxPage,
        page: state.page,
        target: state.target,
        apiMetaData: state.apiMetaData,
        limitExcessOnDay: state.limitExcessOnDay,
        tooManyRequest: state.tooManyRequest,
      ));

      if (state.maxPage) {
        emit(
          BookListLoadedState(
            bookList: state.bookList,
            target: state.target,
            searchTerm: state.searchTerm,
            maxPage: true,
            page: state.page,
            apiMetaData: state.apiMetaData,
            limitExcessOnDay: state.limitExcessOnDay,
            tooManyRequest: state.tooManyRequest,
          ),
        );
        return;
      } else if (state.limitExcessOnDay) {
        emit(BookListLoadedState(
          bookList: state.bookList,
          maxPage: state.maxPage,
          page: state.page,
          searchTerm: state.searchTerm,
          target: state.target,
          apiMetaData: state.apiMetaData!,
          limitExcessOnDay: state.limitExcessOnDay,
          tooManyRequest: state.tooManyRequest,
        ));
        return;
      }

      final res = await repository.getSearchBooks(
        state.searchTerm ?? "",
        state.page,
        target: state.target,
      );
      state.apiMetaData!.increaseCount();
      state.limitExcessOnDay = state.apiMetaData!.searchCount! >= 100;
      await repository.saveMetaData(state.apiMetaData!);

      BookAddNextPageEventHandler().handleEvent(
        event,
        emit,
        body: res,
        state: state,
      );
    } catch (e) {
      if (e is DioException) {
        BookDioExceptionHandler().handleException(e, event, state, emit);
      } else {
        var str = e.toString().trim();
        if (str.contains("EnvLoadError")) {
          emit(
            BookListErrorState(
              "EnvLoadError",
              maxPage: false,
              page: 1,
              bookList: state.bookList,
              target: state.target,
              searchTerm: state.searchTerm,
              apiMetaData: state.apiMetaData,
              limitExcessOnDay: state.limitExcessOnDay,
              tooManyRequest: state.tooManyRequest,
              metadata: null,
            ),
          );
        } else {
          emit(
            BookListErrorState(
              "UnknownException",
              maxPage: false,
              page: 1,
              bookList: state.bookList,
              target: state.target,
              searchTerm: state.searchTerm,
              apiMetaData: state.apiMetaData,
              limitExcessOnDay: state.limitExcessOnDay,
              tooManyRequest: state.tooManyRequest,
              metadata: null,
            ),
          );
        }
      }
    }
  }
}
