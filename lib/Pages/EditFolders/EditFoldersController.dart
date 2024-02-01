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
import 'EditFoldersData.dart';

abstract class EditFoldersCtrAbs extends GetxController {
  getData();
  goToFiles(String folderId);
  editFolder();
  refreshData();
}

class EditFoldersCtr extends EditFoldersCtrAbs {
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequest2 = StatusRequest.none;
  EditFoldersData editfoldersData = EditFoldersData();
  MyServices myServices = Get.find();
  List<FoldersModel> foldersList = [];
  SpecialtyModel? specialtyVal;
  SeasonModel? seasonVal;
  String? specialtyId = '';
  String? seasonId = '';
  String specialtyName = '';

  String seasonName = '';

  GlobalKey<FormState> key = GlobalKey<FormState>();
  List<SeasonModel> seasonList = [];
  List<SpecialtyModel> specialtyList = [];
  TextEditingController folderNameCtr = TextEditingController();
  TextEditingController folderNicknameCtr = TextEditingController();
  late FoldersModel folderInfo;

  @override
  void onInit() {
    folderInfo = Get.arguments['folderInfo'];
    folderNameCtr.text = folderInfo.folderName!;
    folderNicknameCtr.text = folderInfo.folderCutName!;
    seasonId = folderInfo.folderSeaId;
    specialtyId = folderInfo.folderSpeId!;
    getData();
    super.onInit();
  }

  @override
  getData() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await editfoldersData.getData();
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        response['data']['sea'].forEach((element) {
          seasonList.add(SeasonModel.fromJson(element));
          if (seasonId == element['sea_id']) {
            seasonName = element['sea_name'];
          }
        });
        response['data']['spe'].forEach((element) {
          specialtyList.add(SpecialtyModel.fromJson(element));
          if (specialtyId == element['spe_id']) {
            specialtyName = element['spe_name'];
          }
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
    var response = await editfoldersData.getData();
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
  editFolder() async {
    if (key.currentState!.validate()) {
      // await uploadFile();
      alertWaiting();
      var response = await editfoldersData.editFolder(
            folderId: folderInfo.folderId!,
            name: folderNameCtr.text,
            nickname: folderNicknameCtr.text,
            speId: specialtyVal == null ? specialtyId : specialtyVal!.speId,
            seaId: seasonVal == null ? seasonId : seasonVal!.seaId,
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
