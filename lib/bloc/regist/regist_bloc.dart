import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:ohmybooks_app/bloc/regist/event/regist_change_background_event.dart';
import 'package:ohmybooks_app/bloc/regist/event/regist_change_bg_opacity_event.dart';
import 'package:ohmybooks_app/bloc/regist/event/regist_change_text_event.dart';
import 'package:ohmybooks_app/bloc/regist/event/regist_event.dart';
import 'package:ohmybooks_app/bloc/regist/event/regist_style_apply_event.dart';
import 'package:ohmybooks_app/bloc/regist/handler/regist_change_background_event_handler.dart';
import 'package:ohmybooks_app/bloc/regist/handler/regist_change_bg_opacity_event_handler.dart';
import 'package:ohmybooks_app/bloc/regist/handler/regist_change_text_event_handler.dart';
import 'package:ohmybooks_app/bloc/regist/handler/regist_style_apply_event_handler.dart';
import 'package:ohmybooks_app/bloc/regist/regist_state.dart';

class RegistBloc extends Bloc<RegistEvent, RegistState> {
  RegistBloc() : super(RegistInitState()) {
    on<RegistStyleApplyEvent>(
      (event, emit) => _applyStyle(event, emit),
      transformer: sequential(),
    );
    on<RegistChangeBackgroundEvent>(
      (event, emit) => _applyBackground(event, emit),
    );
    on<RegistChangeTextEvent>(
      (event, emit) => _changeText(event, emit),
      transformer: sequential(),
    );
    on<RegistChangeBGOpacityEvent>(
      (event, emit) => _changeBGOpacity(event, emit),
      transformer: sequential(),
    );
  }

  _applyBackground(RegistEvent event, emit) {
    try {
      RegistChangeBackgroundEventHandler().handleEvent(
        event,
        emit,
        state: state,
      );
    } catch (e) {
      var str = e.toString().trim();
      if (str.contains("RegistStateIsNotFound")) {
        emit(RegistErrorState(
          "RegistStateIsNotFound",
          style: state.style,
          imageUrl: state.imageUrl,
          text: state.text,
          backgroundOpacity: state.backgroundOpacity,
        ));
      } else {
        emit(RegistErrorState(
          "UnknownException",
          style: state.style,
          imageUrl: state.imageUrl,
          backgroundOpacity: state.backgroundOpacity,
          text: state.text,
        ));
      }
    }
  }

  _applyStyle(RegistEvent event, emit) {
    try {
      RegistStyleApplyEventHandler().handleEvent(
        event,
        emit,
        state: state,
      );
    } catch (e) {
      var str = e.toString().trim();
      if (str.contains("RegistStateIsNotFound")) {
        emit(RegistErrorState(
          "RegistStateIsNotFound",
          style: state.style,
          imageUrl: state.imageUrl,
          text: state.text,
          backgroundOpacity: state.backgroundOpacity,
        ));
      } else {
        emit(RegistErrorState(
          "UnknownException",
          style: state.style,
          imageUrl: state.imageUrl,
          text: state.text,
          backgroundOpacity: state.backgroundOpacity,
        ));
      }
    }
  }

  _changeText(RegistEvent event, emit) {
    try {
      RegistChangeTextEventHandler().handleEvent(
        event,
        emit,
        state: state,
      );
    } catch (e) {
      var str = e.toString().trim();
      if (str.contains("RegistStateIsNotFound")) {
        emit(RegistErrorState(
          "RegistStateIsNotFound",
          style: state.style,
          imageUrl: state.imageUrl,
          text: state.text,
          backgroundOpacity: state.backgroundOpacity,
        ));
      } else {
        emit(RegistErrorState(
          "UnknownException",
          style: state.style,
          imageUrl: state.imageUrl,
          text: state.text,
          backgroundOpacity: state.backgroundOpacity,
        ));
      }
    }
  }

  _changeBGOpacity(RegistEvent event, emit) {
    try {
      RegistChangeBGOpacityEventHandler().handleEvent(
        event,
        emit,
        state: state,
      );
    } catch (e) {
      var str = e.toString().trim();
      if (str.contains("RegistStateIsNotFound")) {
        emit(RegistErrorState(
          "RegistStateIsNotFound",
          style: state.style,
          imageUrl: state.imageUrl,
          text: state.text,
          backgroundOpacity: state.backgroundOpacity,
        ));
      } else {
        emit(RegistErrorState(
          "UnknownException",
          style: state.style,
          imageUrl: state.imageUrl,
          text: state.text,
          backgroundOpacity: state.backgroundOpacity,
        ));
      }
    }
  }

  String getStoryText() => state.text!;
  String getImageUrl() => state.imageUrl!;
  double getBGOpacity() => state.backgroundOpacity!;
  TextStyle getStyle() {
    return state.style ??
        const TextStyle(
          fontFamily: 'SpoqaHanSans',
          fontWeight: FontWeight.w400,
          color: Colors.white,
          height: 1,
          wordSpacing: 0,
          letterSpacing: 1,
        );
  }
}
