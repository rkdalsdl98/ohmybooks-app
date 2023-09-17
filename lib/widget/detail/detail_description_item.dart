import 'package:flutter/material.dart';
import 'package:ohmybooks_app/system/dimensions.dart';
import 'package:ohmybooks_app/widget/global/rounded_button.dart';

class DetailDescriptionItem extends StatelessWidget {
  final String title;
  final String description;
  final String pageUrl;

  const DetailDescriptionItem({
    super.key,
    required this.title,
    required this.description,
    required this.pageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final deviceCrossAxisMode =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 40,
      ),
      width: MediaQuery.of(context).size.width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 8 * getScaleFactorFromWidth(context),
              fontFamily: 'SpoqaHanSans',
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            description.padRight(description.length + 3, "."),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 6 * getScaleFactorFromWidth(context),
              fontFamily: 'SpoqaHanSans',
              fontWeight: FontWeight.w300,
              height: 1.6,
            ),
          ),
          RoundedButton(
            text: "관련페이지 이동",
            width: 120,
            height: deviceCrossAxisMode ? 20 : 30,
            onPressEvent: () {
              Navigator.pushNamed(context, '/webview', arguments: {
                "url": pageUrl,
              });
            },
          ),
        ],
      ),
    );
  }
}
