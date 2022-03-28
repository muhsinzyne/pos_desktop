import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

typedef RetryEvaluator = FutureOr<bool> Function(DioError error, int attempt);

class OnConnectionChangeRetry extends Interceptor {
  final Dio dio;
  final Function(String message) logPrint;

  Connectivity connectivity = Connectivity();
  StreamSubscription? streamSubscription;
  OnConnectionChangeRetry({required this.dio, required this.logPrint});

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    logPrint.call(
      '[${err.requestOptions.uri}] An error occurred during request, \n'
      '${err.message}',
    );

    if (_shouldRetry(err)) {
      /// if a valid retry scenarios from error object
      /// listen for a connectivity change object
      logPrint.call(
        '==========================='
        'Waiting for a network change'
        '===========================',
      );
      streamSubscription =
          connectivity.onConnectivityChanged.listen((connectivityResult) {
        if (connectivityResult != ConnectivityResult.none) {
          logPrint.call(
            '==========================='
            'Detected a network change'
            '===========================',
          );

          /// if connectivity has updated back to wifi or mobile  the network change listener stop and make a same dio request
          streamSubscription!.cancel();
          try {
            dio
                .fetch<void>(err.requestOptions)
                .then((value) => handler.resolve(value));
          } on Exception {
            super.onError(err, handler);
          }
        } else {
          /// returning some error back to the base interceptor
          super.onError(err, handler);
        }
      });
    } else {
      /// return back old errors if the _shouldRetry become invalid
      super.onError(err, handler);
    }
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.other &&
        err.error != null &&
        err.error is SocketException;
  }
}
