import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ohmybooks_app/bloc/book/book_bloc.dart';
import 'package:ohmybooks_app/bloc/book/event/book_initialize_event.dart';
import 'package:ohmybooks_app/bloc/book/event/book_save_event.dart';
import 'package:ohmybooks_app/system/dimensions.dart';
import 'package:ohmybooks_app/system/message.dart';
import 'package:ohmybooks_app/widget/home/history/history.dart';
import 'package:ohmybooks_app/widget/home/search/search.dart';
import 'package:ohmybooks_app/widget/home/shelf/shelf.dart';

double bottomNavigatorHeight = 80;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  int currIndex = 0;
  final ValueNotifier<bool> hiddenNavBar = ValueNotifier<bool>(true);

  void setCurrIndex(int index) => setState(() {
        currIndex = index;
      });
  void hiddenNavigationBar() {
    hiddenNavBar.value = !hiddenNavBar.value;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      final bloc = context.read<BookBloc>();
      final now = DateTime.now().weekday;
      if (now != bloc.getCurrWeekday()) {
        showResetDialog(bloc);
      }
    }
  }

  showResetDialog(BookBloc bloc) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(
          '날짜가 변경되어 검색 횟수를 초기화 합니다\n확인 버튼을 눌러야 초기화 됩니다',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 14 * getScaleFactorFromWidth(context),
            fontFamily: 'SpoqaHanSans',
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              '확인',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 12 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () {
              bloc.add(BookInitializeEvent());
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final bloc = context.read<BookBloc>();
        bloc.add(BookSaveEvent());
        await Future.delayed(const Duration(milliseconds: 100))
            .then((_) async => await initWillPopMessage(context));

        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        bottomNavigationBar: ValueListenableBuilder<bool>(
          valueListenable: hiddenNavBar,
          builder: (builderContext, isHidden, _) => AnimatedContainer(
            height: hiddenNavBar.value ? bottomNavigatorHeight : 0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
            child: NavigationBar(
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              onDestinationSelected: setCurrIndex,
              selectedIndex: currIndex,
              backgroundColor: Theme.of(builderContext).colorScheme.secondary,
              indicatorColor: Theme.of(builderContext).colorScheme.onSecondary,
              destinations: const [
                NavigationDestination(
                  icon: Icon(
                    Icons.access_time_outlined,
                    color: Color(0xFF001B3D),
                  ),
                  label: "이야기",
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.menu_book_rounded,
                    color: Color(0xFF001B3D),
                  ),
                  label: "책 찾기",
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.book_rounded,
                    color: Color(0xFF001B3D),
                  ),
                  label: "책 보관함",
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            IndexedStack(
              index: currIndex,
              children: [
                const History(),
                const Search(),
                Shelf(hiddenBottomNavigationBar: hiddenNavigationBar),
              ],
            )
          ],
        ),
      ),
    );
  }
}
