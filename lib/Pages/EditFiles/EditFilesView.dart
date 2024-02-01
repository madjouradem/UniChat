import 'package:flutter/material.dart';
import 'package:flutter_chatapp/core/calsses/HandlingDataView.dart';
import 'package:get/get.dart';

import '../../core/constant/AppColor.dart';
import '../../core/functions/validinput.dart';
import 'EditFilesController.dart';
import 'widgets/CustomTextFormField.dart';
import 'widgets/customButton.dart';

class EditFiles extends GetView<EditFilesCtr> {
  const EditFiles({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EditFilesCtr());
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit file'),
        backgroundColor: AppColor.primaryC1,
      ),
      body: GetBuilder<EditFilesCtr>(builder: (context) {
        return HandlingDataView(
          statusRequest: controller.statusRequest,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            margin: const EdgeInsets.all(10),
            child: Form(
              key: controller.key,
              child: ListView(
                children: [
                  CustomTextFormField(
                    hintText: 'Name',
                    lableText: 'Name',
                    tec: controller.fileNameCtr,
                    validator: (val) {
                      return validInput(val!, 2, 50, '');
                    },
                  ),
                  CustomTextFormField(
                    hintText: 'Nickename',
                    lableText: 'Nikename (optional)',
                    tec: controller.fileNicknameCtr,
                  ),

                  //uoploadFile
                  CustomButtom(
                    text: 'Save',
                    onPressed: () {
                      controller.editFile();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    ));
  }
}
