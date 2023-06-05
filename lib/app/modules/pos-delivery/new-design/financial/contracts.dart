import 'package:posdelivery/models/response/auth/current_register_response.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/auth/register_close_summary.dart';
abstract class INewFinancialScreenController {

  // onCurrentRegisterResponseDone( CurrentRegisterResponse currentRegisterResponse);

  // onCurrentRegisterNotOpen(ErrorMessage errorMessage);

  onRegisterCloseSummaryDone(RegisterCloseSummary rSummary);
onRegisterCloseSummaryError(ErrorMessage errorMessage);
}

