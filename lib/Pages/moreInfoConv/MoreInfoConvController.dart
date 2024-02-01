import 'package:get/get.dart';

import '../../core/calsses/StatusRequest.dart';
import '../../core/calsses/services.dart';

abstract class MoreInfoConvCtrAbs extends GetxController {}

class MoreInfoConvCtr extends MoreInfoConvCtrAbs {
  StatusRequest statusRequest = StatusRequest.none;
  // MoreInfoConvData Data = MoreInfoConvData();
  MyServices myServices = Get.find();
  late String userName;
  late String userImage;

  @override
  void onInit() {
    super.onInit();
    userName = Get.arguments['userName'];
    userImage = Get.arguments['userImage'];
  }
}
