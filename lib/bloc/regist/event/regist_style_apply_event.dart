import 'package:flutter/material.dart';
import 'package:ohmybooks_app/bloc/regist/event/regist_event.dart';

class RegistStyleApplyEvent extends RegistEvent {
  final TextStyle style;

  RegistStyleApplyEvent(this.style);
  @override
  List<Object?> get props => [style];
}
