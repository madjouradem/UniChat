import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/CreateChannel/CreateChannelController.dart';
import 'package:get/get.dart';

import '../../../core/constant/AppColor.dart';

class SelectedMembersWidget extends GetView<CreateChannelCtr> {
  const SelectedMembersWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 40),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.primaryC1WithOpacity2,
          borderRadius: BorderRadius.circular(30),
        ),
        child: GetBuilder<CreateChannelCtr>(builder: (_) {
          return ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              CheckboxListTile(
                title: const Text('Select All'),
                value: controller.selectedAll,
                onChanged: (value) {
                  controller.onSelectedAll(value!);
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.usersList.length,
                itemBuilder: (context, index) {
                  return controller.usersList[index].userId !=
                          controller.myServices.box.read('user')['user_id']
                      ? Container(
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
                          child: CheckboxListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 5),
                            tileColor: AppColor.primaryC1WithOpacity4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.all(5),
                                    child: const CircleAvatar()),
                                Text(controller.usersList[index].userName!),
                              ],
                            ),
                            value: controller.usersList[index].isChoosed,
                            onChanged: (value) {
                              controller.usersList[index].isChoosed = value;
                              if (value!) {
                                controller.membersList
                                    .add(controller.usersList[index].userId);
                              } else {
                                controller.membersList
                                    .remove(controller.usersList[index].userId);
                              }
                              print(controller.membersList);
                              controller.update();
                            },
                          ),
                        )
                      : Container();
                },
              ),
            ],
          );
        }));
  }
}
