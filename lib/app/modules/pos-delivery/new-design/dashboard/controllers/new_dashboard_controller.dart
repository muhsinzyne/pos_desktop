import 'dart:io';
import 'package:posdelivery/models/response/auth/close_register_response.dart';
import 'package:posdelivery/models/response/auth/register_close_summary.dart';
import 'package:posdelivery/models/requests/auth/register_close_summary_request.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/text_field.dart';

import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/app/modules/pos-delivery/add-store-manually/contracts.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/dashboard/contracts.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/delivery/requests/store_add_request.dart';
import 'package:posdelivery/models/response/auth/current_register_response.dart';
import 'package:posdelivery/models/response/auth/open_register_response.dart';
import 'package:posdelivery/models/response/auth/register_close_summary.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/delivery/response/store_add_response.dart';
import 'package:posdelivery/providers/data/delivery_data_provider.dart';
import 'package:posdelivery/services/cache/cache_sembast_delivery_service.dart';
import 'package:posdelivery/services/cache/cache_service.dart';
import 'package:posdelivery/services/location_service.dart';
import 'dart:async';
import 'package:posdelivery/models/requests/auth/close_register_request.dart';

import 'package:posdelivery/models/requests/auth/open_register_request.dart';
import 'package:posdelivery/models/requests/auth/register_close_summary_request.dart';
class NewDashboardScreenController extends BaseGetXController
    implements INewDashboardScreenController {
  final TextEditingController openingBalanceInput =  TextEditingController();
RxBool isRegisterOpen = false.obs;
String registerId= '';
  DeliveryDataProvider deliveryDataProvider = Get.find<DeliveryDataProvider>();
  OpenRegisterRequest openRegisterRequest = OpenRegisterRequest();
  RegisterCloseSummaryRequest registerCloseSummaryRequest = RegisterCloseSummaryRequest();
  @override
  void onInit(){
    deliveryDataProvider.newDashboardCallBack = this;
    super.onInit();
  }
  @override
  void onReady()  {
    deliveryDataProvider.myRegisterSummary();
    super.onReady();
  }
  @override
  void onClose() {
    openingBalanceInput.dispose();
    super.onClose();
  }

  actionOnCloseRegisterClick(){
    UINotification.showLoading();
    registerCloseSummaryRequest.registerId = registerId;
    deliveryDataProvider.registerCloseSummary(registerCloseSummaryRequest);

  }
  actionOnStoreClick(){
    if(isRegisterOpen.value){
      Get.toNamed(Routes.newStore);
    }else{
          Get.defaultDialog(
            contentPadding: EdgeInsets.all(10),
            title: "Open Register",
            confirm:  ElevatedButton(
              onPressed:openRegister,
              child: Text('Submit'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.deliveryPrimary80,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
              ),
            ),
                content:Padding(
                  padding: const EdgeInsets.symmetric(horizontal:10,vertical:20),
                  child: TextFieldDelivery(
            controller: openingBalanceInput,
            hint: "Opening Balance",
          ),
                ),
          );}
  }
 openRegister(){
    Get.back();
    UINotification.showLoading();
    openRegisterRequest.cashInHand = openingBalanceInput.text;
    deliveryDataProvider.openRegister(openRegisterRequest);
}
closeRegisterDialogue(RegisterCloseSummary response){

  Get.defaultDialog(
    contentPadding:
    EdgeInsets.all(10),
    title: "Close Register",
    confirm: ElevatedButton(
      onPressed:()=> closeRegister(response),
      child: Text('Submit'),
      style: ElevatedButton
          .styleFrom(
        backgroundColor: AppColors
            .deliveryPrimary80,
        shape:
        RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(
              12), // <-- Radius
        ),
      ),
    ),
    content: Padding(
      padding: const EdgeInsets
          .symmetric(
          horizontal: 10,
          vertical: 20),
      child: Column(children: [
        Column(
          children: [
            Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "Cash in Hand"),
                  Text(response.cashInHand!)
                ]),
            Divider(),
            SizedBox(
              height: 5,
            ),
          ],
        ),
        Column(
          children: [
            Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "Cash Payments"),
                  Text(response.cashSales?.total ??'0')
                ]),
            Divider(),
            SizedBox(
              height: 5,
            ),
          ],
        ),

        Column(
          children: [
            Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "Total Sales"),
                  Text(response.saleCount.toString())
                ]),
            Divider(),
            SizedBox(
              height: 5,
            ),
          ],
        ),
        Column(
          children: [
            Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "Refunds"),
                  Text(response.refunds?.total??'0')
                ]),
            Divider(),
            SizedBox(
              height: 5,
            ),
          ],
        ),
        Column(
          children: [
            Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "Returns"),
                  Text(response.returns?.total??'0')
                ]),
            Divider(),
            SizedBox(
              height: 5,
            ),
          ],
        ),
        Column(
          children: [
            Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "Expenses"),
                  Text(response.expenses?.total??'0')
                ]),
            Divider(),
            SizedBox(
              height: 5,
            ),
          ],
        ),
        Column(
          children: [
            Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "Total Expenses",style:TextStyle(fontWeight:FontWeight.w600)),
                  Text(response.totalSales?.total??'0',style:TextStyle(fontWeight:FontWeight.w600))
                ]),
            Divider(),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ]),
    ),
  );
}
closeRegister(RegisterCloseSummary response){
  UINotification.showLoading();
  CloseRegisterRequest closeRegisterRequest = CloseRegisterRequest();
  closeRegisterRequest.registerid = int.parse(registerId);
  closeRegisterRequest.closeregister ='';
  closeRegisterRequest.note='';
  closeRegisterRequest.totalcash='0';
  closeRegisterRequest.totalcashsubmitted='0';
  closeRegisterRequest.totalccslips='0';
  closeRegisterRequest.totalccslipssubmitted='0';
  closeRegisterRequest.totalcheques='0';
  closeRegisterRequest.totalchequessubmitted='0';
  deliveryDataProvider.closeRegister(closeRegisterRequest);
}
  @override
  onOpenRegisterDone(OpenRegisterResponse openRegisterResponse) {
    deliveryDataProvider.myRegisterSummary();
    UINotification.hideLoading();
    Get.toNamed(Routes.newStore);
  }

  @override
  onOpenRegisterError(ErrorMessage err) {
    UINotification.hideLoading();
    Logger().w(err.toJson());
  }

  @override
  onCurrentRegisterNotOpen(ErrorMessage errorMessage) {
    isRegisterOpen.value = false;
    Logger().e(errorMessage.toJson());
  }

  @override
  onCurrentRegisterResponseDone(CurrentRegisterResponse currentRegisterResponse) {
    UINotification.hideLoading();

    registerId=currentRegisterResponse.id!;
    isRegisterOpen.value = true;
  }

  @override
  onRegisterCloseSummaryDone(RegisterCloseSummary rSummary) {
    UINotification.hideLoading();
    Logger().w(rSummary.toJson());
    closeRegisterDialogue(rSummary);
  }

  @override
  onRegisterCloseSummaryError(ErrorMessage errorMessage) {
    // TODO: implement onRegisterCloseSummaryError
    throw UnimplementedError();
  }

  @override
  onCloseRegisterDone(CloseRegisterResponse closeRegisterResponse) {
    isRegisterOpen.value= false;
    registerId = '';
    UINotification.hideLoading();
    Get.back();
    Logger().w('closed');
  }

  @override
  onCloseRegisterError(ErrorMessage errorMessage) {
    // TODO: implement onCloseRegisterError
    Logger().e(errorMessage.message);
  }


}