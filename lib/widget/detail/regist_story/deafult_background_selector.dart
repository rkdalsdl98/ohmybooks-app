import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ohmybooks_app/bloc/regist/event/regist_change_background_event.dart';
import 'package:ohmybooks_app/bloc/regist/event/regist_change_bg_opacity_event.dart';
import 'package:ohmybooks_app/bloc/regist/regist_bloc.dart';
import 'package:ohmybooks_app/datasource/local_manager.dart';
import 'package:ohmybooks_app/system/dimensions.dart';
import 'package:ohmybooks_app/widget/global/custom_slider.dart';
import 'package:ohmybooks_app/widget/global/rounded_button.dart';
import 'package:image_picker/image_picker.dart';

class DefaultBackgroundSelector extends StatelessWidget {
  const DefaultBackgroundSelector({
    super.key,
  });

  onChangedBGOpacity(BuildContext context, double opacity) {
    final bloc = context.read<RegistBloc>();
    bloc.add(RegistChangeBGOpacityEvent(opacity));
  }

  @override
  Widget build(BuildContext context) {
    final deviceCrossAxisMode =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;
    final double scale = deviceCrossAxisMode ? .8 : 1.0;
    final bloc = context.read<RegistBloc>();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height:
          (deviceCrossAxisMode ? 400 : 220) * getScaleFactorFromHeight(context),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "배경 사진 선택",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 12 * getScaleFactorFromWidth(context),
                  fontFamily: 'SpoqaHanSans',
                  fontWeight: FontWeight.w700,
                ),
              ),
              RoundedButton(
                text: "갤러리에서 가져오기",
                width: 90 * getScaleFactorFromWidth(context),
                height: 30 * getScaleFactorFromHeight(context),
                onPressEvent: () async {
                  final picker = ImagePicker();
                  final pickImage =
                      await picker.pickImage(source: ImageSource.gallery);

                  bloc.add(
                      RegistChangeBackgroundEvent("file:${pickImage?.path}"));
                },
              ),
            ],
          ),
          SizedBox(height: 10 * getScaleFactorFromWidth(context)),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) =>
                  BackgroundItem(bloc: bloc, index: index),
              itemCount: storyBackgrounds.length + 1,
            ),
          ),
          CustomSlider(
            max: 1,
            min: 0,
            onChanged: (v) => onChangedBGOpacity(context, v),
            width: 300,
            title: "배경 투명도",
            value: bloc.getBGOpacity(),
          ),
        ],
      ),
    );
  }
}

class BackgroundItem extends StatelessWidget {
  final int index;
  final RegistBloc bloc;

  const BackgroundItem({
    super.key,
    required this.bloc,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => bloc.add(RegistChangeBackgroundEvent(
        "asset:${index == 0 ? "null" : storyBackgrounds[index - 1]['image']}",
      )),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(),
        width: 170 * getScaleFactorFromWidth(context),
        height: 120 * getScaleFactorFromWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (index == 0)
              SizedBox(
                width: double.maxFinite,
                height: 84.38 * getScaleFactorFromWidth(context),
              ),
            if (index != 0)
              Image.asset(
                storyBackgrounds[index - 1]['image'],
                fit: BoxFit.fitWidth,
                width: double.maxFinite,
                height: 84.38 * getScaleFactorFromWidth(context),
              ),
            Center(
              child: Text(
                index == 0 ? "배경 지우기" : storyBackgrounds[index - 1]['name'],
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 8 * getScaleFactorFromWidth(context),
                  fontFamily: 'SpoqaHanSans',
                  fontWeight: FontWeight.w300,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
