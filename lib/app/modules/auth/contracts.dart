import 'package:posdelivery/models/response/auth/check_otp_respose.dart';
import 'package:posdelivery/models/response/auth/licence_validation_response.dart';
import 'package:posdelivery/models/response/auth/login_response.dart';
import 'package:posdelivery/models/response/auth/open_register_response.dart';
import 'package:posdelivery/models/response/error_message.dart';

abstract class ILoginController {
  void onLoginDone(LoginResponse loginResponse);
  void onLoginError();
}

abstract class IOtpVerificationController {
  void onVerificationDone(CheckOtpResponse otpResponse);
  void onVerificationError();
}

abstract class ILicenceScreenController {
  void onLicenceVerificationDone(LicenceValidationResponse lvR);
  void onLicenceVerificationError(ErrorMessage errMsg);
}

abstract class IOpenRegisterController {
  void onOpenRegisterDone(OpenRegisterResponse openRegisterResponse);
  void onOpenRegisterError(ErrorMessage errorMessage);
}
