import 'package:shared_preferences/shared_preferences.dart';

import '../constants/storage_keys.dart';

class StorageService {
  StorageService._();

  static final StorageService instance = StorageService._();
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  bool isOnboardingCompleted() {
    return _prefs?.getBool(StorageKeys.onboardingCompleted) ?? false;
  }

  Future<bool> setOnboardingCompleted(bool completed) async {
    _prefs ??= await SharedPreferences.getInstance();
    return await _prefs?.setBool(StorageKeys.onboardingCompleted, completed) ?? false;
  }
}
