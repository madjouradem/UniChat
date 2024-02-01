import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/core/constant/AppLinkes.dart';
import 'package:flutter_chatapp/data/models/FoldersModel.dart';
import 'package:get/get.dart';

import '../../core/calsses/StatusRequest.dart';
import '../../core/calsses/UploadCtr.dart';
import '../../core/calsses/services.dart';
import '../../core/functions/alertWaiting.dart';
import '../Files/FilesController.dart';
import 'AddFilesData.dart';

abstract class AddFilesCtrAbs extends GetxController {
  addFile();

  refreshData();
}

class AddFilesCtr extends AddFilesCtrAbs {
  StatusRequest statusRequest = StatusRequest.none;
  AddFilesData addfilesData = AddFilesData();
  MyServices myServices = Get.find();
  File file = File('');

  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController fileNameCtr = TextEditingController();
  TextEditingController fileNicknameCtr = TextEditingController();
  late FoldersModel folderInfo;
  FilePickerResult? result;

  @override
  void onInit() {
    super.onInit();
    folderInfo = Get.arguments['folderInfo'];
  }

  @override
  addFile() async {
    if (key.currentState!.validate() && result != null) {
      alertWaiting();
      await Get.put(UploadCtr()).uploadFile(
          File(file.path),
          {
            'dir': "Files/${folderInfo.folderFile}",
            'name': fileNameCtr.text,
            "nickname": fileNicknameCtr.text,
            'folder_id': folderInfo.folderId
          },
          url: AppLink.addFiles);

      Get.back();
      Get.back();
      refreshData();
    }
  }

  // @override
  pickFile() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt', 'doc', 'pdf', 'docs', 'ppt'],
    );
    if (result != null) {
      file = File(result!.files.single.path!);
    }
    update();
  }

  @override
  refreshData() {
    Get.find<FilesCtr>().filesList.clear();
    Get.find<FilesCtr>().getData();
    print('we did it');
  }
}
