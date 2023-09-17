class BookMetaDataModel {
  int? totalCount, pageAbleCount;
  bool? isEnd;

  BookMetaDataModel.fromJson(Map<String, dynamic> json)
      : totalCount = json['total_count'],
        pageAbleCount = json['pageable_count'],
        isEnd = json['is_end'];

  BookMetaDataModel({this.totalCount, this.pageAbleCount, this.isEnd});

  Map<String, dynamic> toJson() => {
        "total_count": totalCount,
        "pageable_count": pageAbleCount,
        "is_end": isEnd,
      };
}
