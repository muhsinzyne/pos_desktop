import 'dart:convert';

import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:posdelivery/app/modules/auth/contracts.dart';
import 'package:posdelivery/app/modules/contracts.dart';
import 'package:posdelivery/app/modules/dashboard/contracts.dart';
import 'package:posdelivery/app/modules/splash/contracts.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/models/requests/auth/login_request.dart';
import 'package:posdelivery/models/requests/auth/validate_licence.dart';
import 'package:posdelivery/models/response/auth/licence_validation_response.dart';
import 'package:posdelivery/models/response/auth/login_response.dart';
import 'package:posdelivery/models/response/auth/my_info_response.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/status_codes.dart';
import 'package:posdelivery/models/url.dart';
import 'package:posdelivery/providers/data/base_data_provider.dart';
import 'package:logger/logger.dart';

class AuthDataProvider extends BaseDataProvider {
  final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ));
  late ILoginController loginCtrl;
  late IOtpVerificationController otpVerCtrl;
  late ISplashScreenController homeCtrl;
  late IDashboardScreenController dashCtrl;
  late IBaseGetXController bCtrl;
  late ILicenceScreenController lCtrl;

  set callBack(IBaseGetXController controller) {
    bCtrl = controller;
  }

  /// page call back seters
  set licenceValidationCallback(ILicenceScreenController controller) {
    lCtrl = controller;
  }

  set otpVerificationCallback(IOtpVerificationController controller) {
    otpVerCtrl = controller;
  }

  set loginCallBack(ILoginController controller) {
    loginCtrl = controller;
  }

  set homeCallBack(ISplashScreenController controller) {
    homeCtrl = controller;
  }

  set dashboardCallback(IDashboardScreenController controller) {
    dashCtrl = controller;
  }

  // validation for splash

  // // validation for splash
  // getEmpInfo() {
  //   final obs = network.get(NetworkURL.getEmpInfo).asStream();
  //   obs.listen(
  //     (data) {
  //       try {
  //         EmployeeInfo employeeInfo = EmployeeInfo.fromJSON(data.data);
  //         bCtrl.onLoadTokenValid(employeeInfo);
  //       } on Exception {
  //         bCtrl.onLoadTokenInvalid();
  //       }
  //     },
  //     onError: (err) {
  //       if (err.response?.statusCode == StatusCodes.status401Unauthorized) {
  //         bCtrl.onLoadTokenInvalid();
  //       }
  //     },
  //   );
  // }

  getProfileInfo() {
    final obs = network.get(NetworkURL.myInfo).asStream();
    obs.listen(
      (data) {
        UINotification.hideLoading();
        try {
          MyInfoResponse myInfo = MyInfoResponse.fromJSON(data.data);
          bCtrl.onTokenValid(myInfo);
        } on Exception catch (e) {
          bCtrl.onLoadTokenInvalid();
        }
      },
      onError: (err) {
        UINotification.hideLoading();
        if (err.response?.statusCode == StatusCodes.status401Unauthorized) {
          bCtrl.onLoadTokenInvalid();
        }
      },
    );
  }

  /// login call
  login(LoginRequest loginRequest) {
    logger.w(NetworkURL.login);
    final obs =
        network.post(NetworkURL.login, data: loginRequest.toJson()).asStream();
    obs.listen(
      (data) {
        try {
          logger.w("any");
          LoginResponse loginResponse = LoginResponse.fromJSON(data.data);
          if (loginResponse.data?.token != null) {
            logger.w("works");
            loginCtrl.onLoginDone(loginResponse);
          } else {
            logger.e("error");
            // token null exception
            loginCtrl.onLoginError();
          }
        } on Exception {
          logger.e("exception");
          loginCtrl.onLoginError();
        }
      },
      onError: (err) {
        logger.e("exception");
        loginCtrl.onLoginError();
        if (err.response?.statusCode == StatusCodes.status400BadRequest) {
          loginCtrl.onLoginError();
        }
        if (err.response?.statusCode == StatusCodes.status401Unauthorized) {
          loginCtrl.onLoginError();
        }
      },
    );
  }

  validateLicence(ValidateLicenceRequest validateLicenceRequest) {
    final obs = network
        .post(NetworkURL.validateLicence, data: validateLicenceRequest.toJson())
        .asStream();
    obs.listen((data) {
      try {
        LicenceValidationResponse lvR =
            LicenceValidationResponse.fromJSON(data.data);
        lCtrl.onLicenceVerificationDone(lvR);
      } on Exception {
        final ErrorMessage errMsg = ErrorMessage();
        errMsg.message = 'licence_could_not_be_verified'.tr;
        lCtrl.onLicenceVerificationError(errMsg);
      }
    }, onError: (err) {
      final ErrorMessage errMsg =
          ErrorMessage.fromJSON(jsonDecode(err.response.toString()));
      if (err.response?.statusCode == StatusCodes.status400BadRequest) {
        lCtrl.onLicenceVerificationError(errMsg);
      }
    });
  }
}
