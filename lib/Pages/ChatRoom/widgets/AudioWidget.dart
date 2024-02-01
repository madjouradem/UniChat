import 'package:flutter/material.dart';
import 'package:flutter_chatapp/core/calsses/AudioPlayerCtr.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/constant/AppColor.dart';
import '../../../core/constant/AppLinkes.dart';
import '../../../core/functions/crypte.dart';
import '../../../data/models/privateMessagesModel.dart';
import '../chatroomController.dart';

class AudioWidget extends StatelessWidget {
  const AudioWidget({
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
            if (controller.messagesList[index].mesFromId !=
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
                                  type: message.mesType);
                            },
                          ),
                        ];
                      },
                    )
                  : Container(),
            Container(
              height: 45.h,
              width: 230.w,
              margin: EdgeInsets.all(5.spMin),
              padding: EdgeInsets.all(5.spMin),
              // decoration: BoxDecoration(
              //   color: message.mesFromId !=
              //           controller.myServices.box.read('user')['user_id']
              //       ? AppColor.primaryC1
              //       : AppColor.primaryC1WithOpacity2,
              //   borderRadius: BorderRadius.circular(10.r),
              // ),
              child: GetBuilder<AudioPlayerCtr>(
                  autoRemove: false,
                  init: AudioPlayerCtr(
                      "${AppLink.upload}Conversations/${controller.convFile}/${decodeString(message.mesContent)}"),
                  tag: message.mesContent,
                  builder: (ctr) {
                    return SizedBox(
                      height: 80.spMin,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              height: 50.spMin,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  color: AppColor.primaryC1WithOpacity2,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        if (ctr.isPlaying) {
                                          ctr.audioPlayer.pause();
                                        } else {
                                          ctr.audioPlayer.resume();
                                        }
                                      },
                                      child: Icon(ctr.isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow)),
                                  Expanded(
                                    child: Slider(
                                      min: 0.0,
                                      activeColor: AppColor.primaryC1,
                                      max: ctr.duration.inSeconds.toDouble(),
                                      onChanged: (value) async {
                                        ctr.position =
                                            Duration(seconds: value.toInt());
                                        await ctr.audioPlayer
                                            .seek(ctr.position);
                                        ctr.update();
                                      },
                                      value: ctr.position.inSeconds.toDouble(),
                                    ),
                                  ),
                                  Text(ctr.formatTime(ctr.position)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            if (controller.messagesList[index].mesFromId ==
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
                              child: Text('Download'),
                            ),
                            onTap: () {
                              print(
                                  "${AppLink.upload}Conversations/${controller.convFile}/${decodeString(message.mesContent)}");
                              controller.downloadFile(
                                "${AppLink.upload}Conversations/${controller.convFile}/${decodeString(message.mesContent)}",
                                '${decodeString(message.mesContent)}',
                                type: message.mesType,
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
