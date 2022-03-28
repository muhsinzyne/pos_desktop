import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/ui/theme/app_colors.dart';
import 'package:posdelivery/models/app_languages.dart';

import '../controllers/change_language_controller.dart';

class ChangeLanguageView extends GetView<ChangeLanguageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: Text('change_language'.tr),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: controller.appService.languageList.length,
          itemBuilder: (context, i) {
            AppLocale cLanguage = controller.appService.languageList[i];
            return ListTile(
              leading: Container(
                child: Icon(Icons.language),
              ),
              title: Text(cLanguage.label.tr),
              trailing: Image.asset(
                cLanguage.icon,
                width: 40,
              ),
              onTap: () {
                controller.changeLanguage(cLanguage);
              },
            );
          },
        ),
      ),
    );
  }
}
