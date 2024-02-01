import 'dart:convert';

import 'package:get/get.dart';

import '../../core/calsses/StatusRequest.dart';
import '../../core/calsses/services.dart';
import '../../core/calsses/webSocketConn.dart';
import '../../core/functions/handlingData.dart';
import '../../data/models/ChannelModel.dart';
import '../../data/models/UsersModel.dart';
import 'AddChanMemberData.dart';

abstract class AddChanMemberCtrAbs extends GetxController {
  getData();
  onSelectedAll(bool value);
  onAddMember();
  sendMessage(Map data);
}

class AddChanMemberCtr extends AddChanMemberCtrAbs {
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequest2 = StatusRequest.none;
  AddChanMemberData addChanMemberData = AddChanMemberData();
  MyServices myServices = Get.find();
  List<UserModel> usersList = [];
  late String wsId;
  late ChannelModel channelInfo;
  List membersList = [];
  WebSocketConn webConn = Get.find();

  bool selectedAll = false;

  @override
  void onInit() {
    super.onInit();
    wsId = Get.arguments['wsId'];
    channelInfo = Get.arguments['channelModel'];
    getData();
  }

  @override
  getData() async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await addChanMemberData.getUsersIsNotInChan(channelInfo.chanId!, wsId);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        response['data'].forEach((element) {
          usersList.add(UserModel.fromJson(element));
        });
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
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
  onAddMember() async {
    if (membersList.isNotEmpty) {
      var response =
          await addChanMemberData.addMember(channelInfo.chanId!, membersList);
      statusRequest2 = handlingData(response);
      if (statusRequest2 == StatusRequest.success) {
        Get.back();
        Map data = {
          'type': 'addChanMember',
          'members': membersList,
        };
        sendMessage(data);
        Get.snackbar('sataus', 'success');
      } else {
        Get.snackbar('sataus', 'failure');
      }
    }
  }

  @override
  sendMessage(Map data) {
    webConn.channel!.sink.add(jsonEncode(data));
  }
}
