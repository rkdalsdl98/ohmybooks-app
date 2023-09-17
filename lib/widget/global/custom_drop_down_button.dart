import 'package:flutter/material.dart';
import 'package:ohmybooks_app/system/dimensions.dart';

class CustomDropDownButton extends StatefulWidget {
  String? currValue;
  final Function(String?) setCurrValue;
  final List<String> items;

  CustomDropDownButton({
    super.key,
    required this.currValue,
    required this.setCurrValue,
    required this.items,
  });

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  String showValue = "검색기준";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: widget.items
          .map<DropdownMenuItem<String>>(
            (category) => DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            ),
          )
          .toList(),
      icon: Align(
        alignment: Alignment.topLeft,
        child: RotatedBox(
          quarterTurns: 1,
          child: Icon(
            Icons.play_arrow_rounded,
            size: 8 * getScaleFactorFromWidth(context),
            color: Theme.of(context).colorScheme.onBackground.withOpacity(.2),
          ),
        ),
      ),
      onChanged: (v) {
        switch (v) {
          case "제목":
            widget.currValue = "title";
            break;
          case "출판사":
            widget.currValue = "publisher";
            break;
          case "저자":
            widget.currValue = "person";
            break;
          default:
            widget.currValue = null;
            break;
        }
        showValue = v!;
        setState(() {});
        widget.setCurrValue(widget.currValue);
      },
      elevation: 0,
      underline: Container(decoration: const BoxDecoration(border: Border())),
      alignment: Alignment.center,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground.withOpacity(.2),
        fontSize: 8 * getScaleFactorFromWidth(context),
        fontFamily: 'SpoqaHanSans',
        fontWeight: FontWeight.w600,
      ),
      value: showValue,
    );
  }
}
