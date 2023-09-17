import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:ohmybooks_app/bloc/shelf/event/shelf_changeimage_event.dart';
import 'package:ohmybooks_app/bloc/shelf/event/shelf_event.dart';
import 'package:ohmybooks_app/bloc/shelf/event/shelf_initialze_event.dart';
import 'package:ohmybooks_app/bloc/shelf/event/shelf_keep_event.dart';
import 'package:ohmybooks_app/bloc/shelf/event/shelf_remove_event.dart';
import 'package:ohmybooks_app/bloc/shelf/handler/shelf_changeimage_event_handler.dart';
import 'package:ohmybooks_app/bloc/shelf/handler/shelf_intialize_event_handler.dart';
import 'package:ohmybooks_app/bloc/shelf/handler/shelf_keep_event_handler.dart';
import 'package:ohmybooks_app/bloc/shelf/handler/shelf_remove_event_handler.dart';
import 'package:ohmybooks_app/bloc/shelf/shelf_state.dart';
import 'package:ohmybooks_app/model/book_model.dart';
import 'package:ohmybooks_app/repository/shelf_repository.dart';

class ShelfBloc extends Bloc<ShelfEvent, ShelfState> {
  final ShelfRepository repository;
  ShelfBloc(this.repository) : super(ShelfInitState()) {
    on<ShlefInitializeEvent>(
      (event, emit) async => await intialized(event, emit),
      transformer: sequential(),
    );
    on<ShelfKeepEvent>(
      (event, emit) async {
        if (state is ShelfLoadingState) {
          return;
        }
        await keepBook(event, emit);
      },
      transformer: droppable(),
    );
    on<ShelfRemoveEvent>(
      (event, emit) async {
        if (state is ShelfLoadingState) {
          return;
        }
        await removeBook(event, emit);
      },
      transformer: droppable(),
    );
    on<ShelfChangeImageEvent>(
      (event, emit) async => await changeBackgroundImage(event, emit),
    );
    add(ShlefInitializeEvent());
  }

  getStateIsLoaded() => {
        "name": "ShelfBloc",
        "isLoaded": state is ShelfLoadedState,
      };

  bool isSubcribeBook(BookModel book) {
    if (state.shelfItems!.isEmpty) {
      return false;
    } else {
      bool hasBook = false;
      for (int i = 0; i < state.shelfItems!.length; ++i) {
        if (state.shelfItems![i] == book) {
          hasBook = true;
          break;
        }
      }
      return hasBook;
    }
  }

  changeBackgroundImage(ShelfEvent event, emit) async {
    try {
      await ShelfChangeImageEventHandler().handleEvent(
        event,
        emit,
        repository: repository,
        state: state,
      );
    } catch (e) {
      var str = e.toString().trim();
      if (str.contains("RepositoryInstanceNotFound")) {
        emit(ShelfErrorState(
          "RepositoryInstanceNotFound",
          state.shelfItems,
          state.backgroundImage,
        ));
      } else if (str.contains("ShelfStateIsNotFound")) {
        emit(ShelfErrorState(
          "ShelfStateIsNotFound",
          const <BookModel>[],
          "",
        ));
      } else {
        emit(ShelfErrorState(
          "UnknownException",
          state.shelfItems,
          state.backgroundImage,
        ));
      }
    }
  }

  keepBook(ShelfKeepEvent event, dynamic emit) async {
    try {
      await ShelfKeepEventHandler().handleEvent(
        event,
        emit,
        repository: repository,
        state: state,
      );
    } catch (e) {
      var str = e.toString().trim();
      if (str.contains("RepositoryInstanceNotFound")) {
        emit(ShelfErrorState(
          "RepositoryInstanceNotFound",
          state.shelfItems,
          state.backgroundImage,
        ));
      } else if (str.contains("ShelfStateIsNotFound")) {
        emit(ShelfErrorState(
          "ShelfStateIsNotFound",
          const <BookModel>[],
          state.backgroundImage,
        ));
      } else {
        emit(ShelfErrorState(
          "UnknownException",
          state.shelfItems,
          state.backgroundImage,
        ));
      }
    }
  }

  removeBook(ShelfRemoveEvent event, dynamic emit) async {
    try {
      await ShelfRemoveEventHandler().handleEvent(
        event,
        emit,
        repository: repository,
        state: state,
      );
    } catch (e) {
      var str = e.toString().trim();
      if (str.contains("RepositoryInstanceNotFound")) {
        emit(ShelfErrorState(
          "RepositoryInstanceNotFound",
          state.shelfItems,
          state.backgroundImage,
        ));
      } else if (str.contains("ShelfStateIsNotFound")) {
        emit(ShelfErrorState(
          "ShelfStateIsNotFound",
          const <BookModel>[],
          state.backgroundImage,
        ));
      } else {
        emit(ShelfErrorState(
          "UnknownException",
          state.shelfItems,
          state.backgroundImage,
        ));
      }
    }
  }

  intialized(ShlefInitializeEvent event, dynamic emit) async {
    try {
      await ShelfIntializeEventHandler().handleEvent(
        event,
        emit,
        repository: repository,
        state: state,
      );
    } catch (e) {
      var str = e.toString().trim();
      if (str.contains("RepositoryInstanceNotFound")) {
        emit(ShelfErrorState(
          "RepositoryInstanceNotFound",
          state.shelfItems,
          state.backgroundImage,
        ));
      } else if (str.contains("ShelfStateIsNotFound")) {
        emit(ShelfErrorState(
          "ShelfStateIsNotFound",
          const <BookModel>[],
          state.backgroundImage,
        ));
      } else {
        emit(ShelfErrorState(
          "UnknownException",
          state.shelfItems,
          state.backgroundImage,
        ));
      }
    }
  }
}
