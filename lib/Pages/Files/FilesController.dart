import 'package:flutter_chatapp/core/constant/AppRoute.dart';
import 'package:flutter_chatapp/data/models/FilesModel.dart';
import 'package:flutter_chatapp/data/models/FoldersModel.dart';
import 'package:get/get.dart';

import '../../core/calsses/StatusRequest.dart';
import '../../core/calsses/services.dart';
import '../../core/functions/handlingData.dart';
import 'FilesData.dart';

abstract class FilesCtrAbs extends GetxController {
  getData();
  goToAddFiles();
  goToEditFiles(FilesModel fileInfo);
  removeFile(FilesModel fileInfo);
  refreshData();
}

class FilesCtr extends FilesCtrAbs {
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequest2 = StatusRequest.none;
  FilesData filesData = FilesData();
  MyServices myServices = Get.find();
  List<FilesModel> filesList = [];
  late FoldersModel folderInfo;

  @override
  void onInit() {
    folderInfo = Get.arguments['folderInfo'];
    getData();
    super.onInit();
  }

  @override
  getData() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await filesData.getData(folderInfo.folderId);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        response['data'].forEach((element) {
          filesList.add(FilesModel.fromJson(element));
        });
        print(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  goToAddFiles() {
    Get.toNamed(AppRoute.addFiles, arguments: {'folderInfo': folderInfo});
  }

  @override
  goToEditFiles(fileInfo) {
    Get.toNamed(AppRoute.editFiles, arguments: {'fileInfo': fileInfo});
  }

  @override
  removeFile(FilesModel fileInfo) async {
    statusRequest2 = StatusRequest.loading;
    update();
    var response = await filesData.removeFile(
        fileInfo.fileId, "${folderInfo.folderFile}/${fileInfo.fileContent}");
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
    filesList.clear();
    getData();
    print('we did it');
  }
}
