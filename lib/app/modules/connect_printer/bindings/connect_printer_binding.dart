import 'package:get/get.dart';

import '../controllers/connect_printer_controller.dart';

class ConnectPrinterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ConnectPrinterController>(ConnectPrinterController());
  }
}
