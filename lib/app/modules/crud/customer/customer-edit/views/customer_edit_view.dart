import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/customer_edit_controller.dart';

class CustomerEditView extends GetView<CustomerEditController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CustomerEditView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CustomerEditView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
