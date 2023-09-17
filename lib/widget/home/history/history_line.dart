import 'package:flutter/material.dart';
import 'package:ohmybooks_app/system/dimensions.dart';
import 'package:ohmybooks_app/widget/home/history/scale_anim_square.dart';

class HistoryLine extends StatefulWidget {
  final int animSeconds;

  const HistoryLine({
    super.key,
    required this.animSeconds,
  });

  @override
  State<HistoryLine> createState() => _HistoryLineState();
}

class _HistoryLineState extends State<HistoryLine> {
  int height = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100)).then((_) {
      setState(() {
        height = 280 * getScaleFactorFromHeight(context).toInt();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ScaleAnimSquare(
          curve: Curves.fastOutSlowIn,
          size: 12,
          borderWidth: 0,
          duration: const Duration(milliseconds: 600),
          color: const Color(0xFFB07748),
        ),
        SizedBox(height: 2 * getScaleFactorFromHeight(context)),
        AnimatedContainer(
          duration: Duration(seconds: widget.animSeconds),
          curve: Curves.fastEaseInToSlowEaseOut,
          width: 4 * getScaleFactorFromWidth(context),
          height: height * getScaleFactorFromWidth(context),
          color: const Color(0xFFB07748),
        ),
      ],
    );
  }
}
