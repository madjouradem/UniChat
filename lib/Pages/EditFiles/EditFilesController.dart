import 'package:flutter/material.dart';
import 'package:flutter_chatapp/data/models/FilesModel.dart';
import 'package:get/get.dart';

import '../../core/calsses/StatusRequest.dart';
import '../../core/calsses/services.dart';
import '../../core/functions/alertWaiting.dart';
import '../../core/functions/handlingData.dart';
import '../../core/functions/showAlert.dart';
import '../Files/FilesController.dart';
import 'EditFilesData.dart';

abstract class EditFilesCtrAbs extends GetxController {
  editFile();
  refreshData();
}

class EditFilesCtr extends EditFilesCtrAbs {
  StatusRequest statusRequest = StatusRequest.none;
  EditFilesData editfilesData = EditFilesData();
  MyServices myServices = Get.find();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController fileNameCtr = TextEditingController();
  TextEditingController fileNicknameCtr = TextEditingController();
  late FilesModel fileInfo;

  @override
  void onInit() {
    super.onInit();
    fileInfo = Get.arguments['fileInfo'];
    fileNameCtr.text = fileInfo.fileName!;
    fileNicknameCtr.text = fileInfo.fileCutName!;
  }

  @override
  editFile() async {
    if (key.currentState!.validate()) {
      alertWaiting();
      var response = await editfilesData.editFile(
          fileId: fileInfo.fileId!,
          name: fileNameCtr.text,
          nickname: fileNicknameCtr.text);
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        Get.back();
        refreshData();
        Get.back();
        Get.snackbar('status', 'success');
      } else {
        Get.back();
        showAlert(title: 'status', content: 'failure');
      }
    }
  }

  @override
  refreshData() {
    Get.find<FilesCtr>().filesList.clear();
    Get.find<FilesCtr>().getData();
    print('we did it');
  }
}
