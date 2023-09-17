import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ohmybooks_app/bloc/regist/regist_bloc.dart';
import 'package:ohmybooks_app/bloc/regist/regist_state.dart';
import 'package:ohmybooks_app/system/dimensions.dart';
import 'package:ohmybooks_app/system/handle_errors.dart';

class StoryPreview extends StatelessWidget {
  const StoryPreview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final deviceCrossAxisMode =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;
    final double scale = deviceCrossAxisMode ? .8 : 1.0;
    return BlocBuilder<RegistBloc, RegistState>(
      builder: (_, state) {
        final TextStyle style = state.style!;
        List<String> image = state.imageUrl!.split(":");

        String category = image[0];
        String path = image[1];

        if (state is RegistErrorState) {
          onImageError(state.errorMessage, context);
        }
        return Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "미리보기",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 12 * getScaleFactorFromWidth(context),
                    fontFamily: 'SpoqaHanSans',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              height: 250 * getScaleFactorFromHeight(context),
              decoration: BoxDecoration(
                image: path == "null"
                    ? null
                    : category == "asset"
                        ? DecorationImage(
                            image: AssetImage(path),
                            fit: BoxFit.fitWidth,
                            opacity: state.backgroundOpacity!,
                          )
                        : DecorationImage(
                            image: FileImage(File(path)),
                            onError: (exception, stackTrace) => onImageError(
                              exception.toString(),
                              context,
                            ),
                            fit: BoxFit.fitWidth,
                            opacity: state.backgroundOpacity!,
                          ),
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: 300 * getScaleFactorFromWidth(context),
                    height: 150 * getScaleFactorFromHeight(context),
                    child: Center(
                      child: Text(
                        state.text!,
                        style: style,
                      ),
                    ),
                  )),
            ),
          ],
        );
      },
    );
  }
}
