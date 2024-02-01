import 'package:flutter/widgets.dart';
import 'package:flutter_chatapp/Pages/Main/mainController.dart';
import 'package:flutter_chatapp/core/functions/handlingData.dart';
import 'package:flutter_chatapp/core/functions/showAlert.dart';
import 'package:flutter_chatapp/data/models/GroupsModel.dart';
import 'package:flutter_chatapp/data/models/SeasonModel.dart';
import 'package:flutter_chatapp/data/models/SpecialtyModel.dart';
import 'package:get/get.dart';
import '../../core/calsses/StatusRequest.dart';
import '../../core/calsses/services.dart';
import '../../core/functions/alertWaiting.dart';
import '../EditWS/EditWSData.dart';

abstract class EditWSCtrAbs extends GetxController {
  onChangeGroup(value);
  onChangeSea(value);
  onChangeSpe(value);
  getData();
  editWS();
  refreshData();
}

class EditWSCtr extends EditWSCtrAbs {
  StatusRequest statusRequest = StatusRequest.none;
  StatusRequest statusRequest2 = StatusRequest.none;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  EditWSData editWSData = EditWSData();
  MyServices myServices = Get.find();
  List<GroupsModel> groupsList = [];
  List<SeasonModel> seasonList = [];
  List<SpecialtyModel> specialtyList = [];
  SpecialtyModel? specialtyVal;
  GroupsModel? groupVal;
  SeasonModel? seasonVal;
  String? specialtyId;
  String? groupId;
  String? seasonId;
  String specialtyName = '';
  String groupName = '';
  String seasonName = '';
  String? radioValue = '';
  TextEditingController wsNameCtr = TextEditingController();
  TextEditingController wsDescCtr = TextEditingController();
  late String wsId;

  @override
  void onInit() {
    wsId = Get.arguments['ws_id'];
    wsNameCtr.text = Get.arguments['ws_name'];
    wsDescCtr.text = Get.arguments['ws_desc'];
    groupId = Get.arguments['ws_gro_id'];
    seasonId = Get.arguments['ws_sea_id'];
    specialtyId = Get.arguments['ws_spe_id'];
    radioValue = Get.arguments['ws_image'];
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
    var response = await editWSData.getData();
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        response['data']['groups'].forEach((element) {
          groupsList.add(GroupsModel.fromJson(element));
          if (groupId == element['gro_id']) {
            groupName = element['gro_name'];
          }
        });
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

  @override
  editWS() async {
    if (key.currentState!.validate()) {
      alertWaiting();
      var response = await editWSData.editWS(
        wsId: wsId,
        wsName: wsNameCtr.text,
        wsDesc: wsDescCtr.text,
        wsImage: radioValue,
        wsSpe: specialtyVal == null ? specialtyId : specialtyVal!.speId,
        wsGroup: groupVal == null ? groupId : groupVal!.groId,
        wsSea: seasonVal == null ? seasonId : seasonVal!.seaId,
      );
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
}
