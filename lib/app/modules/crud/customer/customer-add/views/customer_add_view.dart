import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/ui/components/inputs/user_input_style_2.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/response/customer/customer_group.dart';
import 'package:posdelivery/models/response/customer/price_group.dart';

import '../../../../../ui/components/buttons/custom_elevated_button.dart';
import '../controllers/customer_add_controller.dart';

class CustomerAddView extends GetView<CustomerAddController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: Text('add_customer'.tr),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(Constants.pagePadding10),
          child: Column(
            children: [
              Obx(
                () {
                  return Form(
                    key: controller.addFromKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: DropdownButtonFormField<CustomerGroups>(
                            decoration: InputDecoration(
                              //filled: true,
                              //fillColor: Colors.red,
                              border: OutlineInputBorder(),
                              labelText: 'customer_group'.tr,
                            ),
                            isExpanded: true,
                            value: controller.cCustomerGroup.value,
                            items: (controller
                                        .customerPriceGroup.value.customerGroups
                                        ?.map(buildCustomerGroup) ??
                                    [])
                                .toList(),
                            onChanged: (CustomerGroups? value) {
                              controller.onChangeCustomerGroup(value!);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: DropdownButtonFormField<PriceGroups>(
                            decoration: InputDecoration(
                              //filled: true,
                              //fillColor: Colors.red,
                              labelText: 'price_group'.tr,
                              border: OutlineInputBorder(),
                            ),
                            isExpanded: true,
                            value: controller.cPriceGroup.value,
                            items: (controller
                                        .customerPriceGroup.value.priceGroups
                                        ?.map(buildPriceGroupItem) ??
                                    [])
                                .toList(),
                            onChanged: (PriceGroups? value) {
                              controller.onChangePriceGroup(value!);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        UserInputStyle2(
                          inputCtl: controller.companyInput,
                          onFieldSubmitted: (String value) {
                            controller.nextFocus(controller.vatFocus, context);
                          },
                          focusNode: controller.companyFocus,
                          keyboardType: TextInputType.text,
                          labelKey: 'company'.tr,
                          textInputAction: TextInputAction.next,
                          secondColor: AppColors.primary,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please_enter_some_value'.tr;
                            }
                            return null;
                          },
                        ),
                        UserInputStyle2(
                          inputCtl: controller.vatNoInput,
                          onFieldSubmitted: (String value) {
                            controller.nextFocus(controller.nameFocus, context);
                          },
                          focusNode: controller.vatFocus,
                          keyboardType: TextInputType.number,
                          labelKey: 'vat_no'.tr,
                          textInputAction: TextInputAction.next,
                          secondColor: AppColors.primary,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please_enter_some_value'.tr;
                            }
                            return null;
                          },
                        ),
                        UserInputStyle2(
                          inputCtl: controller.nameInput,
                          onFieldSubmitted: (String value) {
                            controller.nextFocus(
                                controller.phoneFocus, context);
                          },
                          focusNode: controller.nameFocus,
                          keyboardType: TextInputType.text,
                          labelKey: 'name'.tr,
                          textInputAction: TextInputAction.next,
                          secondColor: AppColors.primary,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please_enter_some_value'.tr;
                            }
                            return null;
                          },
                        ),
                        UserInputStyle2(
                          inputCtl: controller.phoneNumberInput,
                          onFieldSubmitted: (String value) {
                            controller.nextFocus(
                                controller.emailFocus, context);
                          },
                          focusNode: controller.phoneFocus,
                          keyboardType: TextInputType.number,
                          labelKey: 'phone_no'.tr,
                          textInputAction: TextInputAction.next,
                          secondColor: AppColors.primary,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please_enter_phone_no'.tr;
                            }
                            return null;
                          },
                        ),
                        UserInputStyle2(
                          inputCtl: controller.emailInput,
                          onFieldSubmitted: (String value) {
                            controller.nextFocus(
                                controller.addressFocus, context);
                          },
                          focusNode: controller.emailFocus,
                          keyboardType: TextInputType.emailAddress,
                          labelKey: 'email_id'.tr,
                          textInputAction: TextInputAction.next,
                          secondColor: AppColors.primary,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please_enter_email_id'.tr;
                            }
                            return null;
                          },
                        ),
                        UserInputStyle2(
                          inputCtl: controller.addressInput,
                          onFieldSubmitted: (String value) {
                            controller.nextFocus(controller.cityFocus, context);
                          },
                          focusNode: controller.addressFocus,
                          keyboardType: TextInputType.text,
                          labelKey: 'address'.tr,
                          textInputAction: TextInputAction.next,
                          secondColor: AppColors.primary,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please_enter_address'.tr;
                            }
                            return null;
                          },
                        ),
                        UserInputStyle2(
                          inputCtl: controller.cityInput,
                          onFieldSubmitted: (String value) {
                            controller.nextFocus(
                                controller.stateFocus, context);
                          },
                          focusNode: controller.cityFocus,
                          keyboardType: TextInputType.text,
                          labelKey: 'city'.tr,
                          textInputAction: TextInputAction.next,
                          secondColor: AppColors.primary,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please_enter_city'.tr;
                            }
                            return null;
                          },
                        ),
                        UserInputStyle2(
                          inputCtl: controller.stateInput,
                          onFieldSubmitted: (String value) {
                            controller.nextFocus(
                                controller.countryFocus, context);
                          },
                          focusNode: controller.stateFocus,
                          keyboardType: TextInputType.text,
                          labelKey: 'state'.tr,
                          textInputAction: TextInputAction.next,
                          secondColor: AppColors.primary,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please_enter_state'.tr;
                            }
                            return null;
                          },
                        ),
                        UserInputStyle2(
                          inputCtl: controller.postalCodeInput,
                          onFieldSubmitted: (String value) {
                            controller.nextFocus(
                                controller.countryFocus, context);
                          },
                          focusNode: controller.postalCodeFocus,
                          keyboardType: TextInputType.number,
                          labelKey: 'postal_code'.tr,
                          textInputAction: TextInputAction.next,
                          secondColor: AppColors.primary,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please_enter_postal_code'.tr;
                            }
                            return null;
                          },
                        ),
                        UserInputStyle2(
                          inputCtl: controller.countryInput,
                          onFieldSubmitted: (String value) {
                            controller.actionOnSaveRequest();
                          },
                          focusNode: controller.countryFocus,
                          keyboardType: TextInputType.text,
                          labelKey: 'country'.tr,
                          textInputAction: TextInputAction.next,
                          secondColor: AppColors.primary,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please_enter_country'.tr;
                            }
                            return null;
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: CElevatedButton(
                                  label: 'save'.tr,
                                  bgColor: AppColors.primary,
                                  onPress: controller.actionOnSaveRequest,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<CustomerGroups> buildCustomerGroup(CustomerGroups item) =>
      DropdownMenuItem(
        value: item,
        child: Text(
          item.name.toString().toUpperCase(),
        ),
      );

  DropdownMenuItem<PriceGroups> buildPriceGroupItem(PriceGroups item) =>
      DropdownMenuItem(
        value: item,
        child: Text(
          item.name.toString().toUpperCase(),
        ),
      );
}
