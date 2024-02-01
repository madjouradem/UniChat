import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/Login/LogInController.dart';
import 'package:flutter_chatapp/Pages/Login/widgets/customTextFormField.dart';
import 'package:flutter_chatapp/Pages/Login/widgets/logoauth.dart';
import 'package:flutter_chatapp/core/constant/AppColor.dart';
import 'package:flutter_chatapp/core/functions/validinput.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'widgets/customButton.dart';

class LogIn extends GetView<LogInCtr> {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LogInCtr());
    return Scaffold(
      // appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.all(6),
        height: double.infinity,
        width: double.infinity,
        child: Form(
          key: controller.key,
          child: ListView(
            children: [
              const LogoAuth(),
              Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Uni Chat',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: AppColor.primaryC1),
                  )),
              SizedBox(height: 50.h),
              CustomTextFormField(
                controller: controller.emailctr,
                validator: (val) {
                  return validInput(val!, 2, 30, "email");
                },
                hintText: 'Ex:202039001212 or Email',
                labelText: 'Email',
              ),
              CustomTextFormField(
                controller: controller.passwordctr,
                validator: (val) {
                  return validInput(val!, 2, 30, "password");
                },
                hintText: 'Password',
                labelText: 'Password',
              ),
              CustomButtom(
                text: 'LogIn',
                onPressed: () {
                  controller.login();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
