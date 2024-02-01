import 'dart:convert';
import 'package:flutter_chatapp/Pages/Main/mainData.dart';
import 'package:flutter_chatapp/core/calsses/StatusRequest.dart';
import 'package:flutter_chatapp/core/calsses/services.dart';
import 'package:flutter_chatapp/data/models/ConversationModel.dart';
import 'package:flutter_chatapp/data/models/WorkSpace_Model.dart';
import 'package:get/get.dart';
import '../../core/calsses/webSocketConn.dart';
import '../../core/functions/crypte.dart';
import '../../core/functions/handlingData.dart';

abstract class MainCtrAbs extends GetxController {
  getData();
  connect();
  refreshData();
  sendMessage(Map data);
  chackUserStatus();
}

class MainCtr extends MainCtrAbs {
  StatusRequest statusRequest = StatusRequest.none;
  MainData mainData = MainData();
  MyServices myServices = Get.find();
  List<ConversationModel> conversationsList = [];
  List<WorkspaceModel> workspaceList = [];
  late WebSocketConn webConn = Get.find();

  //this var when routing to chat room == user id
  //that helping for snack mangement
  String userId = '';

  @override
  void onInit() {
    super.onInit();
    connect();
    getData();
  }

  @override
  connect() async {
    String id = myServices.box.read('user')['user_id'];

    if (webConn.channel == null) {
      if (await webConn.initWebSocket()) {
        webConn.strm!.listen(
          (event) {
            Map data = jsonDecode(event);
            if (data['type'] == 'private') {
              String? username;
              for (int i = 0; i < conversationsList.length; i++) {
                if ('' == userId && userId != conversationsList[i].userId) {
                  if ('${data['mes_from_id']}${data['mes_to_id']}' ==
                          conversationsList[i].id ||
                      '${data['mes_to_id']}${data['mes_from_id']}' ==
                          conversationsList[i].id) {
                    conversationsList[i].messageStatus = '0';
                    conversationsList[i].messageTime = DateTime.now();
                    conversationsList[i].fromId = data['mes_from_id'];
                    conversationsList[i].lastMessage = data['mes_content'];
                    username = conversationsList[i].userName!;
                    Get.snackbar(username, decodeString(data['mes_content']));
                    break;
                  }
                } else {}
              }
              conversationsList
                  .sort((a, b) => b.messageTime!.compareTo(a.messageTime!));

              update();
            } else if (data['type'] == 'addConversation') {
              Future.delayed(
                const Duration(seconds: 1),
                () {
                  sendMessage({
                    'type': 'private',
                    'mes_conv_id': "${data['userid1']}${data['userid2']}",
                    'mes_from_id': data['userid1'],
                    'mes_to_id': data['userid2'],
                    'mes_content': encodeString('👋'),
                    'mes_type': 'text',
                  });
                },
              );
              refreshData();
            } else if (data['type'] == 'chackStatus') {
              conversationsList.clear();
              List data2 = jsonDecode(data['conversations']);
              for (var element in data2) {
                conversationsList.add(ConversationModel.fromJson(element));
              }
              update();
            }
          },
        );
        chackUserStatus();
      }
    } else {
      webConn.strm!.listen((event) {
        Map data = jsonDecode(event);
        String? username;
        if (data['type'] == 'private') {
          for (int i = 0; i < conversationsList.length; i++) {
            if ('' == userId && userId != conversationsList[i].userId) {
              if (conversationsList[i].id == '$id${data['mes_from_id']}' ||
                  conversationsList[i].id == '${data['mes_from_id']}$id') {
                conversationsList[i].messageStatus = '0';
                conversationsList[i].messageTime = DateTime.now();

                conversationsList[i].fromId = data['mes_from_id'];
                conversationsList[i].lastMessage = data['mes_content'];
                username = conversationsList[i].userName!;
                update();
                Get.snackbar(username, decodeString(data['mes_content']));
                break;
              }
            } else {}
          }
        } else if (data['type'] == 'addConversation') {
          // print('ffffffffffffffff');

          // refreshData();
          // update();
        }
      });
    }
    update();
  }

  @override
  getData() async {
    statusRequest = StatusRequest.loading;
    var response;
    update();
    if (myServices.box.read('user')['user_type'] != 'prof') {
      response = await mainData.getDataForStudents(
        myServices.box.read('user')['user_gro_id'],
        myServices.box.read('user')['user_sea_id'],
        myServices.box.read('user')['user_spe_id'],
        myServices.box.read('user')['user_id'],
      );

      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          if (response['data']['conversations'] != 0) {
            response['data']['conversations'].forEach((element) {
              conversationsList.add(ConversationModel.fromJson(element));
            });

            // conversationsList
            //     .sort((a, b) => a.messageTime!.compareTo(b.messageTime!));
            // conversationsList.reversed;
          }
          if (response['data']['ws'] != 0) {
            response['data']['ws'].forEach((element) {
              workspaceList.add(WorkspaceModel.fromJson(element));
            });
          }
        } else {
          statusRequest = StatusRequest.failure;
        }
      }
    } else {
      response = await mainData.getDataForProfs(
        myServices.box.read('user')['user_id'],
      );
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          if (response['data']['conversations'] != 0) {
            response['data']['conversations'].forEach((element) {
              conversationsList.add(ConversationModel.fromJson(element));
            });
          }
          if (response['data']['ws'] != 0) {
            response['data']['ws'].forEach((element) {
              workspaceList.add(WorkspaceModel.fromJson(element));
            });
          }
        } else {
          statusRequest = StatusRequest.failure;
        }
      }
      // update();
    }
    update();
  }

  @override
  refreshData() {
    conversationsList.clear();
    workspaceList.clear();
    getData();
    print('we did it');
  }

  @override
  sendMessage(Map data) {
    webConn.channel!.sink.add(jsonEncode(data));
  }

  @override
  chackUserStatus() async {
    if (myServices.box.read('user') != null) {
      await Future.doWhile(() async {
        Map data = {
          'type': 'chackStatus',
          'user_id': myServices.box.read('user')['user_id'] ?? ''
        };
        sendMessage(data);
        await Future.delayed(const Duration(minutes: 4));
        //to finish Future.doWhile when logout
        return myServices.box.read('user') != null;
      });
    }
  }
}
