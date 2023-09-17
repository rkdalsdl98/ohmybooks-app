import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ohmybooks_app/bloc/shelf/shelf_bloc.dart';
import 'package:ohmybooks_app/bloc/story/story_bloc.dart';
import 'package:ohmybooks_app/repository/story_repository.dart';
import 'package:ohmybooks_app/view/detail.dart';
import 'package:ohmybooks_app/view/home.dart';
import 'package:ohmybooks_app/view/loading.dart';
import 'package:ohmybooks_app/view/webview.dart';
import 'package:ohmybooks_app/view/welcome.dart';

Route<dynamic>? initGeneratedRoutes(
    RouteSettings settings, BuildContext context) {
  final args =
      (settings.arguments ?? <String, dynamic>{}) as Map<String, dynamic>;

  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const Loading());
    case '/welcome':
      return MaterialPageRoute(builder: (_) => const WelcomePage());
    case '/home':
      return MaterialPageRoute(builder: (_) => const Home());
    case '/detail':
      return MaterialPageRoute(
        builder: (builderContext) => MultiBlocProvider(
          providers: [
            BlocProvider<StoryBloc>.value(
                value: builderContext.read<StoryBloc>()),
            BlocProvider<ShelfBloc>.value(
                value: builderContext.read<ShelfBloc>()),
          ],
          child: Detail(data: args),
        ),
      );
    case '/webview':
      return MaterialPageRoute(
          builder: (_) => WebView(
                pageUrl: args['url'] ?? "https://www.google.com",
              ));
    default:
      return null;
  }
}
