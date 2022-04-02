import 'dart:convert';

import 'package:get/get.dart';
import 'package:posdelivery/app/config/flavor/flavor_service.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/services/base/get_x_service.dart';
// import 'package:posdelivery/services/file/file_storage_service.dart';
import 'package:posdelivery/services/storage/local_storage_service.dart';

class CacheService extends BaseGetXService {
  @override
  Future dependencies() async {}

  final CacheAdaptor cacheAdaptor;

  LocalStorage localStorage = Get.find<LocalStorage>();
  // FileStorage fileStorage = Get.find<FileStorage>();

  CacheService({this.cacheAdaptor = CacheAdaptor.localStorage}) {
    if (cacheAdaptor == CacheAdaptor.localStorage) {}
  }

  LocalStorage get adaptor {
    if (cacheAdaptor == CacheAdaptor.localStorage) {
      return localStorage;
    } else if (cacheAdaptor == CacheAdaptor.file) {}
    return localStorage;
  }

  dynamic setData(String key, dynamic data) {
    var jsonString = jsonEncode(data);
    localStorage.setString(key, jsonString);
    return jsonDecode(localStorage.getString(key)!);
  }

  dynamic getData(String key) {
    var jsonString = localStorage.getString(key);
    return jsonDecode(jsonString!);
  }

  dynamic appendData(String key, dynamic item) {
    var existingData = getData(key);
    if (existingData.runtimeType == List) {
      existingData.add(item);
      return setData(key, existingData);
    } else {
      return null;
    }
  }

  dynamic resetData(String key) {
    localStorage.setString(key, Constants.none);
    return Constants.none;
  }

  dynamic modifyOneFromListById(String key, dynamic update, {dynamic id}) {
    var jsonString = localStorage.getString(key);
    List<dynamic> jsonData = jsonDecode(jsonString!);
    var position = jsonData.indexWhere((element) => element.id == id);
    jsonData[position] = update;
    return setData(key, jsonData);
  }
}
