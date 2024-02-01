import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constant/AppColor.dart';
import '../../../core/functions/crypte.dart';
import '../../../data/models/privateMessagesModel.dart';
import '../chatroomController.dart';

class LinkWidget extends StatelessWidget {
  const LinkWidget({
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
                          if (controller.messagesList[index].mesFromId ==
                              controller.myServices.box.read('user')['user_id'])
                            PopupMenuItem(
                              child: const InkWell(
                                child: Text('remove for all'),
                              ),
                              onTap: () {
                                controller.removeMessageForAll(message);
                              },
                            )
                        ];
                      },
                    )
                  : Container(),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(
                    bottom: 8.spMin,
                    left: controller.messagesList[index].mesFromId !=
                            controller.myServices.box.read('user')['user_id']
                        ? 8.spMin
                        : 100.spMin,
                    right: controller.messagesList[index].mesFromId !=
                            controller.myServices.box.read('user')['user_id']
                        ? 100.spMin
                        : 8.spMin,
                    top: 8.spMin),
                padding: EdgeInsets.all(10.spMin),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                    topRight: controller.messagesList[index].mesFromId !=
                            controller.myServices.box.read('user')['user_id']
                        ? Radius.circular(20.r)
                        : Radius.circular(0.r),
                    topLeft: controller.messagesList[index].mesFromId !=
                            controller.myServices.box.read('user')['user_id']
                        ? Radius.circular(0.r)
                        : Radius.circular(20.r),
                  ),
                  color: controller.messagesList[index].mesFromId !=
                          controller.myServices.box.read('user')['user_id']
                      ? AppColor.primaryC1
                      : AppColor.primaryC1,
                ),
                child: SelectableText(
                    '${controller.decodeString(message.mesContent!)}',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.blue), onTap: () async {
                  String value =
                      decodeString(controller.messagesList[index].mesContent!);
                  bool isHttp =
                      value.contains('http://') || value.contains('https://');
                  if (await canLaunch(isHttp ? value : 'http://$value')) {
                    await launch(isHttp ? value : 'http://$value');
                  } else {
                    print('Could not launch ');
                  }
                }),
              ),
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
