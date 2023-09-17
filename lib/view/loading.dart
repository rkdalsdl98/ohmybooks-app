import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ohmybooks_app/bloc/book/book_bloc.dart';
import 'package:ohmybooks_app/bloc/loading/event/load_dependencies_bloc_event.dart';
import 'package:ohmybooks_app/bloc/loading/loading_bloc.dart';
import 'package:ohmybooks_app/bloc/loading/loading_bloc_state.dart';
import 'package:ohmybooks_app/bloc/shelf/shelf_bloc.dart';
import 'package:ohmybooks_app/bloc/story/story_bloc.dart';
import 'package:ohmybooks_app/repository/loading_respository.dart';
import 'package:ohmybooks_app/system/dimensions.dart';
import 'package:ohmybooks_app/view/home.dart';
import 'package:ohmybooks_app/view/welcome.dart';
import 'package:rive/rive.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<LoadingRepository>(
      create: (_) => LoadingRepository(),
      child: BlocProvider<LoadingBloc>(
        create: (builderContext) =>
            LoadingBloc(builderContext.read<LoadingRepository>()),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: const Stack(
            children: [
              RiveAnimation.asset(
                'assets/rive/ohmybookslogo.riv',
                fit: BoxFit.fitWidth,
              ),
              LoadingText(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoadingText extends StatefulWidget {
  const LoadingText({
    super.key,
  });

  @override
  State<LoadingText> createState() => _LoadingTextState();
}

class _LoadingTextState extends State<LoadingText> {
  late Timer timer;
  int currCounts = 0;

  checkLoadedStates() {
    final book = context.read<BookBloc>();
    final shelf = context.read<ShelfBloc>();
    final story = context.read<StoryBloc>();

    final loadingBloc = context.read<LoadingBloc>();

    loadingBloc.add(LoadingDependenciesBlocEvent([
      book.getStateIsLoaded() as Map<String, dynamic>,
      shelf.getStateIsLoaded() as Map<String, dynamic>,
      story.getStateIsLoaded() as Map<String, dynamic>,
    ]));
  }

  moveTo(String routeName) async {
    await Future.delayed(const Duration(seconds: 3)).then((_) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider<LoadingBloc>.value(
            value: context.read<LoadingBloc>(),
            child: routeName == "welcome" ? const WelcomePage() : const Home(),
          ),
        )));
  }

  exitApp(String message) async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async => await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 100),
          title: Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'SpoqaHanSans',
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                '확인',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 10 * getScaleFactorFromWidth(context),
                  fontFamily: 'SpoqaHanSans',
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () => exit(0),
            ),
          ],
        ),
      ).then((_) {
        exit(0);
      }),
    );
  }

  loadedDependenciesBlocs() async {
    timer.cancel();

    int isBeginner = await context.read<LoadingBloc>().getIsBeginner();
    if (isBeginner == 0) {
      moveTo("welcome");
    } else {
      moveTo("home");
    }
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (currCounts >= 3) {
        loadedDependenciesBlocs();
        return;
      }
      checkLoadedStates();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingBloc, LoadingState>(
      builder: (_, state) {
        currCounts = state.loadedDependenciesBlocCounts;
        if (state is InitializeFailedState) {
          timer.cancel();
          exitApp(state.errorMessage);
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              currCounts >= 3
                  ? "OhMyBooks!"
                  : "필요한 정보를 가져오는중 입니다... $currCounts / 3",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 12 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );
      },
    );
  }
}
