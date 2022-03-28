import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/customer_payment_controller.dart';

class CustomerPaymentView extends GetView<CustomerPaymentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('customer_payment'.tr),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CustomerPaymentView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
