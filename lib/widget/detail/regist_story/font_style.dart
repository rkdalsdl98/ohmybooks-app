import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:ohmybooks_app/bloc/regist/event/regist_style_apply_event.dart';
import 'package:ohmybooks_app/bloc/regist/regist_bloc.dart';
import 'package:ohmybooks_app/system/dimensions.dart';
import 'package:ohmybooks_app/widget/detail/regist_story/font_style_size.dart';
import 'package:ohmybooks_app/widget/detail/regist_story/font_style_weight.dart';
import 'package:ohmybooks_app/widget/global/custom_slider.dart';

class FontStyle extends StatefulWidget {
  const FontStyle({
    super.key,
  });

  @override
  State<FontStyle> createState() => _FontStyleState();
}

class _FontStyleState extends State<FontStyle> {
  Color selColor = Colors.white;

  void onChangedStyle({
    Color? color,
    double? size,
    FontWeight? weight,
    double? height,
    double? wordSpacing,
    double? letterSpacing,
  }) {
    final bloc = context.read<RegistBloc>();
    final prevStyle = bloc.getStyle();

    bloc.add(
      RegistStyleApplyEvent(prevStyle.copyWith(
        color: color ?? prevStyle.color,
        fontSize: size ?? prevStyle.fontSize,
        fontWeight: weight ?? prevStyle.fontWeight,
        height: height ?? prevStyle.height,
        wordSpacing: wordSpacing ?? prevStyle.wordSpacing,
        letterSpacing: letterSpacing ?? prevStyle.letterSpacing,
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceCrossAxisMode =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;
    final bloc = context.read<RegistBloc>();
    final prevStyle = bloc.getStyle();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          child: Stack(
            children: [
              SizedBox(
                width: 200 * getScaleFactorFromWidth(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 80 * getScaleFactorFromWidth(context),
                      height: 80 * getScaleFactorFromWidth(context),
                      child: Text(
                        "글에 입력되는 글자를 커스텀하여 넣을 수 있습니다.\n결과는 미리보기를 통해 확인 할 수 있습니다.\n비어있는 값은 기본 값으로 설정됩니다.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(.5),
                          fontSize: 6 * getScaleFactorFromWidth(context),
                          fontFamily: 'SpoqaHanSans',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    FontStyleSize(onChangeStyle: onChangedStyle),
                    FontStyleWeight(onChangeStyle: onChangedStyle),
                  ],
                ),
              ),
              Positioned(
                left: (deviceCrossAxisMode ? 250 : 210) *
                    getScaleFactorFromWidth(context),
                child: SlidePicker(
                  sliderTextStyle: TextStyle(
                    fontFamily: 'SpoqaHanSans',
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(.8),
                    fontWeight: FontWeight.w400,
                  ),
                  indicatorBorderRadius:
                      const BorderRadius.all(Radius.circular(15)),
                  pickerColor: selColor,
                  sliderSize: const Size(150, 20),
                  indicatorSize: const Size(100, 40),
                  onColorChanged: (color) {
                    setState(() {
                      selColor = color;
                      onChangedStyle(color: color);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20 * getScaleFactorFromHeight(context)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomSlider(
              min: 0,
              max: 2,
              value: prevStyle.letterSpacing!,
              onChanged: (value) => onChangedStyle(letterSpacing: value),
              width: 100,
              title: "글자 간격",
            ),
            CustomSlider(
              min: 0,
              max: 1,
              value: prevStyle.wordSpacing!,
              onChanged: (value) => onChangedStyle(wordSpacing: value),
              width: 100,
              title: "단어 간격",
            ),
            CustomSlider(
              min: 0,
              max: 2,
              value: prevStyle.height!,
              onChanged: (value) => onChangedStyle(height: value),
              width: 100,
              title: "글자 높이",
            ),
          ],
        ),
      ],
    );
  }
}
