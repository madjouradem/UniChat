import 'package:flutter/material.dart';
import 'package:flutter_chatapp/core/calsses/HandlingDataView.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/constant/AppColor.dart';
import '../../core/functions/validinput.dart';
import 'AddFoldersController.dart';
import 'widgets/CustomDropDownButton.dart';
import 'widgets/CustomTextFormField.dart';
import 'widgets/customButton.dart';

class AddFolders extends GetView<AddFoldersCtr> {
  const AddFolders({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddFoldersCtr());
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Folders'),
        backgroundColor: AppColor.primaryC1,
      ),
      body: GetBuilder<AddFoldersCtr>(builder: (context) {
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
                    tec: controller.folderNameCtr,
                    validator: (val) {
                      return validInput(val!, 2, 50, '');
                    },
                  ),
                  CustomTextFormField(
                    hintText: 'Nickename',
                    lableText: 'Nikename',
                    tec: controller.folderNicknameCtr,
                  ),
                  const CustomDropDownButton(),
                  CustomButtom(
                    text: 'Create',
                    onPressed: () {
                      controller.addFolder();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColor.primaryC1WithOpacity4,
        elevation: 0,
        child: Icon(
          Icons.add,
          color: AppColor.primaryC1,
          size: 40.spMin,
        ),
      ),
    ));
  }
}
