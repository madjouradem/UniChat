import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/Channels/ChannelController.dart';
import 'package:flutter_chatapp/core/functions/alertWaiting.dart';
import 'package:flutter_chatapp/core/functions/handlingData.dart';
import 'package:flutter_chatapp/core/functions/showAlert.dart';
import 'package:flutter_chatapp/data/models/ChannelModel.dart';
import 'package:flutter_chatapp/data/models/UsersModel.dart';
import 'package:get/get.dart';

import '../../core/calsses/StatusRequest.dart';
import '../../core/calsses/services.dart';
import '../../core/calsses/webSocketConn.dart';
import 'EditChannelData.dart';

abstract class EditChannelCtrAbs extends GetxController {
  onSelectedAll(bool value);
  onEditChannel();
  refreshData();
  sendMessage(Map data);
}

class EditChannelCtr extends EditChannelCtrAbs {
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequest2 = StatusRequest.none;
  EditChannelData editChannelData = EditChannelData();
  MyServices myServices = Get.find();
  WebSocketConn webConn = Get.find();
  TextEditingController channelname = TextEditingController();
  late bool isAvailble;
  late ChannelModel channelInfo;
  List<UserModel> usersList = Get.find<ChannelCtr>().userList;
  List membersList = [];
  bool selectedAll = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void onInit() {
    channelInfo = Get.arguments['channelModel'];
    channelname.text = channelInfo.chanName!;
    isAvailble = channelInfo.isAvailable == '1' ? true : false;
    super.onInit();
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
  onEditChannel() async {
    if (!key.currentState!.validate()) {
      return;
    }
    alertWaiting();
    var response = await editChannelData.editChannel(
        channelInfo.chanId!, channelname.text, isAvailble ? '1' : '0');
    statusRequest2 = handlingData(response);
    if (statusRequest2 == StatusRequest.success) {
      if (response['status'] == 'success') {
        // refreshData();

        //for going to channel page
        Get.back();
        Get.back();
        Get.back();
        Get.back();

        // Map data = {
        //   'type': 'addChanMember',
        //   'members': membersList.isNotEmpty ? membersList : 'null',
        // };
        // sendMessage(data);
        refreshData();

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

  @override
  refreshData() {
    Get.find<ChannelCtr>().channelList.clear();
    Get.find<ChannelCtr>().userList.clear();
    Get.find<ChannelCtr>().getData();
  }
}
