import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _instance = Preferences._internal();
  factory Preferences() => _instance;
  Preferences._internal();
  static Preferences get instance => _instance;

  late SharedPreferencesWithCache prefs;

  Future<void> init() async {
    prefs = await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(),
    );
  }

  String? get category => prefs.getString('category');
  
  set category(String? category){
    if (category == null){
      prefs.remove('category');
    } else {
      prefs.setString('category', category);
    }
  }
}
