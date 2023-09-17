import 'package:ohmybooks_app/bloc/shelf/event/shelf_event.dart';
import 'package:ohmybooks_app/bloc/shelf/event/shelf_initialze_event.dart';
import 'package:ohmybooks_app/bloc/shelf/handler/shelf_event_handler.dart';
import 'package:ohmybooks_app/bloc/shelf/shelf_state.dart';
import 'package:ohmybooks_app/model/shelf_model.dart';
import 'package:ohmybooks_app/repository/shelf_repository.dart';

class ShelfIntializeEventHandler extends ShelfEventHandler {
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
      event = event as ShlefInitializeEvent;
      final data = await repository.loadShelfData() as ShelfModel;

      emit(ShelfLoadedState(
        data.books,
        data.backgroundImage,
      ));
    } catch (e) {
      rethrow;
    }
  }

  @override
  List<Object?> get props => [];
}
