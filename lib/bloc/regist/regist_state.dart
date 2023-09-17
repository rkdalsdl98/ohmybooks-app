import 'package:flutter/material.dart';
import 'package:ohmybooks_app/bloc/interface/i_bloc_state.dart';

abstract class RegistState extends IBlocState {
  TextStyle? style;
  String? imageUrl;
  String? text;
  double? backgroundOpacity;

  RegistState({
    this.style,
    this.imageUrl,
    this.text,
    this.backgroundOpacity,
  });
}

class RegistInitState extends RegistState {
  RegistInitState()
      : super(
          imageUrl: "asset:assets/img/story_forest.png",
          style: const TextStyle(
            fontFamily: 'SpoqaHanSans',
            fontWeight: FontWeight.w400,
            color: Colors.white,
            height: 1,
            wordSpacing: 0,
            letterSpacing: 1,
          ),
          text: "",
          backgroundOpacity: 1,
        );
  @override
  List<Object?> get props => [imageUrl, style, text, backgroundOpacity];
}

class RegistLoadingState extends RegistState {
  RegistLoadingState({
    super.imageUrl,
    super.style,
    super.text,
    super.backgroundOpacity,
  });
  @override
  List<Object?> get props => [imageUrl, style, text, backgroundOpacity];
}

class RegistLoadedState extends RegistState {
  RegistLoadedState({
    super.imageUrl,
    super.style,
    super.text,
    super.backgroundOpacity,
  });
  @override
  List<Object?> get props => [imageUrl, style, text, backgroundOpacity];
}

class RegistErrorState extends RegistState {
  final String errorMessage;
  RegistErrorState(
    this.errorMessage, {
    super.imageUrl,
    super.style,
    super.text,
    super.backgroundOpacity,
  });
  @override
  List<Object?> get props => [errorMessage];
}
