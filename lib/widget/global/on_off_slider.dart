import 'package:flutter/material.dart';
import 'package:ohmybooks_app/system/dimensions.dart';

class OnOffSlider extends StatefulWidget {
  final Function(BuildContext context, bool) onChangeValue;
  final Duration duration;
  bool initialValue;

  OnOffSlider({
    super.key,
    required this.onChangeValue,
    required this.duration,
    required this.initialValue,
  });

  @override
  State<OnOffSlider> createState() => _OnOffSliderState();
}

class _OnOffSliderState extends State<OnOffSlider> {
  double offset = 0;

  @override
  void initState() {
    offset = widget.initialValue ? 25 : 0;
    super.initState();
  }

  void setOffset() {
    setState(() {
      widget.initialValue = offset == 0;
      offset = widget.initialValue ? 25 : 0;
      widget.onChangeValue(context, widget.initialValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: .8,
      child: Stack(
        children: [
          AnimatedContainer(
            duration: widget.duration,
            clipBehavior: Clip.hardEdge,
            width: 40 * getScaleFactorFromWidth(context),
            height: 15 * getScaleFactorFromWidth(context),
            decoration: BoxDecoration(
              color: widget.initialValue
                  ? const Color(0xFF1CBA3E)
                  : const Color(0xFFD9DDEB),
              borderRadius: BorderRadius.circular(180),
            ),
          ),
          InkWell(
            onTap: setOffset,
            child: AnimatedContainer(
              duration: widget.duration,
              width: 15 * getScaleFactorFromWidth(context),
              height: 15 * getScaleFactorFromWidth(context),
              margin: EdgeInsets.only(
                  left: offset * getScaleFactorFromWidth(context)),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(180),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(.5),
                    offset: const Offset(0, 1),
                    blurRadius: 1,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
