import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_chatapp/Pages/Main/mainController.dart';
import 'package:flutter_chatapp/core/functions/handlingData.dart';
import 'package:flutter_chatapp/core/functions/showAlert.dart';
import 'package:flutter_chatapp/data/models/GroupsModel.dart';
import 'package:flutter_chatapp/data/models/SeasonModel.dart';
import 'package:flutter_chatapp/data/models/SpecialtyModel.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/calsses/StatusRequest.dart';
import '../../core/calsses/services.dart';
import '../../core/functions/alertWaiting.dart';
import 'CreateWSData.dart';

abstract class CreateWSCtrAbs extends GetxController {
  onChangeGroup(value);
  onChangeSea(value);
  onChangeSpe(value);
  getData();
  createWS();
  refreshData();
  uploadFile();
}

class CreateWSCtr extends CreateWSCtrAbs {
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequest2 = StatusRequest.none;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  CreateWSData createWSData = CreateWSData();
  MyServices myServices = Get.find();
  List<GroupsModel> groupsList = [];
  List<SeasonModel> seasonList = [];
  List<SpecialtyModel> specialtyList = [];
  GroupsModel? groupVal;
  SpecialtyModel? specialtyVal;
  SeasonModel? seasonVal;
  String? radioValue = '';
  TextEditingController wsNameCtr = TextEditingController();
  TextEditingController wsDescCtr = TextEditingController();
  String filename = '';

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  @override
  onChangeGroup(value) {
    groupVal = value;
    update();
  }

  @override
  onChangeSpe(value) {
    specialtyVal = value;
    update();
  }

  @override
  onChangeSea(value) {
    seasonVal = value;
    update();
  }

  @override
  getData() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await createWSData.getData();
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        response['data']['groups'].forEach((element) {
          groupsList.add(GroupsModel.fromJson(element));
        });
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

  @override
  createWS() async {
    if (key.currentState!.validate()) {
      // await uploadFile();

      if (seasonVal == null || groupVal == null || specialtyVal == null) {
        showAlert(title: '', content: 'Please select all rows');
        return;
      }
      alertWaiting();
      var response = await createWSData.addWS(
        wsName: wsNameCtr.text,
        wsDesc: wsDescCtr.text,
        wsImage: radioValue,
        wsSpe: specialtyVal!.speId,
        wsGroup: groupVal!.groId,
        wsSea: seasonVal!.seaId,
        wsProfId: myServices.box.read('user')['user_id'],
      );
      print('================================================$filename');
      statusRequest2 = handlingData(response);
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

  chooseImage(String? value) {
    radioValue = value;
    update();
  }

  @override
  refreshData() {
    Get.find<MainCtr>().workspaceList.clear();
    Get.find<MainCtr>().conversationsList.clear();
    Get.find<MainCtr>().getData();
    print('we did it');
  }

  @override
  uploadFile() async {
    filename = wsNameCtr.text;
    final directory = await getTemporaryDirectory();
    final file = await File('${directory.path}/$filename').create();
    var response = await createWSData.uploadfile(file);
    StatusRequest status = handlingData(response);
    if (StatusRequest.success == status) {
      if (response['status'] == 'success') {
        filename = response['name'];
      }
    }
    file.delete();
  }
}
