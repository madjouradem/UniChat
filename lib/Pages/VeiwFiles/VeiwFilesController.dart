import 'package:flutter_chatapp/Pages/ChatRoom/chatroomController.dart';
import 'package:flutter_chatapp/Pages/VeiwFiles/VeiwFilesData.dart';
import 'package:flutter_chatapp/core/constant/AppRoute.dart';
import 'package:flutter_chatapp/data/models/privateMessagesModel.dart';
import 'package:get/get.dart';

import '../../core/calsses/StatusRequest.dart';
import '../../core/calsses/services.dart';

abstract class VeiwFilesCtrAbs extends GetxController {
  getFilesandMedia();
  showVideo(String videoName);
}

class VeiwFilesCtr extends VeiwFilesCtrAbs {
  StatusRequest statusRequest = StatusRequest.none;
  VeiwFilesData veiwFilesData = VeiwFilesData();
  MyServices myServices = Get.find();
  ChatroomCtr chatroomCtr = Get.find();
  List<privateMessagesModel> filesList = [];
  List<privateMessagesModel> mediaList = [];
  List<privateMessagesModel> linksList = [];
  @override
  void onInit() {
    getFilesandMedia();
    super.onInit();
  }

  @override
  getFilesandMedia() {
    for (var element in chatroomCtr.messagesList) {
      if (element.mesType == 'file') {
        filesList.add(element);
      } else if (element.mesType == 'image' || element.mesType == 'video') {
        mediaList.add(element);
      } else if (element.mesType == 'link') {
        linksList.add(element);
      }
    }

    update();
  }

  @override
  showVideo(String videoName) {
    Get.toNamed(AppRoute.showVideo, arguments: {'videoName': videoName});
  }
}
