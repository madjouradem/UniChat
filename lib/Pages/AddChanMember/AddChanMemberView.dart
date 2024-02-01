import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/AddChanMember/widgets/SelectedMembersWidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../CreateChannel/widgets/customButton.dart';
import 'AddChanMemberController.dart';

class AddChanMember extends GetView<AddChanMemberCtr> {
  const AddChanMember({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddChanMemberCtr());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          margin: EdgeInsets.all(8.spMin),
          child: const SelectedMembersWidget(),
        ),
        floatingActionButton: SizedBox(
          height: 60,
          width: 300,
          child: CustomButtom(
            text: 'Add membeer',
            onPressed: () {
              controller.onAddMember();
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
