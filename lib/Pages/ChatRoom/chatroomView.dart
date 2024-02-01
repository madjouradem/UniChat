import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/ChatRoom/chatroomController.dart';
import 'package:flutter_chatapp/core/calsses/AudioRecorderWidget.dart';
import 'package:flutter_chatapp/core/constant/AppImage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../core/constant/AppColor.dart';
import 'widgets/HandlingMessages.dart';

class ChatRoom extends GetView<ChatroomCtr> {
  const ChatRoom({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChatroomCtr());
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 234, 234, 189),
      appBar: AppBar(
        // foregroundColor: Colors.transparent,
        backgroundColor: AppColor.primaryC1,
        title: Row(
          children: [
            controller.userImage != null
                ? CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      controller.userImage!,
                    ),
                  )
                : Container(),
            SizedBox(width: 10.spMin),
            Text(
              controller.userName.split(' ').first,
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
        actions: [
          // GetBuilder<UploadCtr>(
          //     init: UploadCtr(),
          //     builder: (ctr) {
          //       return ctr.progress != 0.0 && ctr.progress != 1.0
          //           ? Center(
          //               child: GestureDetector(
          //                 onTap: () {},
          //                 child: Stack(
          //                   children: [
          //                     CircularProgressIndicator(
          //                       color: AppColor.appBarIconColor,
          //                       value: ctr.progress,
          //                     ),
          //                     const Positioned(
          //                       top: 5,
          //                       left: 5,
          //                       child: Icon(
          //                         Icons.upload_outlined,
          //                         color: AppColor.appBarIconColor,
          //                       ),
          //                     )
          //                   ],
          //                 ),
          //               ),
          //             )
          //           : Container();
          //     }),
          IconButton(
              onPressed: () {
                controller.goToMoreInfo();
              },
              icon: const Icon(
                Icons.info_outline,
                color: AppColor.appBarIconColor,
              ))
        ],
      ),

      body: const SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: HandlingMessages(),
      ),
      bottomNavigationBar: SendMessageWidget(controller: controller),
    );
  }
}

class SendMessageWidget extends StatelessWidget {
  const SendMessageWidget({
    super.key,
    required this.controller,
  });

  final ChatroomCtr controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.spMin,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.black, offset: Offset(0, 10), blurRadius: 15)
          ]),
      width: double.infinity,
      // margin: const EdgeInsets.only(right: 5),
      // padding: const EdgeInsets.only(bottom: 8, right: 5, left: 5),
      alignment: Alignment.center,
      child: Row(
        children: [
          GetBuilder<ChatroomCtr>(
              // id: 'send Message',
              builder: (ctr) {
            return !ctr.isRecording
                ? Flexible(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      width: Get.width - 60,
                      child: Form(
                        key: controller.formState,
                        child: TextFormField(
                          textInputAction: TextInputAction.send,
                          controller: controller.tctr,
                          onFieldSubmitted: (_) {
                            Map data = {
                              'type': 'private',
                              'mes_conv_id': controller.convId,
                              'mes_from_id': controller.myServices.box
                                  .read('user')['user_id'],
                              'mes_to_id': controller.userId,
                              'mes_content':
                                  controller.encodeString(controller.tctr.text),
                              'mes_type': !GetUtils.isURL(controller.tctr.text)
                                  ? 'text'
                                  : 'link',
                            };

                            controller.sendMessage(data);
                            // ctr.sendNotifiy(controller.tctr.text, userName);
                            controller.tctr.clear();
                          },
                          enableInteractiveSelection: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColor.primaryC1WithOpacity2,
                            contentPadding: const EdgeInsets.all(10),
                            labelText: 'Send a message',
                            labelStyle: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(color: AppColor.primaryC1),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: AppColor.primaryC1,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: AppColor.primaryC1WithOpacity2,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: AppColor.primaryC1,
                                )),
                            suffixIcon: Container(
                              margin: const EdgeInsets.only(bottom: 4.0),
                              child: TextButton(
                                  key: controller.textButton,
                                  onPressed: () {
                                    Map data = {
                                      'type': 'private',
                                      'mes_conv_id': controller.convId,
                                      'mes_from_id': controller.myServices.box
                                          .read('user')['user_id'],
                                      'mes_to_id': controller.userId,
                                      'mes_content': controller
                                          .encodeString(controller.tctr.text),
                                      'mes_type':
                                          !GetUtils.isURL(controller.tctr.text)
                                              ? 'text'
                                              : 'link',
                                    };
                                    controller.sendMessage(data);
                                    // ctr.sendNotifiy(controller.tctr.text, userName);
                                    controller.tctr.clear();
                                  },
                                  child: SvgPicture.asset(AppImage.send)),
                            ),
                            prefixIcon: SizedBox(
                              width: 75,
                              child: Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child:
                                          SvgPicture.asset(AppImage.instagram),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await controller.pickImage();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: SvgPicture.asset(
                                          AppImage.attachcircle),
                                    ),
                                  ),
                                  Container(
                                    height: 30.spMin,
                                    width: 0.5.spMin,
                                    color: Colors.black,
                                  )
                                  // const Drawer()
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container();
          }),
          Container(
            // color: Colors.amberAccent,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 5),
            // margin: const EdgeInsets.only(left: 5),
            child: GestureDetector(
              onLongPressStart: (_) {
                controller.onRecord(true);
              },
              onLongPressEnd: (_) {
                controller.onRecord(false);
              },
              child: FutureBuilder(
                future: controller.generateTempPath(),
                builder: (BuildContext context, snap) {
                  return snap.hasData
                      ? AudioRecorderWidget(
                          path: snap.data!,
                          onSend: (soundFile) {
                            if (soundFile != null) {
                              controller.uploadAudio(soundFile);
                            }
                          },
                        )
                      : Container();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
