import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ohmybooks_app/bloc/loading/event/change_is_beginner_event.dart';
import 'package:ohmybooks_app/bloc/loading/loading_bloc.dart';
import 'package:ohmybooks_app/widget/welcome/first_page.dart';
import 'package:ohmybooks_app/widget/welcome/second_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int currIndex = 0;

  moveToNextPage() {
    setState(() {
      ++currIndex;
    });
  }

  saveIsBeginner() {
    final bloc = context.read<LoadingBloc>();
    bloc.add(ChangeIsBeginnerEvent());
  }

  @override
  void initState() {
    super.initState();
    saveIsBeginner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: IndexedStack(
        index: currIndex,
        children: [
          WelcomeFirstPage(onPressButtonEvent: moveToNextPage),
          const WelcomeSecondPage(),
        ],
      ),
    );
  }
}
