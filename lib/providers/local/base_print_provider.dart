import 'package:posdelivery/services/base/get_x_service.dart';

abstract class BasePrintProvider extends BaseGetXService {
  @override
  Future dependencies() async {
    print("hello");
  }
}
