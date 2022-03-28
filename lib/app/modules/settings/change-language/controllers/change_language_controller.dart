import 'package:posdelivery/app/modules/settings/change-language/contracts.dart';
import 'package:posdelivery/controllers/base_controller.dart';
import 'package:posdelivery/models/app_languages.dart';

class ChangeLanguageController extends BaseGetXController implements IChangeLanguage {
  void changeLanguage(AppLocale appLocale) {
    appController.changeAppLanguage(appLocale.locale);
  }
}
