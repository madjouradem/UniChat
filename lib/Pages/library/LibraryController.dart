import 'package:flutter/material.dart';
import 'package:flutter_chatapp/core/constant/AppRoute.dart';
import 'package:flutter_chatapp/data/models/FilesModel.dart';
import 'package:flutter_chatapp/data/models/FoldersModel.dart';
import 'package:get/get.dart';

import '../../core/calsses/DownloadCtr.dart';
import '../../core/calsses/StatusRequest.dart';
import '../../core/calsses/services.dart';
import '../../core/functions/handlingData.dart';
import '../../core/functions/showAlert.dart';
import '../../data/models/SeasonModel.dart';
import '../../data/models/SpecialtyModel.dart';
import 'LibraryData.dart';

abstract class LibraryCtrAbs extends GetxController {
  onWriteInField();
  onTapSearch();
  onChangeDropDown(value);
  getData();
  goToFolders();
  onTapFilter();
  filter();
  goToFiles(FoldersModel folderInfo);
  downloadFile(String url, filename, {String? type});
}

class LibraryCtr extends LibraryCtrAbs {
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequest2 = StatusRequest.none;
  LibraryData libraryData = LibraryData();
  MyServices myServices = Get.find();
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController textEditingController = TextEditingController();
  bool isSearch = false;
  String groupValue = 'Files';
  List<FilesModel> fileList = [];
  List<FoldersModel> folderList = [];
  SpecialtyModel? specialtyVal;
  SeasonModel? seasonVal;
  bool isFilter = false;

  GlobalKey<FormState> key = GlobalKey<FormState>();
  List<SeasonModel> seasonList = [];
  List<SpecialtyModel> specialtyList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSpeSea();
  }

  @override
  onWriteInField() {
    if (textEditingController.text.isEmpty) {
      isSearch = false;
      update();
    }
  }

  @override
  onTapSearch() {
    if (formState.currentState!.validate()) {
      isSearch = true;
      getData();
      // update();
    }
  }

  @override
  onChangeDropDown(value) {
    groupValue = value;
    update();
  }

  @override
  getData() async {
    statusRequest = StatusRequest.loading;

    update();
    fileList.clear();
    folderList.clear();

    var response = await libraryData.getData(
      textEditingController.text,
      groupValue == 'Files' ? '1' : '0',
    );

    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        response['data'].forEach((element) {
          fileList.add(FilesModel.fromJson(element));
        });
        print(response['data']);
      } else if (response['status'] == 'success2') {
        response['data'].forEach((element) {
          folderList.add(FoldersModel.fromJson(element));
        });
        print(response['data']);
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  goToFolders() {
    Get.toNamed(AppRoute.folders);
  }

  getSpeSea() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await libraryData.getgetSeaSpeGroups();
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        response['data']['sea'].forEach((element) {
          seasonList.add(SeasonModel.fromJson(element));
        });
        response['data']['spe'].forEach((element) {
          specialtyList.add(SpecialtyModel.fromJson(element));
        });
      } else {
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  onChangeSpe(value) {
    specialtyVal = value;
    update();
  }

  onChangeSea(value) {
    seasonVal = value;
    update();
  }

  @override
  onTapFilter() {
    isFilter = !isFilter;
    update();
  }

  @override
  filter() async {
    statusRequest2 = StatusRequest.loading;
    if (seasonVal == null || specialtyVal == null) {
      showAlert(title: '', content: 'Please select all rows');
      statusRequest2 = StatusRequest.none;
      update();

      return;
    }
    update();
    folderList.clear();
    var response = await libraryData.filter(
      specialtyVal!.speId!,
      seasonVal!.seaId!,
    );

    statusRequest2 = handlingData(response);
    if (statusRequest2 == StatusRequest.success) {
      if (response['status'] == 'success') {
        response['data'].forEach((element) {
          folderList.add(FoldersModel.fromJson(element));
        });
        print(response['data']);
      } else {
        statusRequest2 = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  goToFiles(FoldersModel folderInfo) {
    Get.toNamed(AppRoute.files, arguments: {'folderInfo': folderInfo});
  }

  @override
  downloadFile(String url, filename, {String? type}) async {
    // myServices.box.remove('downloadPaths');
    String path = await Get.put(FileCtr()).downloadAndSaveFile(url, filename);
    if (type != '') {
      List downloadPaths = myServices.box.read('downloadPaths') ?? [];
      if (!downloadPaths.contains(filename)) {
        downloadPaths.add(path);
        myServices.box.write('downloadPaths', downloadPaths);
      }
      print(downloadPaths);
    }
  }
}
