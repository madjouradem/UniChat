import 'package:flutter_chatapp/core/calsses/webSocketConn.dart';
import 'package:flutter_chatapp/core/functions/alertWaiting.dart';
import 'package:flutter_chatapp/core/functions/handlingData.dart';
import 'package:get/get.dart';

import '../../core/calsses/StatusRequest.dart';
import '../../core/calsses/services.dart';
import '../../core/constant/AppRoute.dart';
import '../../data/models/ChannelModel.dart';
import 'GroupMoreInfoData.dart';

abstract class GroupMoreInfoCtrAbs extends GetxController {
  goToAddChanMember();
  goToEditChanMember();
  deleteChannel(String chanId, String chanFile);
}

class GroupMoreInfoCtr extends GroupMoreInfoCtrAbs {
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequest2 = StatusRequest.none;
  GroupMoreInfoData groupMoreInfoData = GroupMoreInfoData();
  MyServices myServices = Get.find();
  WebSocketConn webSocketConn = Get.find();
  late String wsId;
  late String wsFile;
  late ChannelModel channelInfo;

  @override
  void onInit() {
    wsId = Get.arguments['wsId'];
    channelInfo = Get.arguments['channelModel'];
    wsFile = Get.arguments['wsFile'];

//
    super.onInit();
  }

  @override
  goToAddChanMember() {
    Get.toNamed(AppRoute.addChanMember,
        arguments: {'channelModel': channelInfo, 'wsId': wsId});
  }

  @override
  goToEditChanMember() {
    Get.toNamed(AppRoute.editChannel, arguments: {
      'channelModel': channelInfo,
    });
  }

  @override
  deleteChannel(String chanId, String chanFile) async {
    var response = await groupMoreInfoData.deleteChannel(chanId, chanFile);
    List membersList = [];
    alertWaiting();
    statusRequest2 = handlingData(response);
    if (statusRequest2 == StatusRequest.success) {
      if (response['status'] == 'success') {
        Get.back();
        Get.back();
        Get.back();
        for (var val in response['data']) {
          membersList.add(val['user_id']);
        }
        print('======================================');
        print(membersList);
        print('======================================');

        Map data = {
          'type': 'addChanMember',
          'members': membersList.isNotEmpty ? membersList : 'null',
        };
        webSocketConn.sendMessage(data);
        Get.snackbar('status', 'success');
      } else {
        Get.back();
      }
    } else {
      Get.back();
    }
  }
}
