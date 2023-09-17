import 'package:dio/src/dio_exception.dart';
import 'package:ohmybooks_app/bloc/book/book_state.dart';
import 'package:ohmybooks_app/bloc/interface/i_bloc_event.dart';
import 'package:ohmybooks_app/bloc/interface/i_bloc_state.dart';
import 'package:ohmybooks_app/bloc/interface/i_dio_exception_handler.dart';
import 'package:ohmybooks_app/model/exception_model.dart';

class BookDioExceptionHandler extends IDioExceptionHandler {
  @override
  handleException(
    DioException error,
    IBlocEvent event,
    IBlocState state,
    emit,
  ) {
    final type = error.type;
    String errorTitle = "에기치 않은 오류";
    String errorType = "UnknownExeception";
    String errorMessage = "예기치 못한 오류가 발생했습니다\n해당 오류 발생 경로와 함께 문의 해주세요";

    if (type == DioExceptionType.badCertificate) {
      errorType = "BadCertificate";
      errorTitle = "인증 오류";
      errorMessage = "관리자 이메일로 문의 해주세요";
    } else if (type == DioExceptionType.badResponse) {
      errorType = "BadResponse";
      errorTitle = "유효 하지 않은 요청";
      errorMessage = "유효하지 못한 요청을 보냈습니다\n해당 오류 발생 경로와 함께 문의 해주세요";
    } else if (type == DioExceptionType.cancel) {
      errorType = "Cancel";
      errorTitle = "요청 취소";
      errorMessage =
          "Api 서버 혹은 앱 자체에서 요청을 취소 했습니다\n지속적으로 발생할 경우 발생 경로와 함께 문의해주세요";
    } else if (type == DioExceptionType.connectionError) {
      errorType = "ConnectionError";
      errorTitle = "서버와 연결 실패";
      errorMessage = "Api 서버에 연결할 수 없습니다";
    } else if (type == DioExceptionType.connectionTimeout) {
      errorType = "ConnectionTimeOut";
      errorTitle = "서버와 연결 시간 초과";
      errorMessage = "네트워크가 원활 한 곳으로 가서 재시도 해주세요";
    }

    state = state as BookListState;

    emit(
      BookListErrorState(
        errorType,
        metadata: DioExceptionMetaDataModel(
          errorMessage: errorMessage,
          errorTitle: errorTitle,
          errorType: errorType,
        ),
        maxPage: state.maxPage,
        bookList: state.bookList,
        target: state.target,
        searchTerm: state.searchTerm,
        page: state.page,
        apiMetaData: state.apiMetaData,
        limitExcessOnDay: state.limitExcessOnDay,
        tooManyRequest: state.tooManyRequest,
      ),
    );
  }
}
