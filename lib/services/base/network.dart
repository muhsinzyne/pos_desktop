import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:posdelivery/app/config/flavor/flavor_service.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/services/app_service.dart';
import 'package:posdelivery/services/base/get_x_service.dart';
import 'package:posdelivery/services/network/interceptors/dio_load_headers.dart';
import 'package:posdelivery/services/network/interceptors/on_connection_change_retry.dart';
import 'package:posdelivery/services/network/interceptors/on_error_handler.dart';
import 'package:posdelivery/services/network/interceptors/retry_interceptor.dart';

class DioNetwork extends BaseGetXService {
  static const Map<String, dynamic> emptyRequest = {};

  Dio dio = Dio();
  AppService appService = getx.Get.find<AppService>();
  setDio() {
    BaseOptions options = BaseOptions(
      baseUrl: FlavorConfig.instance.flavorValues.api,
      connectTimeout: Constants.apiConnectionTimeOut,
      receiveTimeout: Constants.apiReceiveTimeOut,
    );
    dio = Dio(options);
    dio.interceptors.add(
      DioLoadHeaders(),
    );
    dio.interceptors.add(
      OnErrorHandler(
        dio: dio,
      ),
    );
    dio.interceptors.add(
      OnConnectionChangeRetry(
        dio: dio,
        logPrint: AppFlavors.getLogLevel(),
      ),
    );

    dio.interceptors.add(RetryInterceptor(
      dio: dio,
      retryDelays: [
        Duration(seconds: 1),
        Duration(seconds: 2),
        Duration(seconds: 3),
      ],
      retries: Constants.retryRequestCount,
      logPrint: print,
    ));
  }

  Future<Response> get(String url, {Map<String, dynamic>? queryParameters}) {
    queryParameters ??= emptyRequest;
    return dio.get(url, queryParameters: queryParameters);
  }

  Future<Response> post(String url,
      {Map<String, dynamic>? data, Map<String, dynamic>? queryParameters}) {
    data ??= emptyRequest;
    queryParameters ??= emptyRequest;
    return dio.post(url, data: data, queryParameters: queryParameters);
  }

  Future<Response> upload(String url,
      {dynamic? data, Map<String, dynamic>? queryParameters}) {
    data ??= emptyRequest;
    queryParameters ??= emptyRequest;
    return dio.post(url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ));
  }

  Future<Response> put(String url,
      {Map<String, dynamic>? data, Map<String, dynamic>? queryParameters}) {
    data ??= emptyRequest;
    queryParameters ??= emptyRequest;
    return dio.put(url, data: data, queryParameters: queryParameters);
  }

  Future<Response> patch(String url,
      {Map<String, dynamic>? data, Map<String, dynamic>? queryParameters}) {
    data ??= emptyRequest;
    queryParameters ??= emptyRequest;
    return dio.patch(url, data: data, queryParameters: queryParameters);
  }

  @override
  Future dependencies() async {
    setDio();
  }
}
