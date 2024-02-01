import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyServices extends GetxService {
  late GetStorage box;
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  Future<MyServices> init() async {
    Firebase.initializeApp();
    await GetStorage.init();
    box = GetStorage();

    // await MobileAds.instance.initialize();

    // AndroidInitializationSettings initializationSettingsAndroid =
    //     const AndroidInitializationSettings('@mipmap/ic_launcher');
    // InitializationSettings initializationSettings =
    //     InitializationSettings(android: initializationSettingsAndroid);
    // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //     onDidReceiveNotificationResponse:
    //         (NotificationResponse? notificationResponse) async {
    //   print('payload ${notificationResponse!.payload}');
    //   if (notificationResponse.payload != null) {
    //     await OpenFile.open(notificationResponse.payload);
    //   }
    // });
    return this;
  }
}

initialServices() async {
  await Get.putAsync(
    () => MyServices().init(),
  );
}
