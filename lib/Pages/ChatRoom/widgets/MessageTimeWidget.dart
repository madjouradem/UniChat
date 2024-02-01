import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';
import '../../../data/models/privateMessagesModel.dart';
import '../chatroomController.dart';

class MessageTimeWidget extends StatelessWidget {
  const MessageTimeWidget({
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
    return Container(
        alignment: message.mesFromId !=
                controller.myServices.box.read('user')['user_id']
            ? Alignment.topLeft
            : Alignment.topRight,
        margin: EdgeInsets.only(
            left: message.mesFromId !=
                    controller.myServices.box.read('user')['user_id']
                ? 8.spMin
                : 100.spMin,
            right: message.mesFromId !=
                    controller.myServices.box.read('user')['user_id']
                ? 100.spMin
                : 8.spMin,
            top: 4.spMin),
        // padding: EdgeInsets.all(10.spMin),
        child: Text(Jiffy.parse(message.mesCreateTime!, isUtc: true).Hm));
  }
}
