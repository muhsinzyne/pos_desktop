import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/modules/pos/add-product/controllers/product_suggestion_controller.dart';
import 'package:posdelivery/app/routes/app_pages.dart';
import 'package:posdelivery/models/response/pos/product.dart';

class ProductSuggestionView extends StatefulWidget {
  const ProductSuggestionView({key, this.searchTerm = ''}) : super(key: key);
  final String searchTerm;

  @override
  State<ProductSuggestionView> createState() => _ProductSuggestionViewState();
}

class _ProductSuggestionViewState extends State<ProductSuggestionView> {
  ProductSuggestionController controller =
      Get.find<ProductSuggestionController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.actionLoadingSearch(widget.searchTerm);
    return Container(
      child: Obx(() {
        return ListView.builder(
          itemCount: controller.productList.length,
          itemBuilder: (BuildContext context, int i) {
            Product cProduct = controller.productList[i];
            return ListTile(
              onTap: () async {
                Get.offAndToNamed(Routes.addProduct, arguments: cProduct);
              },
              title: Text(cProduct.label!),
            );
          },
        );
      }),
    );
  }
}
