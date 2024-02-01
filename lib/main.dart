import 'package:flutter/material.dart';
import 'package:flutter_chatapp/core/calsses/services.dart';
import 'package:flutter_chatapp/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'core/constant/style.dart';
import 'core/constant/theme services.dart';

// late GetStorage box;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MyServices myServices = Get.find();
    // myServices.box.remove('step');
    return ScreenUtilInit(
      builder: (context, _) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Themes.light,
          title: 'U-Chat',
          darkTheme: Themes.dark,
          themeMode: ThemeServices().theme,
          // initialBinding: MyBinding(),
          getPages: routes,
        );
      },
    );
  }
}
