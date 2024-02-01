import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/Channels/ChannelController.dart';
import 'package:flutter_chatapp/Pages/GroupChatRoom/widgets/HandlingGroupMessages.dart';
import 'package:flutter_chatapp/core/calsses/Statusmember.dart';
import 'package:flutter_chatapp/core/constant/AppColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../core/calsses/AudioRecorderWidget.dart';
import '../../core/calsses/UploadCtr.dart';
import '../../core/constant/AppImage.dart';
import '../../core/functions/crypte.dart';
import 'GroupchatroomController.dart';

class Groupchatroom extends GetView<GroupchatroomCtr> {
  const Groupchatroom({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GroupchatroomCtr());
    Get.put(UploadCtr());
    return Scaffold(
        appBar: AppBar(
          // foregroundColor: Colors.transparent,
          backgroundColor: AppColor.primaryC1,
          title: Text(controller.channelInfo.chanName!),
          elevation: 0,
          shadowColor: Colors.transparent,
          centerTitle: true,
          actions: [
            GetBuilder<UploadCtr>(
                // init: UploadCtr(),
                builder: (ctr) {
              return ctr.progress != 0.0 && ctr.progress != 1.0
                  ? Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: Stack(
                          children: [
                            CircularProgressIndicator(
                              color: AppColor.appBarIconColor,
                              value: ctr.progress,
                            ),
                            const Positioned(
                              top: 5,
                              left: 5,
                              child: Icon(
                                Icons.upload_outlined,
                                color: AppColor.appBarIconColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : Container();
            }),
            GetBuilder<ChannelCtr>(builder: (ctr) {
              return ctr.statusmember != Statusmember.notJoin
                  ? IconButton(
                      onPressed: () {
                        controller.goToMoreInfo();
                      },
                      icon: const Icon(
                        Icons.info_outline,
                        color: AppColor.appBarIconColor,
                      ),
                    )
                  : Container();
            }),
          ],
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: GetBuilder<ChannelCtr>(
            autoRemove: true,
            builder: (ctr) {
              return ctr.statusmember != Statusmember.notJoin
                  ? const HandlingGroupMessages()
                  : Center(
                      child: Text(
                      'Join to see the content',
                      style: Theme.of(context).textTheme.displayMedium,
                    ));
            },
          ),
        ),
        bottomNavigationBar: GetBuilder<ChannelCtr>(
            autoRemove: true,
            builder: (ctr) {
              return ctr.statusmember != Statusmember.notJoin
                  ? Container(
                      height: 80.spMin,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                offset: Offset(0, 10),
                                blurRadius: 15)
                          ]),
                      width: double.infinity,
                      // margin: const EdgeInsets.only(right: 5),
                      // padding: const EdgeInsets.only(bottom: 8, right: 5, left: 5),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          GetBuilder<GroupchatroomCtr>(
                              // id: 'send Message',
                              builder: (ctr) {
                            return !ctr.isRecording
                                ? Flexible(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      width: Get.width - 60,
                                      child: Form(
                                        // key: controller.formState,
                                        child: TextFormField(
                                          textInputAction: TextInputAction.send,
                                          controller: controller.tctr,
                                          onFieldSubmitted: (_) {
                                            Map data = {
                                              'type': 'group',
                                              'mes_sender_id': controller
                                                  .myServices.box
                                                  .read('user')['user_id'],
                                              'mes_chan_id':
                                                  controller.channelInfo.chanId,
                                              'mes_content': encodeString(
                                                  controller.tctr.text),
                                              'mes_type': !GetUtils.isURL(
                                                      controller.tctr.text)
                                                  ? 'text'
                                                  : 'link',
                                            };
                                            controller.sendMessage(data);
                                            // // ctr.sendNotifiy(controller.tctr.text, userName);
                                            controller.tctr.clear();
                                          },
                                          enableInteractiveSelection: true,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor:
                                                AppColor.primaryC1WithOpacity2,
                                            contentPadding:
                                                const EdgeInsets.all(10),
                                            labelText: 'Send a message',
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .copyWith(
                                                    color: AppColor.primaryC1),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                  color: AppColor.primaryC1,
                                                )),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: AppColor
                                                      .primaryC1WithOpacity2,
                                                )),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                  color: AppColor.primaryC1,
                                                )),
                                            suffixIcon: Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 4.0),
                                              child: TextButton(
                                                  // key: controller.textButton,
                                                  onPressed: () {
                                                    Map data = {
                                                      'type': 'group',
                                                      'mes_sender_id': controller
                                                              .myServices.box
                                                              .read('user')[
                                                          'user_id'],
                                                      'mes_chan_id': controller
                                                          .channelInfo.chanId,
                                                      'mes_content':
                                                          encodeString(
                                                              controller
                                                                  .tctr.text),
                                                      'mes_type':
                                                          !GetUtils.isURL(
                                                                  controller
                                                                      .tctr
                                                                      .text)
                                                              ? 'text'
                                                              : 'link',
                                                    };
                                                    controller
                                                        .sendMessage(data);
                                                    // // ctr.sendNotifiy(controller.tctr.text, userName);
                                                    controller.tctr.clear();
                                                  },
                                                  child: SvgPicture.asset(
                                                      AppImage.send)),
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
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: SvgPicture.asset(
                                                          AppImage.instagram),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      await controller
                                                          .pickImage();
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: SvgPicture.asset(
                                                          AppImage
                                                              .attachcircle),
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
                    )
                  : Container(
                      margin: EdgeInsets.all(25.spMin),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        onPressed: () {
                          controller.joinToChannel();
                        },
                        color: AppColor.primaryC1,
                        textColor: Colors.white,
                        child: const Text('Join',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    );
            }));
  }
}

