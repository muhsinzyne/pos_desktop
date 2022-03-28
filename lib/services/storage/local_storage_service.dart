import 'package:get/get.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage extends GetxService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences prefs;
  @override
  void onInit() {
    _dependencies();
    super.onInit();
  }

  void _dependencies() async {
    final SharedPreferences pr = await _prefs;
    prefs = pr;
  }

  dynamic get(String key) async {
    try {
      return prefs.get(key);
    } on Exception catch (_) {
      return null;
    }
  }

  Future<bool> setBool(String key, bool value) {
    return prefs.setBool(key, value);
  }

  Future<bool> setString(String key, String value) {
    return prefs.setString(key, value);
  }

  bool? getBool(String key) {
    try {
      return prefs.getBool(key);
    } on Exception catch (_) {
      return false;
    }
  }

  double? getDouble(String key) {
    try {
      return prefs.getDouble(key);
    } on Exception catch (_) {
      return 0.0;
    }
  }

  int? getInt(String key) {
    try {
      return prefs.getInt(key);
    } on Exception catch (_) {
      return null;
    }
  }

  String? getString(String key) {
    try {
      return prefs.getString(key);
    } on Exception catch (_) {
      return null;
    }
  }

  dynamic setData(String key) {}

  bool get isLastLoggedIn {
    bool? value = prefs.getBool(Constants.isLastLoggedIn);
    return value ?? false;
  }

  bool get isAuthToken {
    String? token = getString(Constants.authToken);
    if (token == null ||
        token == Constants.none ||
        token == Constants.stringNull) {
      return false;
    }
    return true;
  }

  bool get isAppServer {
    //prefs?.setString(Constants.appServer, Constants.none);
    String? appServer = getString(Constants.appServer);
    if (appServer == null ||
        appServer == Constants.none ||
        appServer == Constants.stringNull) {
      return false;
    } else {
      return true;
    }
  }
}
