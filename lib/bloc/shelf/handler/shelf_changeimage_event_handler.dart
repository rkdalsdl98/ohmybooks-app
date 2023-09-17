import 'package:ohmybooks_app/bloc/shelf/event/shelf_changeimage_event.dart';
import 'package:ohmybooks_app/bloc/shelf/event/shelf_event.dart';
import 'package:ohmybooks_app/bloc/shelf/handler/shelf_event_handler.dart';
import 'package:ohmybooks_app/bloc/shelf/shelf_state.dart';
import 'package:ohmybooks_app/model/shelf_model.dart';
import 'package:ohmybooks_app/repository/shelf_repository.dart';

class ShelfChangeImageEventHandler extends ShelfEventHandler {
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
      emit(ShelfLoadingState(state.shelfItems, state.backgroundImage));

      event = event as ShelfChangeImageEvent;
      await repository
          .saveShelfData(ShelfModel(state.shelfItems, event.backgroundImage));

      emit(ShelfLoadedState(state.shelfItems, event.backgroundImage));
    } catch (e) {
      rethrow;
    }
  }

  @override
  List<Object?> get props => [];
}
