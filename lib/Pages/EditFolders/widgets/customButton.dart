import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/AppColor.dart';

class CustomButtom extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const CustomButtom({Key? key, required this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.spMin, left: 40.spMin, right: 40.spMin),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.spMin)),
        padding: EdgeInsets.symmetric(vertical: 13.spMin),
        onPressed: onPressed,
        color: AppColor.primaryC1,
        textColor: Colors.white,
        child: Text(text, style: Theme.of(context).textTheme.displayLarge),
      ),
    );
  }
}
