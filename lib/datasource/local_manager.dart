import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getLocalStringData(String key) async {
  try {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getString(key);
  } catch (e) {
    rethrow;
  }
}

Future<int?> getLocalIntData(String key) async {
  try {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getInt(key);
  } catch (e) {
    rethrow;
  }
}

Future<List<String>?> getLocalStringListData(String key) async {
  try {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getStringList(key);
  } catch (e) {
    rethrow;
  }
}

Future<void> saveLocalStringData(String key, String data) async {
  try {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setString(key, data);
  } catch (e) {
    rethrow;
  }
}

Future<void> saveLocalIntData(String key, int data) async {
  try {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setInt(key, data);
  } catch (e) {
    rethrow;
  }
}

Future<void> saveLocalStringListData(String key, List<String> data) async {
  try {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setStringList(key, data);
  } catch (e) {
    rethrow;
  }
}

Future<void> removeData(String key) async {
  try {
    final SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.remove(key);
  } catch (e) {
    rethrow;
  }
}

const List<Map<String, dynamic>> backgrounds = [
  {"image": "assets/img/shelf_water.png", "name": "바다"},
  {"image": "assets/img/shelf_forest_ps.png", "name": "숲"},
  {"image": "assets/img/shelf_winter_ps.png", "name": "겨울도시"},
];

const List<Map<String, dynamic>> storyBackgrounds = [
  {"image": "assets/img/story_forest.png", "name": "숲/낙엽"},
  {"image": "assets/img/story_winter.png", "name": "겨울/선물"},
  {"image": "assets/img/story_water.png", "name": "바다/산호"},
];
