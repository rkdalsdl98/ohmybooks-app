import 'package:ohmybooks_app/bloc/interface/i_bloc_state.dart';
import 'package:ohmybooks_app/model/book_api_metadata_model.dart';
import 'package:ohmybooks_app/model/book_model.dart';
import 'package:ohmybooks_app/model/exception_model.dart';

abstract class BookListState extends IBlocState {
  List<BookModel>? bookList;
  bool maxPage;
  bool limitExcessOnDay;
  bool tooManyRequest;
  int page;
  String? target;
  String? searchTerm;
  BookApiMetaDataModel? apiMetaData;

  void addPage(List<dynamic> list) =>
      bookList?..addAll(list.map((e) => BookModel.fromJson(e)).toList());

  BookListState({
    this.bookList,
    required this.limitExcessOnDay,
    required this.tooManyRequest,
    required this.maxPage,
    required this.page,
    this.target,
    this.searchTerm,
    this.apiMetaData,
  });

  @override
  List<Object?> get props => [bookList, maxPage, page, target, searchTerm];
}

class BookListInitState extends BookListState {
  BookListInitState()
      : super(
          bookList: [],
          maxPage: false,
          page: 1,
          searchTerm: "책",
          limitExcessOnDay: false,
          tooManyRequest: false,
        );

  @override
  List<Object?> get props => [bookList, maxPage, page, target, searchTerm];
}

class BookListLoadingState extends BookListState {
  BookListLoadingState({
    super.bookList,
    required super.maxPage,
    required super.page,
    super.target,
    super.searchTerm,
    super.apiMetaData,
    required super.limitExcessOnDay,
    required super.tooManyRequest,
  });
  @override
  List<Object?> get props => [bookList, maxPage, page, target, searchTerm];
}

class BookListLoadedState extends BookListState {
  BookListLoadedState({
    super.bookList,
    required super.maxPage,
    required super.page,
    super.target,
    super.searchTerm,
    super.apiMetaData,
    required super.limitExcessOnDay,
    required super.tooManyRequest,
  });
  @override
  List<Object?> get props => [bookList, maxPage, page, target, searchTerm];
}

class BookListErrorState extends BookListState {
  final String errorType;
  DioExceptionMetaDataModel? metadata;
  BookListErrorState(
    this.errorType, {
    this.metadata,
    super.bookList,
    required super.maxPage,
    required super.page,
    super.target,
    super.searchTerm,
    super.apiMetaData,
    required super.limitExcessOnDay,
    required super.tooManyRequest,
  });
  @override
  List<Object?> get props => [errorType, metadata];
}
