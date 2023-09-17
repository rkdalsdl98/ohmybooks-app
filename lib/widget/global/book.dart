import 'package:flutter/material.dart';
import 'package:ohmybooks_app/system/dimensions.dart';
import 'package:ohmybooks_app/view/home.dart';

class Book extends StatelessWidget {
  final String thumbnail;
  final String isbn;
  double width;
  double height;
  double errorTextSize;
  double errorIconSize;
  double rotate;

  Book({
    super.key,
    required this.thumbnail,
    this.width = 160,
    this.height = 224.52,
    this.errorIconSize = 32,
    this.errorTextSize = 8,
    this.rotate = 0,
    required this.isbn,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotate,
      child: Stack(
        children: [
          Container(
            width: width *
                getScaleFactorFromHeight(
                  context,
                  bottomNavigatorHeight: bottomNavigatorHeight,
                ),
            height: height *
                getScaleFactorFromHeight(
                  context,
                  bottomNavigatorHeight: bottomNavigatorHeight,
                ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onBackground,
              border: Border.all(
                color: Theme.of(context).colorScheme.shadow.withOpacity(.5),
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(4, 4),
                  color: Theme.of(context).colorScheme.shadow.withOpacity(.25),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Theme.of(context).colorScheme.shadow.withOpacity(.5),
                ),
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.shadow.withOpacity(.5),
                ),
              ),
            ),
            width: (width - 4) *
                getScaleFactorFromHeight(
                  context,
                  bottomNavigatorHeight: bottomNavigatorHeight,
                ),
            height: (height - 5) *
                getScaleFactorFromHeight(
                  context,
                  bottomNavigatorHeight: bottomNavigatorHeight,
                ),
            child: Image.network(
              thumbnail,
              fit: BoxFit.fitWidth,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return imageLoadFailedHelper(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget imageLoadFailedHelper(BuildContext context) {
    return Container(
      color: const Color(0xFFD6D6D6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image,
            color: Colors.black.withOpacity(.5),
            size: errorIconSize *
                getScaleFactorFromHeight(
                  context,
                  bottomNavigatorHeight: bottomNavigatorHeight,
                ),
          ),
          SizedBox(
            height: 5 *
                getScaleFactorFromHeight(
                  context,
                  bottomNavigatorHeight: bottomNavigatorHeight,
                ),
          ),
          Text(
            "사진을 불러오는데 실패했습니다.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black.withOpacity(.5),
              fontSize: errorTextSize *
                  getScaleFactorFromHeight(
                    context,
                    bottomNavigatorHeight: bottomNavigatorHeight,
                  ),
              fontFamily: 'SpoqaHanSans',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
