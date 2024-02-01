import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/EditChannel/EditChannelController.dart';
import 'package:flutter_chatapp/Pages/EditChannel/widgets/CustomTextFormField.dart';
import 'package:flutter_chatapp/Pages/EditChannel/widgets/customButton.dart';
import 'package:flutter_chatapp/core/constant/AppColor.dart';
import 'package:flutter_chatapp/core/functions/validinput.dart';
import 'package:get/get.dart';

class EditChannel extends GetView<EditChannelCtr> {
  const EditChannel({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EditChannelCtr());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit channel'),
          backgroundColor: AppColor.primaryC1,
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          child: GetBuilder<EditChannelCtr>(builder: (_) {
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
              ],
            );
          }),
        ),
        floatingActionButton: SizedBox(
          height: 60,
          width: 300,
          child: CustomButtom(
            text: 'Save',
            onPressed: () {
              controller.onEditChannel();
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
