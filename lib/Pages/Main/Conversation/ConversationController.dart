import 'package:flutter_chatapp/Pages/Main/mainController.dart';
import 'package:flutter_chatapp/core/calsses/webSocketConn.dart';
import 'package:get/get.dart';
import '../../../core/calsses/services.dart';
import '../../../core/constant/AppRoute.dart';
import '../mainData.dart';

abstract class ConversationCtrAbs extends GetxController {
  //to create a new conversation
  gotoCreateContact();
  //for go to the private chat room
  gotoChatRoom(
      {required userId,
      required userName,
      required convId,
      required userImage,
      required convFile});
  //hindlling notification for the new message
  // readMessage(String userid);
  // chackUserStatus();
}

class ConversationCtr extends ConversationCtrAbs {
  MainData mainData = MainData();
  MainCtr homeCtr = Get.find();
  WebSocketConn webSocketConn = Get.find();
  MyServices myServices = Get.find();

  @override
  void onInit() {
    // chackUserStatus();
    super.onInit();
  }

  @override
  gotoCreateContact() {
    Get.toNamed(AppRoute.createcontact);
  }

  @override
  gotoChatRoom(
      {required userId,
      required userName,
      required convId,
      required userImage,
      required convFile}) {
    homeCtr.userId = userId;
    Get.toNamed(AppRoute.chatroom, arguments: {
      'userId': userId,
      'userName': userName,
      'convId': convId,
      'userImage': userImage,
      'convFile': convFile
    });
    // readMessage(userId);
  }

  // @override
  // chackUserStatus() {
  //   Map data = {
  //     'type': 'chackStatus',
  //     'user_id': myServices.box.read('user')['user_id']
  //   };

  //   sendMessage(data);
  // }

  // sendMessage(Map data) {
  //   webSocketConn.channel!.sink.add(jsonEncode(data));
  // }

  // @override
  // readMessage(String userid) async {
  //   String id = myServices.box.read('user')['user_id'];
  //   for (int i = 0; i < homeCtr.conversationsList.length; i++) {
  //     if (homeCtr.conversationsList[i].id == '$userid$id' &&
  //             homeCtr.conversationsList[i].userId ==
  //                 homeCtr.conversationsList[i].fromId &&
  //             homeCtr.conversationsList[i].messageStatus == '0' ||
  //         homeCtr.conversationsList[i].id == '$id$userid' &&
  //             homeCtr.conversationsList[i].userId ==
  //                 homeCtr.conversationsList[i].fromId &&
  //             homeCtr.conversationsList[i].messageStatus == '0') {
  //       var response =
  //           await mainData.updateConversation(homeCtr.conversationsList[i].id!);
  //       if (response['status'] == 'success') {
  //         homeCtr.conversationsList[i].messageStatus = '1';
  //         homeCtr.update();
  //       }
  //     }
  //   }
  // }
}
