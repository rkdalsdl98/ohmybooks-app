import 'package:dio/dio.dart';
import 'package:ohmybooks_app/bloc/interface/i_bloc_event.dart';
import 'package:ohmybooks_app/bloc/interface/i_bloc_state.dart';

abstract class IDioExceptionHandler {
  handleException(
    DioException error,
    IBlocEvent event,
    IBlocState state,
    emit,
  ) {}
}
