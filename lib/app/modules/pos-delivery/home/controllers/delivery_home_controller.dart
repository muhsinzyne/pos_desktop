import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:posdelivery/controllers/base_controller.dart';

class DeliveryHomeScreenController extends BaseGetXController {
  @override
  void onInit() {
    super.onInit();
  }

  void test() {
    logger.e("test");
  }

  final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ));
  @override
  void onReady() async {
    logger.e("hello");
    bool permGranted = true;
    var status = await Permission.location.status;
    var bluStatus = await Permission.bluetoothScan.status;
    var conStatus = await Permission.bluetoothConnect.status;
    if (status.isDenied && bluStatus.isDenied && conStatus.isDenied) {
      permGranted = false;
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.bluetoothScan,
        Permission.bluetoothAdvertise,
        Permission.bluetoothConnect
      ].request();
      if (statuses[Permission.location]!.isGranted &&
          statuses[Permission.bluetoothScan]!.isGranted &&
          statuses[Permission.bluetoothAdvertise]!.isGranted &&
          statuses[Permission.bluetoothConnect]!.isGranted) {
        permGranted = true;
      } //check each permission status after.
    }
    super.onReady();
  }
}
