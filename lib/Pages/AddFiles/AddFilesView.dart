import 'package:flutter/material.dart';
import 'package:flutter_chatapp/core/calsses/HandlingDataView.dart';
import 'package:get/get.dart';

import '../../core/constant/AppColor.dart';
import '../../core/functions/validinput.dart';
import 'AddFilesController.dart';
import 'widgets/CustomTextFormField.dart';
import 'widgets/customButton.dart';

class AddFiles extends GetView<AddFilesCtr> {
  const AddFiles({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddFilesCtr());
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add File'),
        backgroundColor: AppColor.primaryC1,
      ),
      body: GetBuilder<AddFilesCtr>(builder: (context) {
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
                  GetBuilder<AddFilesCtr>(builder: (_) {
                    return CustomButtom(
                      text: 'pick file',
                      color: controller.result == null
                          ? AppColor.primaryC1WithOpacity4
                          : AppColor.primaryC1,
                      onPressed: () {
                        controller.pickFile();
                      },
                    );
                  }),

                  //uoploadFile
                  CustomButtom(
                    text: 'Save',
                    onPressed: () {
                      controller.addFile();
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
