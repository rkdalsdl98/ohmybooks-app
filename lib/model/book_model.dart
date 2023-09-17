import 'package:equatable/equatable.dart';

class BookModel extends Equatable {
  List<dynamic>? authors, translators;
  String? contents,
      publisher,
      status,
      thumbnail,
      title,
      pageUrl,
      datetime,
      isbn;
  int? price, salePrice;

  BookModel.fromJson(Map<String, dynamic> json)
      : authors = json['authors'],
        contents = json['contents'],
        publisher = json['publisher'],
        status = json['status'],
        thumbnail = json['thumbnail'],
        title = json['title'],
        pageUrl = json['url'],
        datetime = json['datetime'].substring(0, 10),
        price = json['price'],
        salePrice = json['sale_price'],
        translators = json['translators'],
        isbn = json['isbn'];

  Map<String, dynamic> toJson() => {
        "authors": authors,
        "contents": contents,
        "publisher": publisher,
        "status": status,
        "thumbnail": thumbnail,
        "title": title,
        "url": pageUrl,
        "datetime": datetime,
        "price": price,
        "sale_price": salePrice,
        "translators": translators,
        "isbn": isbn,
      };

  @override
  List<Object?> get props => [isbn, authors, translators];
}
