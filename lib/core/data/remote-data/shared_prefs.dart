import 'package:dyd/core/data/remote-data/prefs_contant_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();

  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance!;
  }

  static String? getString(String key, [String? defValue]) {
    if (_prefsInstance == null || !_prefsInstance!.containsKey(key)) {
      return null;
    } else {
      return _prefsInstance!.getString(key) ?? defValue ?? "";
    }
  }

  static Future<bool> setString(String key, String value) async {
    SharedPreferences? prefs = await _instance;
    return prefs.setString(key, value);
  }

  static Future<void> clearAllData() async {
    _prefsInstance!.remove(PrefsConstantUtil.token);
  }
}
