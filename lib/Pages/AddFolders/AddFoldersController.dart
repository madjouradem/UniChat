import 'package:flutter/material.dart';
import 'package:flutter_chatapp/core/constant/AppRoute.dart';
import 'package:get/get.dart';

import '../../core/calsses/StatusRequest.dart';
import '../../core/calsses/services.dart';
import '../../core/functions/alertWaiting.dart';
import '../../core/functions/handlingData.dart';
import '../../core/functions/showAlert.dart';
import '../../data/models/FoldersModel.dart';
import '../../data/models/SeasonModel.dart';
import '../../data/models/SpecialtyModel.dart';
import '../Folders/FoldersController.dart';
import 'AddFoldersData.dart';

abstract class AddFoldersCtrAbs extends GetxController {
  getData();
  goToFiles(String folderId);
  addFolder();
  refreshData();
}

class AddFoldersCtr extends AddFoldersCtrAbs {
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequest2 = StatusRequest.none;
  AddFoldersData addfoldersData = AddFoldersData();
  MyServices myServices = Get.find();
  List<FoldersModel> foldersList = [];
  SpecialtyModel? specialtyVal;
  SeasonModel? seasonVal;

  GlobalKey<FormState> key = GlobalKey<FormState>();
  List<SeasonModel> seasonList = [];
  List<SpecialtyModel> specialtyList = [];
  TextEditingController folderNameCtr = TextEditingController();
  TextEditingController folderNicknameCtr = TextEditingController();

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  @override
  getData() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await addfoldersData.getData();
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

  getSpeSea() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await addfoldersData.getData();
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
  goToFiles(String folderId) {
    Get.toNamed(AppRoute.files, arguments: {'folderId': folderId});
  }

  @override
  addFolder() async {
    if (key.currentState!.validate()) {
      // await uploadFile();
      if (seasonVal == null || specialtyVal == null) {
        showAlert(title: '', content: 'Please select all rows');
        return;
      }
      alertWaiting();
      var response = await addfoldersData.addFolder(
            userId: myServices.box.read('user')['user_id'],
            name: folderNameCtr.text,
            nickname: folderNicknameCtr.text,
            seaId: seasonVal!.seaId,
            speId: specialtyVal!.speId,
          ),
          statusRequest2 = handlingData(response);
      print(statusRequest2);
      if (statusRequest2 == StatusRequest.success) {
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
    Get.find<FoldersCtr>().foldersList.clear();
    Get.find<FoldersCtr>().getData();
    print('we did it');
  }
}
