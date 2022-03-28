import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:posdelivery/app/modules/my-account/contracts.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/constants.dart';

class MyAccountController extends BaseGetXController implements IMyAccountPage {
  DateTime filterDate = DateTime.now();
  DateTime cChangeDate = DateTime.now();
  RxString cDateString = RxString(DateFormat(Constants.defaultMonthFormat).format(DateTime.now()));
  void updateSearchDate() {
    Get.back();
    filterDate = cChangeDate;
    cDateString.value = DateFormat(Constants.defaultMonthFormat).format(filterDate);
  }

  void cancelDateChange() {
    Get.back();
  }
}
