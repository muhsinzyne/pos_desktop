import 'package:get/get.dart';
import 'package:posdelivery/models/interfaces/get_x_service.dart';

class BaseGetXService extends GetxService implements IGetXService {
  @override
  void onInit() {
    dependencies();
    super.onInit();
  }

  @override
  Future dependencies() {
    print("==================================");
    print("Please add your dependencies in service file or @override to null");
    print("==================================");
    // TODO: implement dependencies
    throw UnimplementedError();
  }
}
