import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:posdelivery/app/modules/add_expense/views/add_expense_view.dart';
import 'package:posdelivery/app/modules/close_register/views/close_register_view.dart';
import 'package:posdelivery/app/modules/product_list/views/product_list_view.dart';
import 'package:posdelivery/app/modules/register_details/views/register_details_view.dart';
import 'package:posdelivery/app/modules/sales_point/views/sales_point_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // leading: const Padding(
        //   padding: EdgeInsets.all(8.0),
        //   child: CircleAvatar(backgroundColor: Colors.grey),
        title: const Text("Demo User"),
        backgroundColor: const Color(0xFF5D25DF),
        actions: [
          RegisterDetailsView(),
          CloseRegisterView(),
          AddExpenseView(),
        ],
      ),
      body: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: SalesPointView(),
          ),
          Expanded(
            flex: 2,
            child: ProductListView(),
          ),
        ],
      ),
    );
  }
}
