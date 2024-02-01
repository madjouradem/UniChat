import 'package:flutter/material.dart';

import '../../../core/constant/AppColor.dart';

class CustomButtom extends StatelessWidget {
  final String text;
  final Color? color;
  final void Function()? onPressed;
  const CustomButtom({
    Key? key,
    required this.text,
    this.color = AppColor.primaryC1,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(vertical: 13),
        onPressed: onPressed,
        color: color,
        textColor: Colors.white,
        child: Text(text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }
}
