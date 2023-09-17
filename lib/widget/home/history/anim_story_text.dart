import 'package:flutter/material.dart';
import 'package:ohmybooks_app/system/dimensions.dart';

class AnimStoryText extends StatefulWidget {
  final TextStyle style;
  final String text;

  const AnimStoryText({
    super.key,
    required this.style,
    required this.text,
  });

  @override
  State<AnimStoryText> createState() => _AnimStoryTextState();
}

class _AnimStoryTextState extends State<AnimStoryText> {
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          opacity = 1;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 600),
      curve: Curves.fastOutSlowIn,
      child: SizedBox(
        width: 160 * getScaleFactorFromWidth(context),
        child: Text(
          widget.text,
          style: widget.style.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
