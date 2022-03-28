import 'package:get/get.dart';
import 'package:posdelivery/app/config/flavor/flavor_service.dart';
import 'package:posdelivery/services/base/get_x_service.dart';
import 'package:posdelivery/services/base/network.dart';

abstract class BaseDataProvider extends BaseGetXService {
  late DioNetwork network;

  @override
  Future dependencies() async {
    network = Get.find<DioNetwork>();
  }

  handleErr(dynamic err) {
    if (FlavorConfig.instance.flavorValues.isTest == true) {
      //print.call(err);
    }
  }
}
