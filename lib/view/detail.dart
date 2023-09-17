import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ohmybooks_app/bloc/shelf/event/shelf_keep_event.dart';
import 'package:ohmybooks_app/bloc/shelf/shelf_bloc.dart';
import 'package:ohmybooks_app/bloc/story/story_bloc.dart';
import 'package:ohmybooks_app/model/book_model.dart';
import 'package:ohmybooks_app/repository/story_repository.dart';
import 'package:ohmybooks_app/system/message.dart';
import 'package:ohmybooks_app/widget/detail/detail_description_item.dart';
import 'package:ohmybooks_app/widget/detail/detail_info_item.dart';
import 'package:ohmybooks_app/widget/detail/story.dart';

class Detail extends StatelessWidget {
  final Map<String, dynamic> data;

  const Detail({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final BookModel book = BookModel.fromJson(data["data"]);
    final deviceCrossAxisMode =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height;
    var deviceHeight = deviceCrossAxisMode
        ? MediaQuery.of(context).size.width
        : MediaQuery.of(context).size.height;

    keepBook(BuildContext context) {
      final bloc = context.read<ShelfBloc>();

      if (bloc.isSubcribeBook(book)) {
        initSnackBarMessage(context, "이미 보관함에 등록된 책 입니다");
      } else {
        bloc.add(ShelfKeepEvent(book));
        initSnackBarMessage(context, "보관함에 책을 등록 했습니다");
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: deviceHeight / 2 - 15,
              child: Row(
                children: [
                  DetailDescriptionItem(
                    title: book.title ?? "",
                    description: book.contents ?? "",
                    pageUrl: book.pageUrl ?? "",
                  ),
                  DetailInfoItem(
                    thumbnail: book.thumbnail ?? "",
                    updatedAt: book.datetime ?? "0000-00-00",
                    authors: book.authors!.join(","),
                    price: book.price ?? 0,
                    salePrice: book.salePrice ?? 0,
                    publisher: book.publisher ?? "모름",
                    status: book.status ?? "확인불가",
                    isbn: book.isbn ?? "",
                    onKeepBook: keepBook,
                  ),
                ],
              ),
            ),
            Story(
              deviceHeight: deviceHeight,
              deviceCrossAxisMode: deviceCrossAxisMode,
              book: book,
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
                bottom: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}
