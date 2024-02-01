import 'package:flutter/material.dart';
import 'package:flutter_chatapp/core/constant/AppImage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../core/calsses/DefaultAvater/DefaultAvater.dart';
import '../../../core/constant/AppColor.dart';
import '../CreateConversationController.dart';

class ConvCard extends GetView<CreateConversationCtr> {
  const ConvCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateConversationCtr>(builder: (_) {
      return ListView.builder(
        itemCount: controller.usersList.length,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 8.spMin),
          height: 60.h,
          width: double.infinity,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              alignment: Alignment.centerLeft,
              height: 50.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      DefaultAvater(
                          image: controller.usersList[index].userAvatar,
                          name: controller.usersList[index].userName![0],
                          userState: 'off'),
                      SizedBox(width: 10.w),
                      SizedBox(
                        width: 100,
                        child: Text(
                          controller.usersList[index].userName!,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ],
                  ),
                  controller.myServices.box.read('user')['user_id'] ==
                          controller.usersList[index].userId
                      ? const Text('(you)')
                      : Container(),
                  GestureDetector(
                    onTap: () {
                      controller.addConversation(
                          controller.usersList[index].userId!,
                          controller.usersList[index].userName!,
                          controller.usersList[index].userAvatar!);
                      // ConversationModel? conversationModel;
                      // //check if the conversation isExist
                      // for (int i = 0;
                      //     i < controller.mainCtr.conversationsList.length;
                      //     i++) {
                      //   if ('${controller.myServices.box.read('user')['user_id']}${controller.usersList[index].userId!}' ==
                      //           controller.mainCtr.conversationsList[i].id ||
                      //       '${controller.myServices.box.read('user')['user_id']}${controller.usersList[index].userId!}' ==
                      //           controller.mainCtr.conversationsList[i].id) {
                      //     conversationModel =
                      //         controller.mainCtr.conversationsList[i];
                      //     break;
                      //   }
                      // }
                      // if (conversationModel == null) {

                      //   Map data = {
                      //     'type': 'addConversation',
                      //     'userid1':
                      //         controller.myServices.box.read('user')['user_id'],
                      //     'userid2': controller.usersList[index].userId!,
                      //     'mes_type': 'text'
                      //   };
                      //   controller.sendMessage(data);
                      //   controller.gotoChatRoom(
                      //       userId: controller.usersList[index].userId!,
                      //       userName: controller.usersList[index].userName!);
                      //   controller
                      //       .readMessage(controller.usersList[index].userId!);
                      // }else{
                      //    controller.gotoChatRoom(
                      //       userId: controller.usersList[index].userId!,
                      //       userName: controller.usersList[index].userName!,

                      //       );
                      //   controller
                      //       .readMessage(controller.usersList[index].userId!);

                      // }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 8.spMin, horizontal: 20.spMin),
                      alignment: Alignment.center,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: AppColor.primaryC1WithOpacity4,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Lottie.asset(AppImage.hi),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
