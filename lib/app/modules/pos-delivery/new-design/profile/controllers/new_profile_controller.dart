
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/profile/contracts.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/response/auth/my_info_response.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/providers/data/delivery_data_provider.dart';

import 'package:posdelivery/models/response/auth/my_info_response.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
class NewProfileScreenController extends BaseGetXController
    implements INewProfileScreenController {
  DeliveryDataProvider deliveryDataProvider = Get.find<DeliveryDataProvider>();
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString number = ''.obs;
  @override
  void onInit() {
    deliveryDataProvider.newProfileCallBack = this;
    super.onInit();
  }
 @override
  void onReady() {
    deliveryDataProvider.getProfileInfo();
    UINotification.showLoading();
    super.onReady();
  }
  @override
  onMyInfoResponseDone(MyInfoResponse myInfoResponse) {
    name.value= '${myInfoResponse.firstName} ${myInfoResponse.lastName}';
    email.value= myInfoResponse.email??'';
    number.value= myInfoResponse.phone??'';
    UINotification.hideLoading();

  }

  @override
  onMyInfoResponseError(ErrorMessage errorMessage) {
    UINotification.hideLoading();
  }

}
