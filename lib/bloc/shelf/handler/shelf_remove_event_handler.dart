import 'package:ohmybooks_app/bloc/shelf/event/shelf_event.dart';
import 'package:ohmybooks_app/bloc/shelf/event/shelf_remove_event.dart';
import 'package:ohmybooks_app/bloc/shelf/handler/shelf_event_handler.dart';
import 'package:ohmybooks_app/bloc/shelf/shelf_state.dart';
import 'package:ohmybooks_app/model/shelf_model.dart';
import 'package:ohmybooks_app/repository/shelf_repository.dart';

class ShelfRemoveEventHandler extends ShelfEventHandler {
  @override
  handleEvent(
    ShelfEvent event,
    emit, {
    ShelfRepository? repository,
    ShelfState? state,
  }) async {
    try {
      if (repository == null) {
        throw Error.safeToString("RepositoryInstanceNotFound");
      } else if (state == null) {
        throw Error.safeToString("ShelfStateIsNotFound");
      }
      emit(ShelfLoadingState(
        state.shelfItems,
        state.backgroundImage,
      ));
      event = event as ShelfRemoveEvent;

      final books = state.shelfItems ?? [];
      books.remove(event.book);

      await repository.saveShelfData(ShelfModel(books, state.backgroundImage));
      emit(ShelfLoadedState(
        books,
        state.backgroundImage,
      ));
    } catch (e) {
      rethrow;
    }
  }

  @override
  List<Object?> get props => [];
}
