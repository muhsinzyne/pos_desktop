import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posdelivery/app/routes/app_pages.dart';

class AuthenticationMiddleware extends GetMiddleware {
  bool isAuthenticated = false;

  @override
  int get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    if (isAuthenticated == false) {
      return RouteSettings(name: Routes.login);
    }
  }

  /// on page called
  @override
  GetPage? onPageCalled(GetPage? page) {
    return super.onPageCalled(page);
  }

  /// on binding starts
  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    return super.onBindingsStart(bindings);
  }
}
