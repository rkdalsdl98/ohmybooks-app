import 'package:flutter/material.dart';
import 'package:ohmybooks_app/system/dimensions.dart';
import 'package:ohmybooks_app/widget/global/navigator_bar/menu_icon.dart';

class AnimBottomNavigator extends StatefulWidget {
  final double height;
  final int currIndex;
  final Function(int) onChangeMenu;

  const AnimBottomNavigator({
    super.key,
    required this.height,
    required this.onChangeMenu,
    required this.currIndex,
  });

  @override
  State<AnimBottomNavigator> createState() => _AnimBottomNavigatorState();
}

class _AnimBottomNavigatorState extends State<AnimBottomNavigator> {
  void setCurrIndex(int index) {
    widget.onChangeMenu(index);
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> menus = [
      {"clock_new": "이야기"},
      {"booksearch_new": "책 찾기"},
      {"book_new": "책 보관함"},
    ];
    final deviceCrossAxisMode =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;

    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        height: widget.height * getScaleFactorFromHeight(context),
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              margin: EdgeInsets.only(
                left: ((deviceCrossAxisMode ? 39 : 13) *
                        getScaleFactorFromWidth(context)) +
                    (widget.currIndex *
                        (MediaQuery.of(context).size.width / 3)),
              ),
              width: 100 * getScaleFactorFromHeight(context),
              height: 60 * getScaleFactorFromHeight(context),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(360)),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 80 * getScaleFactorFromHeight(context),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            for (int i = 0; i < menus.length; ++i)
              Positioned(
                left: 10 + (i * (MediaQuery.of(context).size.width / 3)),
                bottom: 0,
                child: MenuIcon(
                  currIndex: widget.currIndex,
                  iconName: menus[i].keys.first,
                  title: menus[i].values.first,
                  width: 100,
                  height: 100,
                  index: i,
                  setCurrIndex: setCurrIndex,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
