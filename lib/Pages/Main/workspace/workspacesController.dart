import 'package:flutter_chatapp/Pages/Main/mainController.dart';
import 'package:get/get.dart';

import '../../../core/calsses/StatusRequest.dart';
import '../../../core/calsses/services.dart';
import '../../../core/constant/AppRoute.dart';
import '../../../core/functions/alertWaiting.dart';
import '../../../core/functions/handlingData.dart';
import '../../../core/functions/showAlert.dart';
import '../mainData.dart';

abstract class WorkspaceCtrAbs extends GetxController {
  goToChannel(String wsId, String wsFile);
  goToCreateWS();
  deleteWS(String wsId, String wsFile);
}

class WorkspaceCtr extends WorkspaceCtrAbs {
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequest2 = StatusRequest.none;
  MainData mainData = MainData();
  MyServices myServices = Get.find();
  MainCtr mainCtr = Get.find();

  @override
  goToChannel(String wsId, String wsFile) async {
    String id = myServices.box.read('user')['user_id'];
    if (myServices.box.read('isWS$wsId$id') == null) {
      alertWaiting();

      var response = await mainData.insertDatainWsmember(
          myServices.box.read('user')['user_id'], wsId);
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          Get.back();
          myServices.box.write('isWS$wsId$id', true);

          Get.toNamed(AppRoute.channel, arguments: {
            'wsId': wsId,
            'wsFile': wsFile,
          });
        } else {
          showAlert(title: '', content: 'failure');
          myServices.box.remove('isWS$wsId$id');
        }
      }
    } else {
      Get.toNamed(AppRoute.channel, arguments: {
        'wsId': wsId,
        'wsFile': wsFile,
      });
    }
  }

  @override
  goToCreateWS() {
    Get.toNamed(AppRoute.createws);
  }

  @override
  deleteWS(String wsId, String wsFile) async {
    alertWaiting();
    var response = await mainData.deleteWorkspace(wsId, wsFile);
    statusRequest2 = handlingData(response);
    if (statusRequest2 == StatusRequest.success) {
      Get.back();
      mainCtr.refreshData();
      Get.back();
      Get.snackbar('status', 'success');
    } else {
      Get.back();
      showAlert(title: 'status', content: 'failure');
    }
  }
}
