import 'package:flutter_chatapp/Pages/GroupChatRoom/GroupchatroomController.dart';
import 'package:flutter_chatapp/core/constant/AppRoute.dart';
import 'package:flutter_chatapp/data/models/GroupMessages.dart';
import 'package:get/get.dart';

import '../../core/calsses/StatusRequest.dart';
import '../../core/calsses/services.dart';
import 'GroupVeiwFilesData.dart';

abstract class GroupVeiwFilesCtrAbs extends GetxController {
  getFilesandMedia();
  showVideo(String videoName);
}

class GroupVeiwFilesCtr extends GroupVeiwFilesCtrAbs {
  StatusRequest statusRequest = StatusRequest.none;
  GroupVeiwFilesData groupveiwFilesData = GroupVeiwFilesData();
  MyServices myServices = Get.find();
  GroupchatroomCtr groupChatroomCtr = Get.find();
  List<GroupMessages> filesList = [];
  List<GroupMessages> mediaList = [];
  List<GroupMessages> linksList = [];
  @override
  void onInit() {
    getFilesandMedia();
    super.onInit();
  }

  @override
  getFilesandMedia() {
    for (var element in groupChatroomCtr.messagesList) {
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
