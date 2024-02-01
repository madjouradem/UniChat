import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/AppImage.dart';

class LogoAuth extends StatelessWidget {
  const LogoAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.spMin, bottom: 20.spMin),
      height: 200.spMin,
      child: Image.asset(
        AppImage.logo,
      ),
    );
  }
}
