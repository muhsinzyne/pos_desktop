import 'package:posdelivery/app/config/flavor/src/flavor.dart';

import 'src/flavor_value.dart';

class AppFlavors {
  static FlavorValues devFlavor = FlavorValues(
    name: "beta",
    api: "",
    cdn: "",
    isTest: true,
    oneSignalAppId: "8801857e-080b-4d49-aad4-5131a192bbd4",
    oneSignalRestApiKey: "ZmFlN2Q2YjctOWNiOC00NDQyLWFmNTgtYTM0NzY4ZmVmMjdi",
    licenceServer: 'https://posksa.slasah.com/api/validate_licence',
  );

  static FlavorValues stageFlavor = FlavorValues(
    name: "Stage",
    api: "",
    cdn: "",
    isTest: true,
    oneSignalAppId: "8801857e-080b-4d49-aad4-5131a192bbd4",
    oneSignalRestApiKey: "ZmFlN2Q2YjctOWNiOC00NDQyLWFmNTgtYTM0NzY4ZmVmMjdi",
    licenceServer: 'https://posksa.slasah.com/api/validate_licence',
  );

  static FlavorValues prodFlavor = FlavorValues(
    name: "",
    api: "",
    cdn: "",
    isTest: true,
    oneSignalAppId: "8801857e-080b-4d49-aad4-5131a192bbd4",
    oneSignalRestApiKey: "ZmFlN2Q2YjctOWNiOC00NDQyLWFmNTgtYTM0NzY4ZmVmMjdi",
    licenceServer: 'https://posksa.slasah.com/api/validate_licence',
  );

  static getLogLevel() {
    if (FlavorConfig.instance.flavorValues.isTest == true) {
      return print;
    }
  }
}
