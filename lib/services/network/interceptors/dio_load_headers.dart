import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/services/app_service.dart';

class DioLoadHeaders extends Interceptor {
  AppService? appService;

  DioLoadHeaders() {
    appService = Get.find<AppService>();
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print(options.path);
    if (!options.headers.containsKey(Constants.authorization)) {
      options.headers = {
        Constants.authorization: "${Constants.bearer} ${appService!.authToken}",
      };
      print(options.headers);
    } else {}
    return handler.next(options);
  }
}
