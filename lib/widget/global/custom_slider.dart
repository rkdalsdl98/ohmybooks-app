import 'package:flutter/material.dart';
import 'package:ohmybooks_app/system/dimensions.dart';

class CustomSlider extends StatefulWidget {
  double min;
  double max;
  double value;
  final String title;
  final double width;
  Function(double) onChanged;

  CustomSlider({
    super.key,
    required this.max,
    required this.min,
    required this.onChanged,
    required this.width,
    required this.title,
    required this.value,
  });

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width * getScaleFactorFromWidth(context),
      height: 60 * getScaleFactorFromHeight(context),
      child: Column(
        children: [
          Text(
            widget.title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 8 * getScaleFactorFromWidth(context),
              fontFamily: 'SpoqaHanSans',
              fontWeight: FontWeight.w500,
            ),
          ),
          SliderTheme(
            data: const SliderThemeData(
              activeTrackColor: Colors.amber,
              trackHeight: 1,
            ),
            child: Slider(
              value: widget.value,
              min: widget.min,
              max: widget.max,
              onChanged: (newValue) => setState(() {
                widget.value = newValue;
                widget.onChanged(newValue);
              }),
            ),
          ),
        ],
      ),
    );
  }
}
