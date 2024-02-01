import 'package:get/get.dart';

import '../../core/calsses/StatusRequest.dart';
import '../../core/calsses/services.dart';

abstract class DownlodedFilesCtrAbs extends GetxController {}

class DownlodedFilesCtr extends DownlodedFilesCtrAbs {
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();

  List downloadedFileList = [];
  @override
  void onInit() {
    super.onInit();
    // myServices.box.remove('downloadPaths');
    downloadedFileList = myServices.box.read('downloadPaths') ?? [];
    update();
  }
}
