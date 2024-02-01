import 'package:flutter_chatapp/core/constant/AppRoute.dart';
import 'package:get/get.dart';

import '../../core/calsses/StatusRequest.dart';
import '../../core/calsses/services.dart';
import '../../core/functions/handlingData.dart';
import '../../data/models/FoldersModel.dart';
import 'FoldersData.dart';

abstract class FoldersCtrAbs extends GetxController {
  getData();
  goToFiles(FoldersModel folderInfo);
  goToAddFolder();
  goEditFolder(FoldersModel folderInfo);
  removeFolder(FoldersModel folderInfo);
  refreshData();
}

class FoldersCtr extends FoldersCtrAbs {
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequest2 = StatusRequest.none;
  FoldersData foldersData = FoldersData();
  MyServices myServices = Get.find();
  List<FoldersModel> foldersList = [];

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  @override
  getData() async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await foldersData.getData(myServices.box.read('user')['user_id']);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        response['data'].forEach((element) {
          foldersList.add(FoldersModel.fromJson(element));
        });
        print(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  goToFiles(FoldersModel folderInfo) {
    Get.toNamed(AppRoute.files, arguments: {'folderInfo': folderInfo});
  }

  @override
  goToAddFolder() {
    Get.toNamed(AppRoute.addFolders);
  }

  @override
  goEditFolder(folderInfo) {
    Get.toNamed(AppRoute.editFolders, arguments: {'folderInfo': folderInfo});
  }

  @override
  removeFolder(FoldersModel folderInfo) async {
    statusRequest2 = StatusRequest.loading;
    update();
    var response = await foldersData.removeFolder(
        folderInfo.folderId, "${folderInfo.folderFile}");
    statusRequest2 = handlingData(response);
    if (statusRequest2 == StatusRequest.success) {
      if (response['status'] == 'success') {
        refreshData();
      } else {
        statusRequest2 = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  refreshData() {
    foldersList.clear();
    getData();
    print('we did it');
  }
}
