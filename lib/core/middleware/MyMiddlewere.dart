import 'package:flutter/cupertino.dart';
import 'package:flutter_chatapp/core/calsses/services.dart';
import 'package:flutter_chatapp/core/constant/AppRoute.dart';
import 'package:get/get.dart';

class MyMiddlewere extends GetMiddleware {
  MyServices myServices = Get.find();
  @override
  // TODO: implement priority
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    if (myServices.box.read('step') == '2') {
      return const RouteSettings(name: AppRoute.conversation);
    }
    if (myServices.box.read('step') == '1') {
      return const RouteSettings(name: '/');
    }
    return null;
  }
}
