import 'dart:convert';

import 'package:ohmybooks_app/datasource/local_manager.dart' as LocalManager;
import 'package:ohmybooks_app/model/story_model.dart';

class StoryRepository {
  saveStoryData(List<StoryModel> story) async {
    try {
      final toJsonStrList = story.map((e) => jsonEncode(e.toJson())).toList();
      await LocalManager.saveLocalStringListData("story", toJsonStrList);
    } catch (e) {
      rethrow;
    }
  }

  loadStoryData() async {
    try {
      final rawData = await LocalManager.getLocalStringListData("story");
      return rawData == null || rawData.isEmpty
          ? <StoryModel>[]
          : rawData.map((e) {
              final json = jsonDecode(e);
              return StoryModel.fromJson(json);
            }).toList();
    } catch (e) {
      rethrow;
    }
  }
}
