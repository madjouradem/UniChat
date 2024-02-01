import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/CreateConversation.dart/CreateConversationData.dart';
import 'package:flutter_chatapp/core/functions/showAlert.dart';
import 'package:flutter_chatapp/data/models/UsersModel.dart';
import 'package:get/get.dart';

import '../../core/calsses/StatusRequest.dart';
import '../../core/calsses/services.dart';
import '../../core/constant/AppRoute.dart';
import '../../core/functions/handlingData.dart';
import '../../core/calsses/webSocketConn.dart';
import '../../data/models/ConversationModel.dart';
import '../Main/Conversation/ConversationController.dart';
import '../Main/mainController.dart';

abstract class CreateConversationCtrAbs extends GetxController {
  getData();
  addConversation(String userid, String userName, String userImage);
  addConversationById();
  gotoChatRoom(
      {required userId,
      required userName,
      required convId,
      required convFile,
      required userImage});
  readMessage(String userid);
  refreshData();
  sendMessage(Map data);
}

class CreateConversationCtr extends CreateConversationCtrAbs {
  StatusRequest statusRequest = StatusRequest.none;
  CreateConversationData createConversationData = CreateConversationData();
  MyServices myServices = Get.find();
  MainCtr mainCtr = Get.find();
  WebSocketConn webConn = Get.find();
  List<UserModel> usersList = [];
  UserModel? userinfo;
  TextEditingController textCtr = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  @override
  getData() async {
    if (myServices.box.read('user')['user_type'] == 'student') {
      statusRequest = StatusRequest.loading;
      update();
      print('////////////////////////////////');

      print(myServices.box.read('user')['user_gro_id']);
      print('////////////////////////////////');

      var response = await createConversationData.getData(
          myServices.box.read('user')['user_gro_id'],
          myServices.box.read('user')['user_sea_id'],
          myServices.box.read('user')['user_spe_id']);

      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          print('${response['data']}');
          response['data'].forEach((element) {
            usersList.add(UserModel.fromJson(element));
          });

          print('we have Data');
        } else {
          print('we dont have Data');

          statusRequest = StatusRequest.failure;
        }
      }

      update();
    }
  }

  @override
  addConversation(String userid, String userName, dynamic userImage) async {
    ConversationModel? conversationModel;
    //check if the conversation isExist
    for (int i = 0; i < mainCtr.conversationsList.length; i++) {
      if ('${myServices.box.read('user')['user_id']}$userid' ==
              mainCtr.conversationsList[i].id ||
          '${myServices.box.read('user')['user_id']}$userid' ==
              mainCtr.conversationsList[i].id) {
        conversationModel = mainCtr.conversationsList[i];
        break;
      }
    }
    if (conversationModel == null) {
      var response = await createConversationData.addConversation(
          myServices.box.read('user')['user_id'], userid);

      if (response['status'] == 'success') {
        Map data = {
          'type': 'addConversation',
          'userid1': myServices.box.read('user')['user_id'],
          'userid2': userid,
          'mes_type': 'text'
        };
        sendMessage(data);
        gotoChatRoom(
          userId: userid,
          userName: userName,
          convId: response['data'][0]['id'],
          convFile: response['data'][0]['conv_file'],
          userImage: userImage,
        );
        readMessage(userid);
      }
    } else {
      gotoChatRoom(
        userId: userid,
        userName: userName,
        convId: conversationModel.id,
        convFile: conversationModel.convFile,
        userImage: userImage,
      );
      readMessage(userid);
    }
    // var response = await createConversationData.addConversation(
    //     myServices.box.read('user')['user_id'], userid);

    // if (response['status'] == 'success') {
    //   refreshData();
    //   gotoChatRoom(userId: userid, userName: userName);
    // } else if (response['status'] == 'success0') {
    //   gotoChatRoom(userId: userid, userName: userName);
    // } else {
    //   showAlert(title: '', content: 'try again');
    // }
  }

  @override
  gotoChatRoom(
      {required userId,
      required userName,
      required convId,
      required convFile,
      required userImage}) {
    mainCtr.userId = userId;
    Get.toNamed(AppRoute.chatroom, arguments: {
      'userId': userId,
      'userName': userName,
      'convId': convId,
      'convFile': convFile,
      'userImage': userImage
    });
  }

  @override
  readMessage(String userid) async {
    String id = myServices.box.read('user')['user_id'];

    for (int i = 0; i < mainCtr.conversationsList.length; i++) {
      if (mainCtr.conversationsList[i].id == '$userid$id' &&
              mainCtr.conversationsList[i].userId ==
                  mainCtr.conversationsList[i].fromId &&
              mainCtr.conversationsList[i].messageStatus == '0' ||
          mainCtr.conversationsList[i].id == '$id$userid' &&
              mainCtr.conversationsList[i].userId ==
                  mainCtr.conversationsList[i].fromId &&
              mainCtr.conversationsList[i].messageStatus == '0') {
        var response = await mainCtr.mainData
            .updateConversation(mainCtr.conversationsList[i].id!);
        if (response['status'] == 'success') {
          mainCtr.conversationsList[i].messageStatus = '1';
          mainCtr.update();
          Get.find<ConversationCtr>().update();
        }
      }
    }
  }

  @override
  refreshData() {
    mainCtr.conversationsList.clear();
    mainCtr.getData();
  }

  @override
  sendMessage(Map data) {
    webConn.channel!.sink.add(jsonEncode(data));
  }

  @override
  addConversationById() async {
    if (formstate.currentState!.validate()) {
      var response =
          await createConversationData.addConversationById(textCtr.text);

      if (response['status'] == 'success') {
        userinfo = UserModel.fromJson(response['data']);
        Get.back();

        addConversation(
            userinfo!.userId!, userinfo!.userName!, userinfo!.userAvatar);
        //   gotoChatRoom(
        //       userId:
        //       userName: ,
        //       convFile: '');
        //   //add conv => real time "ws:"
        //   Map data = {
        //     'type': 'addConversation',
        //     'userid1': myServices.box.read('user')['user_id'],
        //     'userid2': userinfo!.userId!,
        //     'mes_type': 'text'
        //   };
        //   sendMessage(data);
        //   readMessage(userinfo!.userId!);
      } else {
        showAlert(title: '', content: 'not found');
      }
    }
  }
}
