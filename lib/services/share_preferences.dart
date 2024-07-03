import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    // initialize shared preferences
    _prefs = await SharedPreferences.getInstance();
  }

  static void saveSelectedLanguage(String languageCode) {
    _prefs.setString('selectedLanguage', languageCode);
  }

  static String? loadSelectedLanguage() {
    return _prefs.getString('selectedLanguage');
  }

  static void saveOnboardingExist(bool isExist) {
    _prefs.setBool("onboardingExist", isExist);
  }

  static bool loadOnboardingExist() {
    return _prefs.getBool("onboardingExist") ?? false;
  }

  // save drawer tapped index
  static void saveDrawerTappedIndex(int index) {
    _prefs.setInt("drawerTappedIndex", index);
  }

  // get drawer tapped
  static int loadDrawerTappedIndex() {
    return _prefs.getInt("drawerTappedIndex") ?? 0;
  }

  // clear drawer tapped
  static void clearDrawerTappedIndex() {
    _prefs.setInt("drawerTappedIndex", 0);
  }
}
