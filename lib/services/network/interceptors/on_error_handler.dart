import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/status_codes.dart';
import 'package:posdelivery/services/storage/local_storage_service.dart';

class OnErrorHandler extends Interceptor {
  LocalStorage localStorage = getx.Get.find<LocalStorage>();
  String statusMessage = '';
  int statusCode = StatusCodes.status404NotFound;
  final Dio dio;

  OnErrorHandler({required this.dio});
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    UINotification.hideLoading();
    if (err.type == DioErrorType.other) {
      String uriString = err.requestOptions.uri.toString();
      if (uriString.isNotEmpty && uriString[0] == Constants.forwardSlash) {
        var baseUrl = localStorage.getString(Constants.appServer);
        await Future.delayed(Constants.oneSecDuration);
        try {
          dio
              .fetch<void>(
            err.requestOptions.copyWith(
              baseUrl: baseUrl,
            ),
          )
              .then((value) {
            print(value);
            handler.resolve(value);
          });
        } on Exception {
          print("still the error");
          super.onError(err, handler);
        }
      }
    } else {
      if (err.type == DioErrorType.response) {
        statusCode = err.response!.statusCode!;
        statusMessage = err.response!.statusMessage!;

        switch (statusCode) {
          case StatusCodes.status401Unauthorized:
            //UINotification.showNotification(title: 'error_401'.tr);
            super.onError(err, handler);
            break;
          case StatusCodes.status404NotFound:
            //UINotification.showNotification(title: 'error_404'.tr);
            super.onError(err, handler);
            break;
          case StatusCodes.status400BadRequest:
            super.onError(err, handler);
            break;

          case StatusCodes.status500InternalServerError:
            break;

          default:
            super.onError(err, handler);
            break;
        }
      } else {
        super.onError(err, handler);
      }
    }
  }
}
