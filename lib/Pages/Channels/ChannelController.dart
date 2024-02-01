import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_chatapp/Pages/Channels/ChannelData.dart';
import 'package:flutter_chatapp/core/calsses/services.dart';
import 'package:flutter_chatapp/core/calsses/webSocketConn.dart';
import 'package:flutter_chatapp/core/constant/AppRoute.dart';
import 'package:flutter_chatapp/core/functions/alertWaiting.dart';
import 'package:flutter_chatapp/data/models/ChannelModel.dart';

import '../../core/calsses/StatusRequest.dart';
import '../../core/calsses/Statusmember.dart';
import '../../core/functions/checkInternet.dart';
import '../../core/functions/crypte.dart';
import '../../core/functions/handlingData.dart';
import '../../data/models/UsersModel.dart';

abstract class ChannelCtrAbs extends GetxController {
  getData();
  gotoGroupChatRoom(ChannelModel channelInfo);
  verifiyJoining(String channelId);
  gotoCreateChannel();
  refreshData();
  getColor(String element);
}

class ChannelCtr extends ChannelCtrAbs {
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequest2 = StatusRequest.none;
  ChannelData channelData = ChannelData();
  MyServices myServices = Get.find();
  List<ChannelModel> channelList = [];
  List<UserModel> userList = [];
  WebSocketConn webConn = Get.find();
  Statusmember statusmember = Statusmember.none;
  String chanName = '';
  String chanId = '';
  var colorsList = {
    Colors.teal: [],
    Colors.orange: [
      'A',
      'B',
      'C',
      'D',
      'E',
    ],
    Colors.blue: [
      'F',
      'G',
      'H',
      'I',
      'J',
    ],
    Colors.green: [
      'L',
      'M',
      'N',
      'O',
      'T',
      'Q',
    ],
    Colors.purpleAccent: [
      'R',
      'S',
      'p',
      'U',
      'V',
    ],
    Colors.yellow: [
      'K',
      'W',
      'X',
      'Y',
      'Z',
    ],
  };

  late String wsId;
  late String wsFile;

  @override
  void onInit() {
    wsId = Get.arguments['wsId'];
    wsFile = Get.arguments['wsFile'];
    connect();
    getData();
    super.onInit();
  }

  connect() {
    String id = myServices.box.read('user')['user_id'];

    print('try to lisent llllslslls');
    webConn.strm!.listen(
      (event) {
        Map data = jsonDecode(event);
        print(data);

        // messagesList.insert(0, MessageModel.fromJson(jsonDecode(event)));
        if (data['type'] == 'group') {
          print('object 0000000000');

          for (int i = 0; i < channelList.length; i++) {
            print('object 000020200');

            if (data['mes_chan_id'] == channelList[i].chanId) {
              // != virefiy
              channelList[i].chanSenderId = data['mes_sender_id'];
              channelList[i].chanLastMes = data['mes_content'];
              channelList[i].chanLastMesDate = DateTime.now();

              if (chanId != '') {
                if (data['mes_sender_id'] != id) {
                  if (!channelList[i].chanRead!.contains(id.toString())) {
                    channelList[i].chanRead!.add(id.toString());
                  }
                }
              } else {
                chanName = channelList[i].chanName!;
                if (channelList[i].chanRead!.contains(id.toString())) {
                  channelList[i].chanRead!.remove(id.toString());
                }
                if (data['mes_sender_id'] != id) {
                  Get.snackbar(chanName, decodeString(data['mes_content']));
                }
              }

              break;
            }
            update();
          }
          channelList.sort(
            (a, b) => b.chanLastMesDate!.compareTo(a.chanLastMesDate!),
          );
        } else if (data['type'] == 'addChanMember') {
          print('object start');

          refreshData();

          print('object done23');
        }

        update();
      },
      onDone: () async {
        if (await checkInternet() == false) {
          print('checkInternet and reconnect');
        }
      },
    );
  }

  @override
  getData() async {
    statusRequest = StatusRequest.loading;
    // userList.sort()
    update();

    // if (myServices.box.read('user')['user_type'] != 'prof') {
    var response = await channelData.getDataForStudent(
        wsId, myServices.box.read('user')['user_id']);
    //print('we dont ${response['data']}have Data');

    statusRequest = handlingData(response);
    print(statusRequest);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        if (response['data']['channels'] != 0) {
          response['data']['channels'].forEach((element) {
            channelList.add(ChannelModel.fromJson(element));
          });
        }
        if (response['data']['users'] != 0) {
          response['data']['users'].forEach((element) {
            userList.add(UserModel.fromJson(element));
          });
        }
        update();
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    // } else {
    //   var response = await channelData.getDataForProfs(wsId);
    //   statusRequest = handlingData(response);
    //   if (statusRequest == StatusRequest.success) {
    //     if (response['status'] == 'success') {
    //       response['data']['channels'].forEach((element) {
    //         channelList.add(ChannelModel.fromJson(element));
    //       });
    //       response['data']['users'].forEach((element) {
    //         userList.add(UserModel.fromJson(element));
    //       });
    //       print('we have Data === $channelList');
    //     } else {
    //       print('we dont have Data');
    //       statusRequest = StatusRequest.failure;
    //     }
    //   }
    // }
  }

  @override
  gotoGroupChatRoom(ChannelModel channelInfo) async {
    await verifiyJoining(channelInfo.chanId!);
    Get.toNamed(AppRoute.groupchatroom, arguments: {
      'channelModel': channelInfo,
      'wsId': wsId,
      "wsFile": wsFile
    });
  }

  @override
  verifiyJoining(String channelId) async {
    alertWaiting();
    var response = await channelData.verifiyJoin(
        channelId, myServices.box.read('user')['user_id']);
    statusRequest2 = handlingData(response);
    if (statusRequest2 == StatusRequest.success) {
      if (response['status'] == 'success') {
        statusmember = Statusmember.join;
      } else {
        statusmember = Statusmember.notJoin;
      }
    }
    update();
    Get.back();
  }

  @override
  gotoCreateChannel() {
    Get.toNamed(AppRoute.createChannel,
        arguments: {'wsId': wsId, 'wsFile': wsFile});
  }

  @override
  refreshData() {
    channelList.clear();
    userList.clear();
    getData();
    print('we did it 00000');
    update();
  }

  @override
  Color getColor(String element) {
    Color color = Colors.teal;

    colorsList.forEach((key, value) {
      if (value.contains(element)) {
        color = key;
      }
    });

    return color;
  }
}
