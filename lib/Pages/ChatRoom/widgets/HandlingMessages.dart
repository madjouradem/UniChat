import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/ChatRoom/chatroomController.dart';
import 'package:flutter_chatapp/Pages/ChatRoom/widgets/AudioWidget.dart';
import 'package:flutter_chatapp/core/calsses/DefaultAvater/DefaultAvater.dart';
import 'package:flutter_chatapp/core/constant/AppColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'FileWidget.dart';
import 'ImageWidget.dart';
import 'LinkWidget.dart';
import 'MessageTimeWidget.dart';
import 'TextWidget.dart';
import 'VideoWidget.dart';

class HandlingMessages extends StatelessWidget {
  const HandlingMessages({super.key});

  @override
  Widget build(BuildContext context) {
    ChatroomCtr controller = Get.put<ChatroomCtr>(ChatroomCtr());

    return GetBuilder<ChatroomCtr>(builder: (context) {
      return ListView.separated(
          reverse: true,
          controller: controller.scrollController,
          separatorBuilder: (context, index) {
            bool cond = controller.messagesList[index].mesFromId! +
                        controller.messagesList[index].mesToId! ==
                    controller.userId +
                        controller.myServices.box.read('user')["user_id"] ||
                controller.messagesList[index].mesFromId! +
                        controller.messagesList[index].mesToId! ==
                    controller.myServices.box.read('user')["user_id"] +
                        controller.userId;
            if (index != controller.messagesList.length - 1) {
              return cond
                  ? (DateTime.parse(
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
                      : const Text('')
                  : Container();
            } else {
              return Container();
            }
          },
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

            bool cond = controller.messagesList[index].mesFromId! +
                        controller.messagesList[index].mesToId! ==
                    controller.userId +
                        controller.myServices.box.read('user')["user_id"] ||
                controller.messagesList[index].mesFromId! +
                        controller.messagesList[index].mesToId! ==
                    controller.myServices.box.read('user')["user_id"] +
                        controller.userId;

            // print('handling <==> <==>${controller.messagesList.length}');
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.spMin),
                  child: Row(
                    mainAxisAlignment: controller
                                .messagesList[index].mesFromId !=
                            controller.myServices.box.read('user')['user_id']
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    children: [
                      controller.messagesList[index].mesFromId ==
                              controller.myServices.box.read('user')['user_id']
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
                      controller.messagesList[index].mesFromId !=
                              controller.myServices.box.read('user')['user_id']
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
                cond
                    ? GestureDetector(
                        onLongPress: () {
                          controller.onTapMessage(index);
                        },
                        child: Container(
                          alignment: controller.messagesList[index].mesFromId !=
                                  controller.myServices.box
                                      .read('user')['user_id']
                              ? Alignment.topLeft
                              : Alignment.topRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              //for Type image
                              controller.messagesList[index].mesType == 'image'
                                  ? ImageWidget(
                                      controller: controller,
                                      message: controller.messagesList[index],
                                      index: index,
                                    )
                                  :
                                  //for type Video
                                  controller.messagesList[index].mesType ==
                                          'video'
                                      ? VideoWidget(
                                          controller: controller,
                                          message:
                                              controller.messagesList[index],
                                          index: index,
                                        )
                                      :
                                      // for Type file
                                      controller.messagesList[index].mesType ==
                                              'file'
                                          ? FileWidget(
                                              controller: controller,
                                              message: controller
                                                  .messagesList[index],
                                              index: index,
                                            )
                                          :
                                          //for links
                                          controller.messagesList[index]
                                                      .mesType ==
                                                  'link'
                                              ? LinkWidget(
                                                  controller: controller,
                                                  message: controller
                                                      .messagesList[index],
                                                  index: index,
                                                )
                                              : controller.messagesList[index]
                                                          .mesType ==
                                                      'audio'
                                                  ? AudioWidget(
                                                      controller: controller,
                                                      message: controller
                                                          .messagesList[index],
                                                      index: index,
                                                    )
                                                  :
                                                  // for text type
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
                                      index: index,
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ],
            );
          });
    });
  }
}
