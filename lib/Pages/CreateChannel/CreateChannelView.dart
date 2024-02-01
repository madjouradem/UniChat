import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/CreateChannel/CreateChannelController.dart';
import 'package:flutter_chatapp/Pages/CreateChannel/widgets/CustomTextFormField.dart';
import 'package:flutter_chatapp/Pages/CreateChannel/widgets/SelectedMembersWidget.dart';
import 'package:flutter_chatapp/Pages/CreateChannel/widgets/customButton.dart';
import 'package:flutter_chatapp/core/constant/AppColor.dart';
import 'package:flutter_chatapp/core/functions/validinput.dart';
import 'package:get/get.dart';

class CreateChannel extends GetView<CreateChannelCtr> {
  const CreateChannel({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateChannelCtr());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create channel'),
          backgroundColor: AppColor.primaryC1,
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          child: GetBuilder<CreateChannelCtr>(builder: (_) {
            return ListView(
              //       shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              children: [
                Form(
                  key: controller.key,
                  child: CustomTextFormField(
                    hintText: 'channel Name',
                    lableText: 'channel Name',
                    tec: controller.channelname,
                    validator: (val) {
                      return validInput(val!, 2, 50, 'type');
                    },
                  ),
                ),
                const Divider(),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Availble for all"),
                      Switch(
                        value: controller.isAvailble,
                        onChanged: (value) {
                          controller.isAvailble = value;
                          controller.update();
                        },
                      ),
                    ],
                  ),
                ),
                controller.isAvailble
                    ? Container()
                    : const SelectedMembersWidget(),
              ],
            );
          }),
        ),
        floatingActionButton: SizedBox(
          height: 60,
          width: 300,
          child: CustomButtom(
            text: 'Create Channel',
            onPressed: () {
              controller.onCreateChannel();
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
