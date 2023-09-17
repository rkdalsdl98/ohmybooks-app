class BookApiMetaDataModel {
  int? weekday, searchCount;

  BookApiMetaDataModel({this.searchCount, this.weekday});

  BookApiMetaDataModel.fromJson(Map<String, dynamic> json)
      : weekday = json['weekday'],
        searchCount = json['search-count'];

  Map<String, dynamic> toJson() => {
        "weekday": weekday,
        "search-count": searchCount,
      };

  increaseCount() => searchCount = (searchCount ?? 0) + 1;
  setWeekDay(int newWeekDay) => weekday = newWeekDay;
}
