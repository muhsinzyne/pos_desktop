import 'package:posdelivery/models/response/customer/customer_add_response.dart';
import 'package:posdelivery/models/response/desktop/customer_list.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/pos/product.dart';
import 'package:posdelivery/models/response/auth/my_info_response.dart';
abstract class INewProfileScreenController {
onMyInfoResponseDone(MyInfoResponse myInfoResponse);
onMyInfoResponseError(ErrorMessage errorMessage);
}
