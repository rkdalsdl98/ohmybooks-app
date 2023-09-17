import 'package:flutter/material.dart';
import 'package:ohmybooks_app/system/dimensions.dart';

class ScaleAnimSquare extends StatefulWidget {
  final Curve curve;
  final Duration duration;
  final double size;
  final double borderWidth;
  Color? color;

  ScaleAnimSquare({
    super.key,
    required this.curve,
    required this.size,
    required this.borderWidth,
    required this.duration,
    this.color,
  });

  @override
  State<ScaleAnimSquare> createState() => _ScaleAnimSquareState();
}

class _ScaleAnimSquareState extends State<ScaleAnimSquare>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: widget.duration,
    vsync: this,
  )..forward();

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: widget.curve,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Container(
        width: widget.size * getScaleFactorFromWidth(context),
        height: widget.size * getScaleFactorFromWidth(context),
        decoration: BoxDecoration(
          color: widget.color ?? Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(180),
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary.withOpacity(.5),
            width: widget.borderWidth * getScaleFactorFromWidth(context),
          ),
        ),
      ),
    );
  }
}
