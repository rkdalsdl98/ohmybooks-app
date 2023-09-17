import 'package:equatable/equatable.dart';
import 'package:ohmybooks_app/model/book_model.dart';
import 'package:ohmybooks_app/model/convert_style_model.dart';

class StoryModel extends Equatable {
  final String datetime;
  final String text;
  final String imageUrl;
  final String identifier;
  final ConverStyleModel style;
  final BookModel book;
  final double backgroundOpacity;

  const StoryModel({
    required this.identifier,
    required this.style,
    required this.datetime,
    required this.imageUrl,
    required this.text,
    required this.book,
    required this.backgroundOpacity,
  });

  StoryModel.fromJson(Map<String, dynamic> json)
      : datetime = json['datetime'],
        text = json['text'],
        imageUrl = json['url'],
        style = ConverStyleModel.fromJson(json['style']),
        identifier = json['identifier'],
        book = BookModel.fromJson(json['book']),
        backgroundOpacity = json['background-opacity'];

  Map<String, dynamic> toJson() => {
        "datetime": datetime,
        "text": text,
        "url": imageUrl,
        "style": style.toJson(),
        "identifier": identifier,
        "book": book.toJson(),
        "background-opacity": backgroundOpacity,
      };

  @override
  List<Object?> get props => [datetime];
}
