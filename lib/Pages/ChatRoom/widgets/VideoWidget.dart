import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constant/AppColor.dart';
import '../../../core/constant/AppLinkes.dart';
import '../../../core/functions/crypte.dart';
import '../../../data/models/privateMessagesModel.dart';
import '../chatroomController.dart';
import 'VideoPlayerWidget.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget({
    super.key,
    required this.controller,
    required this.message,
    required this.index,
  });

  final ChatroomCtr controller;
  final privateMessagesModel message;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          message.mesFromId != controller.myServices.box.read('user')['user_id']
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: message.mesFromId !=
                  controller.myServices.box.read('user')['user_id']
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (message.mesFromId !=
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
                                  "${AppLink.upload}Conversations/${controller.convFile}/${decodeString(message.mesContent)}",
                                  '${decodeString(message.mesContent)}',
                                  type: '');
                            },
                          ),
                        ];
                      },
                    )
                  : Container(),
            Container(
              width: 270.spMin,
              margin: EdgeInsets.only(
                  bottom: 8.spMin,
                  left: message.mesFromId !=
                          controller.myServices.box.read('user')['user_id']
                      ? 8.spMin
                      : controller.messIndex == index
                          ? 60.spMin
                          : 100.spMin,
                  right: message.mesFromId !=
                          controller.myServices.box.read('user')['user_id']
                      ? controller.messIndex == index
                          ? 60.spMin
                          : 100.spMin
                      : 8.spMin,
                  top: 8.spMin),
              padding: EdgeInsets.all(6.r),
              decoration: BoxDecoration(
                  color: message.mesFromId !=
                          controller.myServices.box.read('user')['user_id']
                      ? AppColor.primaryC1
                      : AppColor.primaryC1WithOpacity2,
                  borderRadius: BorderRadius.circular(10.r)),
              child: VideoPlayerWidget(
                key: GlobalKey(),
                videoname:
                    "Conversations/${controller.convFile}/${decodeString(message.mesContent)}",
              ),
            ),
            if (message.mesFromId ==
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
                              child: Text('remove for all'),
                            ),
                            onTap: () {
                              controller.removeMessageForAll(message);
                            },
                          ),
                          PopupMenuItem(
                            child: const InkWell(
                              child: Row(
                                children: [
                                  Text('Download'),
                                  Icon(Icons.download_done)
                                ],
                              ),
                            ),
                            onTap: () {
                              controller.downloadFile(
                                "${AppLink.upload}Conversations/${controller.convFile}/${decodeString(message.mesContent)}",
                                '${decodeString(message.mesContent)}',
                                type: '',
                              );
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
