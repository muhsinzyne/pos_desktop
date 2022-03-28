import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos/add-product/controllers/product_suggestion_controller.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/models/navigation/sales_list_nav.dart';
import 'package:posdelivery/models/response/pos/customer.dart';

class CustomerSearchView extends StatefulWidget {
  const CustomerSearchView({key, this.searchTerm = ''}) : super(key: key);
  final String searchTerm;

  @override
  State<CustomerSearchView> createState() => _CustomerSearchViewState();
}

class _CustomerSearchViewState extends State<CustomerSearchView> {
  ProductSuggestionController controller =
      Get.find<ProductSuggestionController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.actionLoadingSearchCustomer(widget.searchTerm);
    return Container(
      child: Obx(() {
        return ListView.builder(
          itemCount: controller.customerList.length,
          itemBuilder: (BuildContext context, int i) {
            CustomerInfo cInfo = controller.customerList[i];
            return ListTile(
              onTap: () async {
                SalesListNavParams salesListNavParams = SalesListNavParams();
                salesListNavParams.customerId = cInfo.id;
                Get.offAndToNamed(Routes.salesList,
                    arguments: salesListNavParams);
              },
              title: Text(cInfo.text!),
            );
          },
        );
      }),
    );
  }
}
