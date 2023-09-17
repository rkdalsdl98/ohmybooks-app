import 'package:flutter/material.dart';
import 'package:ohmybooks_app/system/dimensions.dart';
import 'package:ohmybooks_app/widget/global/book.dart';
import 'package:ohmybooks_app/widget/global/circle_button.dart';
import 'package:ohmybooks_app/widget/global/rounded_button.dart';

class DetailInfoItem extends StatefulWidget {
  final String thumbnail;
  final String updatedAt;
  final String authors;
  final String publisher;
  final int price;
  final int salePrice;
  final String status;
  final String isbn;
  final Function(BuildContext) onKeepBook;

  const DetailInfoItem({
    super.key,
    required this.updatedAt,
    required this.authors,
    required this.publisher,
    required this.price,
    required this.salePrice,
    required this.status,
    required this.isbn,
    required this.thumbnail,
    required this.onKeepBook,
  });

  @override
  State<DetailInfoItem> createState() => _DetailInfoItemState();
}

class _DetailInfoItemState extends State<DetailInfoItem> {
  keepBook() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 80),
        child: Container(
          padding: const EdgeInsets.all(10),
          clipBehavior: Clip.hardEdge,
          width: double.maxFinite,
          height: 120 * getScaleFactorFromWidth(context),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 4,
                color: Theme.of(context).colorScheme.shadow.withOpacity(.25),
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "보관함에 담기",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.shadow,
                  fontSize: 12 * getScaleFactorFromWidth(context),
                  fontFamily: 'SpoqaHanSans',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "이 책을 보관함에 담으시겠어요?",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.shadow,
                  fontSize: 10 * getScaleFactorFromWidth(context),
                  fontFamily: 'SpoqaHanSans',
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Spacer(),
                  CircleButton(
                    width: 60,
                    height: 30,
                    text: "확인",
                    onPressEvent: () {
                      widget.onKeepBook(context);
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  CircleButton(
                    width: 60,
                    height: 30,
                    text: "닫기",
                    onPressEvent: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceCrossAxisMode =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 30,
      ),
      width: MediaQuery.of(context).size.width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Book(
            thumbnail: widget.thumbnail,
            isbn: widget.isbn,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.updatedAt} 출판",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize: 4 * getScaleFactorFromWidth(context),
                      fontFamily: 'SpoqaHanSans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 10 * getScaleFactorFromHeight(context),
                  ),
                  RoundedButton(
                    text: "책장에 담기",
                    height: deviceCrossAxisMode ? 20 : 30,
                    onPressEvent: keepBook,
                  ),
                ],
              ),
              RichText(
                textAlign: TextAlign.right,
                text: TextSpan(
                  text: widget.authors.isEmpty
                      ? "저자 / 저자미상\n\n"
                      : "저자 / ${widget.authors.length >= 10 ? widget.authors.substring(0, 10).padRight(13, ".") : widget.authors}\n\n",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 4 * getScaleFactorFromWidth(context),
                    fontFamily: 'SpoqaHanSans',
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(text: "출판사 / ${widget.publisher}\n\n"),
                    TextSpan(text: "가격 / ${widget.price}원\n\n"),
                    TextSpan(text: "할인가격 / ${widget.salePrice}원\n\n"),
                    TextSpan(text: widget.status),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
