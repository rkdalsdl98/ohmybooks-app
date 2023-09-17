import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ohmybooks_app/datasource/api_manger.dart';
import 'package:ohmybooks_app/datasource/local_manager.dart' as LocalManager;
import 'package:ohmybooks_app/model/book_api_metadata_model.dart';

class BookRepository {
  ApiManager apiManager;
  BookRepository(this.apiManager);

  Future<Response> getSearchBooks(
    String searchterm,
    int page, {
    String? target,
  }) async {
    try {
      return await apiManager.getRequestByBookAPI(
        "/v3/search/book",
        queryParams: {
          "query": searchterm == "" ? "책" : searchterm,
          "target": target ?? "",
          "size": "50",
          "page": "$page",
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  saveMetaData(BookApiMetaDataModel data) async {
    try {
      final toJsonStrList = jsonEncode(data.toJson());
      await LocalManager.saveLocalStringData("book-meta", toJsonStrList);
    } catch (e) {
      rethrow;
    }
  }

  loadMetaData() async {
    try {
      final rawData = await LocalManager.getLocalStringData("book-meta");
      return rawData == null || rawData.isEmpty
          ? saveMetaData(BookApiMetaDataModel(
              searchCount: 0,
              weekday: DateTime.now().weekday,
            )).then((_) => BookApiMetaDataModel(
                searchCount: 0,
                weekday: DateTime.now().weekday,
              ))
          : BookApiMetaDataModel.fromJson(jsonDecode(rawData));
    } catch (e) {
      rethrow;
    }
  }
}
