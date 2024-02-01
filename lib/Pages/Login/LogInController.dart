import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chatapp/Pages/Login/LogInData.dart';
import 'package:flutter_chatapp/core/calsses/StatusRequest.dart';
import 'package:flutter_chatapp/core/calsses/services.dart';
import 'package:flutter_chatapp/core/constant/AppRoute.dart';
import 'package:flutter_chatapp/core/functions/handlingData.dart';
import 'package:get/get.dart';

import '../../core/functions/alertWaiting.dart';

abstract class LogInCtrAbs extends GetxController {
  login();
}

class LogInCtr extends LogInCtrAbs {
  TextEditingController emailctr = TextEditingController();
  TextEditingController passwordctr = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  LoginData loginData = LoginData();

  @override
  login() async {
    if (key.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      alertWaiting();
      var response = await loginData
          .getData(emailctr.text, passwordctr.text, [3345, 3343]);
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          myServices.box.write('step', '2');

          myServices.box.write('user', response['data']);
          print(myServices.box.read('step'));
          print('////////////////////////////////');

          print(myServices.box.read('user'));
          print('////////////////////////////////');

          FirebaseMessaging.instance.subscribeToTopic('users');
          FirebaseMessaging.instance.subscribeToTopic(
              "users${myServices.box.read('user')['user_id']}");
          Get.offAllNamed(AppRoute.home);
          print('we have Data');
        } else {
          print('we dont have Data');

          statusRequest = StatusRequest.failure;
        }
      }
    }
    Get.back();
    update();
  }

  test() {}
}
