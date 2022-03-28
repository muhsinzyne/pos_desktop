import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/customer_view_controller.dart';

class CustomerViewView extends GetView<CustomerViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CustomerViewView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CustomerViewView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
