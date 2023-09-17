import 'package:ohmybooks_app/bloc/interface/i_bloc_state.dart';
import 'package:ohmybooks_app/model/book_model.dart';

abstract class ShelfState extends IBlocState {
  List<BookModel>? shelfItems;
  String? backgroundImage;
  ShelfState(this.shelfItems, this.backgroundImage);
}

class ShelfInitState extends ShelfState {
  ShelfInitState() : super([], "");
  @override
  List<Object?> get props => [shelfItems, backgroundImage];
}

class ShelfLoadingState extends ShelfState {
  ShelfLoadingState(super.shelfItems, super.backgroundImage);

  @override
  List<Object?> get props => [shelfItems, backgroundImage];
}

class ShelfLoadedState extends ShelfState {
  ShelfLoadedState(super.shelfItems, super.backgroundImage);

  @override
  List<Object?> get props => [shelfItems, backgroundImage];
}

class ShelfErrorState extends ShelfState {
  final String errorMessage;
  ShelfErrorState(this.errorMessage, super.shelfItems, super.backgroundImage);

  @override
  List<Object?> get props => [errorMessage];
}
