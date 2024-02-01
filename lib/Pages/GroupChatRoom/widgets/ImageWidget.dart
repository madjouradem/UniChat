import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/constant/AppColor.dart';
import '../../../core/constant/AppLinkes.dart';
import '../../../core/constant/AppRoute.dart';
import '../../../core/functions/crypte.dart';
import '../../../data/models/GroupMessages.dart';
import '../GroupchatroomController.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.controller,
    required this.message,
    required this.index,
  });

  final GroupchatroomCtr controller;
  final GroupMessages message;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: message.mesSenderId !=
              controller.myServices.box.read('user')['user_id']
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: message.mesSenderId !=
                  controller.myServices.box.read('user')['user_id']
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (controller.messagesList[index].mesSenderId !=
                controller.myServices.box.read('user')['user_id'])
              controller.messIndex == index
                  ? PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: const InkWell(
                              child: Text('remove for you'),
                            ),
                            onTap: () {
                              controller.removeMessageForYou(message);
                            },
                          ),
                          PopupMenuItem(
                            child: const InkWell(
                              child: Text('Download'),
                            ),
                            onTap: () {
                              controller.downloadFile(
                                  "${AppLink.upload}${controller.channelCtr.wsFile}/${controller.channelInfo.chanFile}/${decodeString(message.mesContent)}",
                                  '${decodeString(message.mesContent)}',
                                  type: '');
                            },
                          ),
                        ];
                      },
                    )
                  : Container(),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoute.imageViwer, arguments: {
                  'image': Image.network(
                    "${AppLink.upload}${controller.channelCtr.wsFile}/${controller.channelInfo.chanFile}/${decodeString(message.mesContent)}",
                  ),
                });
              },
              child: Container(
                width: 270.spMin,
                padding: const EdgeInsets.all(5),
                margin: EdgeInsets.only(
                    bottom: 8.spMin,
                    left: message.mesSenderId !=
                            controller.myServices.box.read('user')['user_id']
                        ? 8.spMin
                        : controller.messIndex == index
                            ? 60.spMin
                            : 100.spMin,
                    right: message.mesSenderId !=
                            controller.myServices.box.read('user')['user_id']
                        ? controller.messIndex == index
                            ? 60.spMin
                            : 100.spMin
                        : 8.spMin,
                    top: 8.spMin),
                decoration: BoxDecoration(
                    color: message.mesSenderId !=
                            controller.myServices.box.read('user')['user_id']
                        ? AppColor.primaryC1
                        : AppColor.primaryC1WithOpacity2,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Container(
                  margin: EdgeInsets.all(5.spMin),
                  child: Image.network(
                    "${AppLink.upload}${controller.channelCtr.wsFile}/${controller.channelInfo.chanFile}/${decodeString(message.mesContent)}",
                    // placeholder: (context, url) =>
                    //     const CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
            if (controller.messagesList[index].mesSenderId ==
                controller.myServices.box.read('user')['user_id'])
              controller.messIndex == index
                  ? PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: const InkWell(
                              child: Text('remove for you'),
                            ),
                            onTap: () {
                              controller.removeMessageForYou(message);
                            },
                          ),
                          if (controller.messagesList[index].mesSenderId ==
                              controller.myServices.box.read('user')['user_id'])
                            PopupMenuItem(
                              child: const InkWell(
                                child: Text('remove for all'),
                              ),
                              onTap: () {
                                controller.removeMessageForAll(message);
                              },
                            ),
                          PopupMenuItem(
                            child: const InkWell(
                              child: Text('Download'),
                            ),
                            onTap: () {
                              controller.downloadFile(
                                  "${AppLink.upload}${controller.channelCtr.wsFile}/${controller.channelInfo.chanFile}/${decodeString(message.mesContent)}",
                                  '${decodeString(message.mesContent)}',
                                  type: '');
                            },
                          ),
                        ];
                      },
                    )
                  : Container(),
          ],
        )
      ],
    );
  }
}
