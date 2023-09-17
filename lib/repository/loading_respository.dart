import 'package:ohmybooks_app/datasource/local_manager.dart' as LocalManager;

class LoadingRepository {
  isBeginner() async {
    try {
      final welcome = await LocalManager.getLocalIntData("welcome");
      return welcome ?? 0;
    } catch (e) {
      rethrow;
    }
  }

  saveWelcomeState(int welcome) async {
    try {
      await LocalManager.saveLocalIntData("welcome", welcome);
    } catch (e) {
      rethrow;
    }
  }
}
