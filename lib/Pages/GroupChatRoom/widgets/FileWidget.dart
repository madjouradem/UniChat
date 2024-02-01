import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/calsses/DownloadCtr.dart';
import '../../../core/constant/AppColor.dart';
import '../../../core/constant/AppImage.dart';
import '../../../core/constant/AppLinkes.dart';
import '../../../core/functions/crypte.dart';
import '../../../data/models/GroupMessages.dart';
import '../GroupchatroomController.dart';

class FileWidget extends StatelessWidget {
  const FileWidget({
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
            if (message.mesSenderId !=
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
                                  type: message.mesType);
                            },
                          ),
                        ];
                      },
                    )
                  : Container(),
            GestureDetector(
              onTap: () {
                FileCtr fileCtr = Get.put(FileCtr());
                fileCtr.openFile(
                    "${controller.channelCtr.wsFile}/${controller.channelInfo.chanFile}/${decodeString(message.mesContent)}");
              },
              child: Container(
                height: 55.h,
                width: 230.w,
                margin: EdgeInsets.all(5.spMin),
                padding: EdgeInsets.all(5.spMin),
                decoration: BoxDecoration(
                    color: message.mesSenderId !=
                            controller.myServices.box.read('user')['user_id']
                        ? AppColor.primaryC1
                        : AppColor.primaryC1WithOpacity2,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10.spMin),
                      height: 55.spMin,
                      width: 55.spMin,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: SvgPicture.asset(
                        AppImage.file,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        decodeString(message.mesContent),
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (message.mesSenderId ==
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
                          if (message.mesSenderId ==
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
                                  type: message.mesType);
                            },
                          ),
                        ];
                      },
                    )
                  : Container(),
          ],
        ),
      ],
    );
  }
}
