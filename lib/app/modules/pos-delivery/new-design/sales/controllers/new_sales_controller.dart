import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/app/modules/pos-delivery/new-design/sales/contracts.dart';
import 'package:posdelivery/app/ui/components/ui_notification.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/constants.dart';
import 'package:posdelivery/models/response/error_message.dart';
import 'package:posdelivery/models/response/pos/product.dart';
import 'package:posdelivery/models/requests/pos/product_list.dart';
import 'package:posdelivery/providers/data/delivery_data_provider.dart';
import 'package:posdelivery/models/delivery/requests/cart_product.dart';
import 'package:posdelivery/app/ui/components/pos-delivery/sale_item.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'dart:convert' show utf8;
class NewSalesScreenController extends BaseGetXController
    implements INewSalesScreenController {
  DeliveryDataProvider deliveryDataProvider = Get.find<DeliveryDataProvider>();
  //textcontroller
  final TextEditingController searchCtrl = TextEditingController();
  final logger = Logger();
  RxList<Product> productListTemp = RxList([]);
  RxList<Product> filteredProducts = RxList([]);
  RxList<CartProduct> addedProducts = RxList([]);
  ProductListRequest productListRequest = ProductListRequest();

  void init() async {
    productListRequest.limit = 100;
    productListRequest.page = 1;
    productListRequest.warehouse_id = 1;
    deliveryDataProvider.getProductsSales(productListRequest);
  }
addProductViaScan(String code){
  // List<int>  chr = utf8.encode(code);
  Logger().w(code);
  //   Logger().w('6254000115019'==code);
Product? product= productListTemp.firstWhereOrNull((element) => element.row!.code! == code);
if(product !=null)
  {
    var isAdded = addedProducts
        .firstWhereOrNull((element) => element.cartItem!.id == product.id);
    if(isAdded ==null){
  RxInt qty =1.obs;
    Get.defaultDialog(
      confirm:  ElevatedButton(
        onPressed:(){
          CartProduct temp = CartProduct();
          temp.cartItem = product;
          temp.itemId = product.id;
          temp.quantity = qty.value;
          temp.subTotal = (double.parse(product.row!.price.toString())) *qty.value;
          temp.grandTotal = temp.subTotal!;
          addedProducts.add(temp);
          Get.back();
        },
        // onPressed: Get.back,
        child: Text('Add'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.deliveryPrimary80,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
        ),
      ),
    content: Container(
      margin: EdgeInsets.only(bottom: 20),
      width: double.maxFinite,
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xffEBEBEB)),
        color: AppColors.newBg,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            flex: 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Flexible(
                        // flex: 2,
                        child: Text(
                          product.label.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Flexible(
                  // flex: 2,
                    child: Text(
                      product.row!.price.toString(),
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Flexible(
                  // flex: 3,
                  child: Row(
                    children: [
                      Container(
                        // width: 85,
                        decoration: BoxDecoration(
                            color: AppColors.newSecondary,
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                        ),
                        child: Center(
                            child: Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      if(qty>1)
                                        {
                                          qty--;
                                        }
                                    },
                                    child:
                                    Text("-", style: TextStyle(fontSize: 19))),
                                Obx(
                                   () {
                                    return Text(
                                      "   $qty   ",
                                      style: TextStyle(
                                        color: AppColors.newIconColor,
                                      ),
                                    );
                                  }
                                ),
                                InkWell(
                                    onTap: () {
                                      qty++;
                                    },
                                    child: Text(
                                      "+",
                                      style: TextStyle(fontSize: 19),
                                    )),
                              ],
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                          // remove(index);
                        },
                        child: Container(
                          // width: 85,
                          decoration: BoxDecoration(
                              color: const Color(0xff9B1F1F),
                              borderRadius: BorderRadius.circular(5)),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: const Center(
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
    );}else{
      Get.defaultDialog(content: Text("Already in basket"),cancel: ElevatedButton(
  onPressed:(){

  Get.back();
  },
  // onPressed: Get.back,
  child: Text('Cancel'),
  style: ElevatedButton.styleFrom(
  backgroundColor: AppColors.deliveryPrimary80,
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(12), // <-- Radius
  ),
  ),
  ));
    }
  }else{
  Get.defaultDialog(content: Text("No Prouduct matched"),cancel:ElevatedButton(
    onPressed:(){

      Get.back();
    },
    // onPressed: Get.back,
    child: Text('Cancel'),
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.deliveryPrimary80,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // <-- Radius
      ),
    ),
  ));
  }
}
  void addToBasket(Product product) {
    var isAdded = addedProducts
        .firstWhereOrNull((element) => element.cartItem!.id == product.id); if (isAdded == null) {
      CartProduct temp = CartProduct();
      temp.cartItem = product;
      temp.itemId = product.id;
      temp.quantity = 1;
      temp.subTotal = double.parse(product.row!.price.toString());
      temp.grandTotal = temp.subTotal!;
      addedProducts.add(temp);
    } else {
      Get.snackbar('Already in basek', 'Add another product');
    }
  }

  //lifecycle methods
  @override
  void onInit() async {
    deliveryDataProvider.newSalesCallBack = this;
    init();
    searchCtrl.addListener(() {
      List<Product> results = [];
      if (searchCtrl.text.isEmpty) {
        results = productListTemp;
      } else {
        results = productListTemp
            .where((product) => product.label!
                .toLowerCase()
                .contains(searchCtrl.text.toLowerCase()))
            .toList();
      }
      filteredProducts.value = results;
    });

    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(const Duration(milliseconds: 10));
    UINotification.showLoading();
  }

  @override
  void onClose() {
    searchCtrl.dispose();
    super.onClose();
  }

  //contracts
  @override
  onProductListDone(List<Product> productRes) {
    productListTemp.addAll(productRes);
    filteredProducts.addAll(productRes);
    if (productRes.isNotEmpty) {
      productListRequest.page = productListRequest.page! + 1;
      deliveryDataProvider.getProductsSales(productListRequest);
    } else {
      UINotification.hideLoading();
    }
  }

  @override
  onProductListError(ErrorMessage err) {
    // TODO: implement onProductListError
    throw UnimplementedError();
  }
}
