import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ohmybooks_app/bloc/shelf/event/shelf_changeimage_event.dart';
import 'package:ohmybooks_app/bloc/shelf/shelf_bloc.dart';
import 'package:ohmybooks_app/datasource/local_manager.dart';
import 'package:ohmybooks_app/system/dimensions.dart';
import 'package:ohmybooks_app/widget/global/circle_button.dart';

class SelectBackgroundDialog extends StatelessWidget {
  SelectBackgroundDialog({super.key});

  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 60),
      child: Container(
        height: 200 * getScaleFactorFromHeight(context),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              "배경선택",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 16 * getScaleFactorFromWidth(context),
                fontFamily: 'SpoqaHanSans',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10 * getScaleFactorFromHeight(context)),
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemBuilder: (_, index) => SizedBox(
                  width: 200 * getScaleFactorFromWidth(context),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          backgrounds[index]['image'],
                          width: 160,
                          height: 90,
                          fit: BoxFit.fitWidth,
                        ),
                        Text(
                          backgrounds[index]['name'],
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontSize: 8 * getScaleFactorFromWidth(context),
                            fontFamily: 'SpoqaHanSans',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                itemCount: backgrounds.length,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleButton(
                  text: "적용",
                  width: 60,
                  height: 30,
                  onPressEvent: () {
                    final bloc = context.read<ShelfBloc>();
                    int currIndex = controller.page!.toInt();
                    bloc.add(
                        ShelfChangeImageEvent(backgrounds[currIndex]['image']));
                    Navigator.pop(context);
                  },
                ),
                CircleButton(
                  text: "배경지우기",
                  width: 80,
                  height: 30,
                  onPressEvent: () {
                    final bloc = context.read<ShelfBloc>();
                    int currIndex = controller.page!.toInt();
                    bloc.add(ShelfChangeImageEvent(""));
                    Navigator.pop(context);
                  },
                ),
                CircleButton(
                  text: "닫기",
                  width: 60,
                  height: 30,
                  onPressEvent: () => Navigator.pop(context),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
