import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/GroupChatRoom/GroupchatroomController.dart';
import 'package:flutter_chatapp/Pages/GroupChatRoom/widgets/AudioWidget.dart';
import 'package:flutter_chatapp/core/calsses/DefaultAvater/DefaultAvater.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../../../core/constant/AppColor.dart';
import 'FileWidget.dart';
import 'ImageWidget.dart';
import 'LinkWidget.dart';
import 'MessageTimeWidget.dart';
import 'TextWidget.dart';
import 'VideoWidget.dart';

class HandlingGroupMessages extends GetView<GroupchatroomCtr> {
  const HandlingGroupMessages({super.key});

  @override
  Widget build(BuildContext context) {
    // GroupchatroomCtr controller = Get.put<GroupchatroomCtr>(GroupchatroomCtr());
    return GetBuilder<GroupchatroomCtr>(builder: (_) {
      return ListView.separated(
          separatorBuilder: (context, index) {
            if (index != controller.messagesList.length - 1) {
              return (DateTime.parse(
                              controller.messagesList[index].mesCreateTime!)
                          .difference(DateTime.parse(controller
                                  .messagesList[index + 1].mesCreateTime!)
                              .toUtc()) >=
                      const Duration(days: 1))
                  // ||
                  // (DateTime.parse(controller.messagesList[index].mesCreateTime!)
                  //             .toUtc()
                  //             .day -
                  //         DateTime.parse(controller.messagesList[index + 1].mesCreateTime!)
                  //             .day >=
                  //     1)
                  ? Center(
                      child: Text(Jiffy.parse(
                              controller.messagesList[index].mesCreateTime!)
                          .yMMMMEEEEdjm))
                  : const Text('');
            } else {
              return Container();
            }
          },
          reverse: true,
          controller: controller.scrollController,
          itemCount: controller.messagesList.length + 1,
          itemBuilder: (context, index) {
            if (index == controller.messagesList.length) {
              return controller.getMessageslength >=
                      controller.maxMessageslength
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primaryC1,
                      ),
                    )
                  : Container();
            }
            return GestureDetector(
              onLongPress: () {
                controller.onTapMessage(index);
              },
              child: Container(
                alignment: controller.messagesList[index].mesSenderId !=
                        controller.myServices.box.read('user')['user_id']
                    ? Alignment.topLeft
                    : Alignment.topRight,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: controller
                                .messagesList[index].mesSenderId !=
                            controller.myServices.box.read('user')['user_id']
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      //sender name and image
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.spMin),
                        child: Row(
                          mainAxisAlignment:
                              controller.messagesList[index].mesSenderId !=
                                      controller.myServices.box
                                          .read('user')['user_id']
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.end,
                          children: [
                            controller.messagesList[index].mesSenderId ==
                                    controller.myServices.box
                                        .read('user')['user_id']
                                ? Container()
                                : Row(
                                    children: [
                                      DefaultAvater(
                                          height: 40.spMin,
                                          width: 40.spMin,
                                          name: controller
                                              .messagesList[index].userName![0],
                                          image: controller
                                              .messagesList[index].userAvatar),
                                      SizedBox(width: 8.spMin),
                                    ],
                                  ),
                            Text(
                              controller.messagesList[index].userName!,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            controller.messagesList[index].mesSenderId !=
                                    controller.myServices.box
                                        .read('user')['user_id']
                                ? Container()
                                : Row(
                                    children: [
                                      SizedBox(width: 8.spMin),
                                      DefaultAvater(
                                          height: 40.spMin,
                                          width: 40.spMin,
                                          name: controller
                                              .messagesList[index].userName![0],
                                          image: controller
                                              .messagesList[index].userAvatar),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                      //for Type image
                      controller.messagesList[index].mesType == 'image'
                          ? ImageWidget(
                              controller: controller,
                              message: controller.messagesList[index],
                              index: index,
                            )
                          : controller.messagesList[index].mesType == 'video'
                              ? VideoWidget(
                                  controller: controller,
                                  message: controller.messagesList[index],
                                  index: index)
                              :
                              // for Type file
                              controller.messagesList[index].mesType == 'file'
                                  ? FileWidget(
                                      controller: controller,
                                      message: controller.messagesList[index],
                                      index: index)
                                  : controller.messagesList[index].mesType ==
                                          'link'
                                      ?
                                      // for Type Link
                                      LinkWidget(
                                          controller: controller,
                                          message:
                                              controller.messagesList[index],
                                          index: index)
                                      : controller.messagesList[index]
                                                  .mesType ==
                                              'audio'
                                          ?
                                          //for audio
                                          AudioWidget(
                                              controller: controller,
                                              message: controller
                                                  .messagesList[index],
                                              index: index)
                                          :
                                          //For type Text
                                          TextWidget(
                                              controller: controller,
                                              message: controller
                                                  .messagesList[index],
                                              index: index,
                                            ),

                      controller.messIndex == index
                          ? MessageTimeWidget(
                              controller: controller,
                              message: controller.messagesList[index],
                              index: index)
                          : Container()
                    ]),
              ),
            );
          });
    });
  }
}
