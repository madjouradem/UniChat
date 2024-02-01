import 'package:get/get.dart';

import '../../Pages/Main/mainController.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MainCtr(), permanent: true);
  }
}
