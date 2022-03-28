import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/crud/contracts.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/requests/customer/customer_add_request.dart';
import 'package:posdelivery/models/response/customer/customer_add_response.dart';
import 'package:posdelivery/models/response/customer/customer_group.dart';
import 'package:posdelivery/models/response/customer/customer_price_group_response.dart';
import 'package:posdelivery/models/response/customer/price_group.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/providers/data/pos_data_provider.dart';

class CustomerAddController extends BaseGetXController
    implements ICustomerAddController {
  PosDataProvider posDataProvider = Get.find<PosDataProvider>();

  final addFromKey = GlobalKey<FormState>();
  final FocusNode companyFocus = FocusNode();
  final FocusNode nameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();
  final FocusNode stateFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode vatFocus = FocusNode();
  final FocusNode postalCodeFocus = FocusNode();
  final FocusNode countryFocus = FocusNode();

  TextEditingController companyInput = TextEditingController();
  TextEditingController nameInput = TextEditingController();
  TextEditingController phoneNumberInput = TextEditingController();
  TextEditingController addressInput = TextEditingController();
  TextEditingController cityInput = TextEditingController();
  TextEditingController stateInput = TextEditingController();
  TextEditingController emailInput = TextEditingController();
  TextEditingController vatNoInput = TextEditingController();
  TextEditingController postalCodeInput = TextEditingController();
  TextEditingController countryInput = TextEditingController();

  var customerPriceGroup = CustomerPriceGroupsResponse().obs;
  var cCustomerGroup = CustomerGroups().obs;
  var cPriceGroup = PriceGroups().obs;

  @override
  void onInit() {
    posDataProvider.customerAddCtrlBack = this;
    super.onInit();
  }

  @override
  void onReady() {
    posDataProvider.getCustomerGroupAndPriceGroup();
    UINotification.showLoading();
    super.onReady();
  }

  onChangeCustomerGroup(CustomerGroups value) {
    cCustomerGroup.value = value;
  }

  onChangePriceGroup(PriceGroups value) {
    cPriceGroup.value = value;
  }

  onChangeCompany() {}

  @override
  actionOnSaveRequest() {
    if (addFromKey.currentState!.validate()) {
      UINotification.showLoading();
      CustomerAddRequest addRequest = CustomerAddRequest();
      addRequest.name = nameInput.text;
      addRequest.email = emailInput.text;
      addRequest.customerGroup = cCustomerGroup.value.id;
      addRequest.priceGroup = cPriceGroup.value.id;
      addRequest.company = companyInput.text;
      addRequest.address = addressInput.text;
      addRequest.vatNo = vatNoInput.text;
      addRequest.city = cityInput.text;
      addRequest.state = stateInput.text;
      addRequest.postalCode = postalCodeInput.text;
      addRequest.country = countryInput.text;
      addRequest.phone = phoneNumberInput.text;
      posDataProvider.customerAddRequest(addRequest);
    } else {
      UINotification.showNotification(
          color: Colors.red, title: 'please_complete_form'.tr);
    }
  }

  @override
  customerGroupFetchDone(CustomerPriceGroupsResponse response) {
    UINotification.hideLoading();
    customerPriceGroup.value = response;
    cCustomerGroup.value = customerPriceGroup.value.customerGroups!.first;
    cPriceGroup.value = customerPriceGroup.value.priceGroups!.first;
  }

  @override
  onCustomerGroupFetchError(ErrorMessage err) {}

  @override
  onCustomerAddDone(CustomerAddResponse customerAddResponse) {
    UINotification.hideLoading();
    UINotification.showNotification(
      color: AppColors.greenIconColor,
      title: customerAddResponse.message,
    );
    Get.back(canPop: true);
  }

  @override
  onCustomerAddError(ErrorMessage err) {
    UINotification.showNotification(color: Colors.red, title: err.message);
  }
}
