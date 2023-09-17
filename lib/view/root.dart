import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ohmybooks_app/bloc/book/book_bloc.dart';
import 'package:ohmybooks_app/bloc/shelf/shelf_bloc.dart';
import 'package:ohmybooks_app/bloc/story/story_bloc.dart';
import 'package:ohmybooks_app/datasource/api_manger.dart';
import 'package:ohmybooks_app/repository/book_repository.dart';
import 'package:ohmybooks_app/repository/shelf_repository.dart';
import 'package:ohmybooks_app/repository/story_repository.dart';
import 'package:ohmybooks_app/system/color_themes.dart';
import 'package:ohmybooks_app/view/home.dart';
import 'package:ohmybooks_app/view/loading.dart';
import 'package:ohmybooks_app/view/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<BookRepository>(
            create: (_) => BookRepository(ApiManager())),
        RepositoryProvider<ShelfRepository>(create: (_) => ShelfRepository()),
        RepositoryProvider<StoryRepository>(create: (_) => StoryRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<BookBloc>(
              create: (bookContext) =>
                  BookBloc(bookContext.read<BookRepository>())),
          BlocProvider<ShelfBloc>(
              create: (shelfContext) =>
                  ShelfBloc(shelfContext.read<ShelfRepository>())),
          BlocProvider<StoryBloc>(
              create: (storyContext) =>
                  StoryBloc(storyContext.read<StoryRepository>())),
        ],
        child: MaterialApp(
          title: "OhMyBooks",
          theme: ThemeData(
            colorScheme: lightColorTheme,
            useMaterial3: true,
          ),
          supportedLocales: const [
            Locale('ko', 'KR'),
            Locale('en', 'US'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          onGenerateRoute: (settings) => initGeneratedRoutes(settings, context),
          home: const Loading(),
        ),
      ),
    );
  }
}