class SendMessageWidget extends GetView<GroupchatroomCtr> {
  const SendMessageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.only(
        right: 5,
        left: 5,
      ),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.black, offset: Offset(0, 10), blurRadius: 15)
          ]),
      width: double.infinity,
      child: Form(
        key: GlobalKey(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            //   margin: const EdgeInsets.only(bottom: 5, right: 5, left: 5),
            //   decoration: BoxDecoration(
            //       color: AppColor.primaryC1.withOpacity(0.2),
            //       borderRadius: BorderRadius.circular(30)),
            //   child: IconButton(
            //       onPressed: () async {
            //         await controller.pickImage();
            //       },
            //       color: AppColor.primaryC1,
            //       icon: const Icon(Icons.mic_none_outlined)),
            // ),
            Container(
              margin: const EdgeInsets.only(bottom: 5, right: 5),
              decoration: BoxDecoration(
                color: AppColor.primaryC1.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(AppImage.microphone)),
            ),
            Expanded(
              child: TextFormField(
                controller: controller.tctr,
                // strutStyle: const StrutStyle(height: 50),
                textInputAction: TextInputAction.send,
                onFieldSubmitted: (_) {
                  Map data = {
                    'type': 'group',
                    'mes_sender_id':
                        controller.myServices.box.read('user')['user_id'],
                    'mes_chan_id': controller.channelInfo.chanId,
                    'mes_content': encodeString(controller.tctr.text),
                    'mes_type':
                        !GetUtils.isURL(controller.tctr.text) ? 'text' : 'link',
                  };
                  controller.sendMessage(data);
                  // // ctr.sendNotifiy(controller.tctr.text, userName);
                  controller.tctr.clear();
                },

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
                        onPressed: () {
                          Map data = {
                            'type': 'group',
                            'mes_sender_id': controller.myServices.box
                                .read('user')['user_id'],
                            'mes_chan_id': controller.channelInfo.chanId,
                            'mes_content': encodeString(controller.tctr.text),
                            'mes_type': !GetUtils.isURL(controller.tctr.text)
                                ? 'text'
                                : 'link',
                          };
                          controller.sendMessage(data);
                          // // ctr.sendNotifiy(controller.tctr.text, userName);
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
                            child: SvgPicture.asset(AppImage.instagram),
                          ),
                        ),

                        GestureDetector(
                          onTap: () async {
                            await controller.pickImage();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: SvgPicture.asset(AppImage.attachcircle),
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
          ],
        ),
      ),
    );
  }
}
