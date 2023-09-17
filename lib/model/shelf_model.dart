import 'dart:convert';

import 'package:ohmybooks_app/model/book_model.dart';

class ShelfModel {
  List<BookModel>? books;
  String? backgroundImage;

  ShelfModel(this.books, this.backgroundImage);

  ShelfModel.fromJson(Map<String, dynamic> json) {
    backgroundImage = json['image'];
    if (json['books'] != null) {
      books = [...json['books'].map((v) => BookModel.fromJson(jsonDecode(v)))];
    } else {
      books = <BookModel>[];
    }
  }

  Map<String, dynamic> toJson() => {
        "image": backgroundImage,
        "books": books!.map((v) => jsonEncode(v.toJson())).toList(),
      };
}
