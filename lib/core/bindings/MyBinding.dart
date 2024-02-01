import 'package:get/get.dart';

import '../calsses/webSocketConn.dart';

class MyBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(WebSocketConn(), permanent: true);
  }
}
