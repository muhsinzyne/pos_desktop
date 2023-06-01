import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:posdelivery/models/delivery/requests/expense_add_request.dart';
import 'package:posdelivery/providers/local/blue_thermal_print_provider.dart';
import 'package:posdelivery/services/cache/cache_sembast_service.dart';

class ConnectPrinterController extends GetxController {
  BlueThermalPrinterProdvider blueThermalPrinterProdvider =
      Get.find<BlueThermalPrinterProdvider>();
}
