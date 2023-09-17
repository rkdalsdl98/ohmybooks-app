import 'package:equatable/equatable.dart';
import 'package:ohmybooks_app/bloc/shelf/event/shelf_event.dart';
import 'package:ohmybooks_app/bloc/shelf/shelf_state.dart';
import 'package:ohmybooks_app/repository/shelf_repository.dart';

abstract class ShelfEventHandler extends Equatable {
  handleEvent(
    ShelfEvent event,
    dynamic emit, {
    ShelfRepository? repository,
    ShelfState? state,
  });
}
