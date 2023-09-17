import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ohmybooks_app/bloc/regist/event/regist_change_text_event.dart';
import 'package:ohmybooks_app/bloc/regist/regist_bloc.dart';
import 'package:ohmybooks_app/system/dimensions.dart';

class StoryInputField extends StatelessWidget {
  const StoryInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 100 * getScaleFactorFromHeight(context),
        child: TextField(
          maxLength: 50,
          maxLines: 2,
          onChanged: (value) {
            final bloc = context.read<RegistBloc>();
            bloc.add(RegistChangeTextEvent(value));
          },
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 10 * getScaleFactorFromWidth(context),
            fontFamily: 'SpoqaHanSans',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
