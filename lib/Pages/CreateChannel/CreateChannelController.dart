import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/Channels/ChannelController.dart';
import 'package:flutter_chatapp/core/functions/alertWaiting.dart';
import 'package:flutter_chatapp/core/functions/handlingData.dart';
import 'package:flutter_chatapp/core/functions/showAlert.dart';
import 'package:flutter_chatapp/data/models/UsersModel.dart';
import 'package:get/get.dart';

import '../../core/calsses/StatusRequest.dart';
import '../../core/calsses/services.dart';
import '../../core/calsses/webSocketConn.dart';
import 'CreateChannelData.dart';

abstract class CreateChannelCtrAbs extends GetxController {
  onSelectedAll(bool value);
  onCreateChannel();
  sendMessage(Map data);
}

class CreateChannelCtr extends CreateChannelCtrAbs {
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequest2 = StatusRequest.none;
  CreateChannelData createChannelData = CreateChannelData();
  MyServices myServices = Get.find();
  WebSocketConn webConn = Get.find();
  ChannelCtr channelCtr = Get.find();
  TextEditingController channelname = TextEditingController();
  bool isAvailble = true;
  late String wsId;
  late String wsFile;
  List<UserModel> usersList = Get.find<ChannelCtr>().userList;
  List membersList = [];
  bool selectedAll = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    wsId = Get.arguments['wsId'];
    wsFile = Get.arguments['wsFile'];
  }

  @override
  onSelectedAll(bool value) {
    if (value) {
      for (var val in usersList) {
        if (val.isChoosed == false) {
          val.isChoosed = true;
          membersList.add(val.userId);
        }
      }
    } else {
      for (var val in usersList) {
        if (val.isChoosed == true) {
          val.isChoosed = false;
          membersList.remove(val.userId);
        }
      }
    }
    selectedAll = value;
    print(membersList);

    update();
  }

  @override
  onCreateChannel() async {
    if (!membersList.contains(myServices.box.read('user')['user_id']) &&
        !isAvailble) {
      membersList.add(myServices.box.read('user')['user_id']);
    }

    if (!key.currentState!.validate()) {
      return;
    }
    alertWaiting();
    String userId = myServices.box.read('user')['user_id'];

    var response = await createChannelData.addChannel(
        wsId, channelname.text, userId, wsFile, membersList);
    statusRequest2 = handlingData(response);
    if (statusRequest2 == StatusRequest.success) {
      if (response['status'] == 'success') {
        // channelCtr.refreshData();
        if (isAvailble) {
          for (UserModel val in usersList) {
            membersList.add(val.userId);
          }
          print(membersList);
        }
        if (!membersList.contains(myServices.box.read('user')['user_id'])) {
          membersList.add(myServices.box.read('user')['user_id']);
        }
        Get.back();
        Get.back();

        Map data = {
          'type': 'addChanMember',
          'members': membersList.isNotEmpty ? membersList : 'null',
        };
        sendMessage(data);
        Get.snackbar('status', 'success');
      }
    } else {
      Get.back();
      showAlert(title: '', content: 'try again');
    }
  }

  @override
  sendMessage(Map data) {
    webConn.channel!.sink.add(jsonEncode(data));
  }
}
