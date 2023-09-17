import 'package:flutter/material.dart';
import 'package:ohmybooks_app/system/dimensions.dart';
import 'package:rive/rive.dart';

class MenuIcon extends StatefulWidget {
  final String iconName;
  final double width;
  final double height;
  final int currIndex;
  final int index;
  final String title;
  final Function(int) setCurrIndex;

  const MenuIcon({
    super.key,
    required this.iconName,
    required this.width,
    required this.height,
    required this.setCurrIndex,
    required this.index,
    required this.currIndex,
    required this.title,
  });

  @override
  State<MenuIcon> createState() => _MenuIconState();
}

class _MenuIconState extends State<MenuIcon> {
  Artboard? _riveArtboard;
  SMIInput<double>? _input;
  double titleOpacity = 0;

  void setAnimState() {
    if (widget.currIndex == widget.index) {
      _input?.change(1);
      titleOpacity = 1;
    } else {
      _input?.change(0);
      titleOpacity = 0;
    }
  }

  @override
  void initState() {
    super.initState();
    final bundle = DefaultAssetBundle.of(context);
    bundle.load('assets/rive/${widget.iconName}.riv').then(
      (data) {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        var controller =
            StateMachineController.fromArtboard(artboard, 'State Machine 1');
        if (controller != null) {
          artboard.addController(controller);
          _input = controller.findInput('input');
        }
        setAnimState();
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  @override
  void didUpdateWidget(covariant MenuIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    setAnimState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width * getScaleFactorFromWidth(context),
      height: widget.height * getScaleFactorFromHeight(context),
      child: _riveArtboard == null
          ? const Center(child: CircularProgressIndicator())
          : GestureDetector(
              onTap: () {
                setAnimState();
                widget.setCurrIndex(widget.index);
              },
              child: Stack(
                children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Rive(artboard: _riveArtboard!)),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.fastOutSlowIn,
                    opacity: titleOpacity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 12 * getScaleFactorFromHeight(context),
                            fontFamily: 'SpoqaHanSans',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
