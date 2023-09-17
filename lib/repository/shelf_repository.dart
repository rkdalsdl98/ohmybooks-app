import 'dart:convert';

import 'package:ohmybooks_app/datasource/local_manager.dart' as LocalManager;
import 'package:ohmybooks_app/model/shelf_model.dart';

class ShelfRepository {
  saveShelfData(ShelfModel shelf) async {
    try {
      final toJsonStrList = jsonEncode(shelf.toJson());
      await LocalManager.saveLocalStringData("shelf", toJsonStrList);
    } catch (e) {
      rethrow;
    }
  }

  loadShelfData() async {
    try {
      final rawData = await LocalManager.getLocalStringData("shelf");
      return rawData == null || rawData.isEmpty
          ? ShelfModel([], "")
          : ShelfModel.fromJson(jsonDecode(rawData));
    } catch (e) {
      rethrow;
    }
  }
}
