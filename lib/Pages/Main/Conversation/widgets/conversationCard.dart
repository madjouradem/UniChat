import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/Main/Conversation/ConversationController.dart';
import 'package:flutter_chatapp/core/constant/AppColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../../../../core/calsses/DefaultAvater/DefaultAvater.dart';
import '../../../../data/models/ConversationModel.dart';

class ConversationCard extends GetView<ConversationCtr> {
  const ConversationCard({
    required this.conversationModel,
    required this.onTap,
    super.key,
  });

  final void Function() onTap;
  final ConversationModel conversationModel;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConversationCtr>(builder: (_) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4.spMin),
          padding: EdgeInsets.symmetric(horizontal: 8.spMin),
          height: 60.spMin,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.spMin),
            color: AppColor.lightbackgroundC,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: const Offset(0, 3),
                  blurRadius: 4)
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.,
                children: [
                  //for the avatar

                  DefaultAvater(
                      name: conversationModel.userName![0],
                      image: conversationModel.userAvatar,
                      userState: conversationModel.userStatus!),
                  SizedBox(width: 10.spMin),
                  SizedBox(
                    width: 150.w,
                    child: Text(
                      conversationModel.userName!,
                      maxLines: 1,
                      style:
                          //  conversationModel.userId !=
                          //             controller.myServices.box
                          //                 .read('user')['user_id'] &&
                          //         conversationModel.userId ==
                          //             conversationModel.fromId &&
                          //         conversationModel.messageStatus == '0'
                          //     ? Theme.of(context)
                          //         .textTheme
                          //         .displayMedium!
                          //         .copyWith(fontWeight: FontWeight.bold)
                          //     :
                          Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  //for the name of the user
                ],
              ),

              //if the conversation is for the current user
              conversationModel.userId ==
                      controller.myServices.box.read('user')['user_id']
                  ? Text(
                      '(you)',
                      style: Theme.of(context).textTheme.displaySmall,
                    )
                  : const Text(''),
              //for last message time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100.spMin,
                    // alignment: Alignment.centerRight,
                    child: Text(
                      Jiffy.parse(conversationModel.messageTime!.toString())
                          .toLocal()
                          .fromNow(),
                      textAlign: TextAlign.center,
                      style:
                          // conversationModel.userId !=
                          //             controller.myServices.box
                          //                 .read('user')['user_id'] &&
                          //         conversationModel.userId ==
                          //             conversationModel.fromId &&
                          //         conversationModel.messageStatus == '0'
                          //     ? Theme.of(context)
                          //         .textTheme
                          //         .displaySmall!
                          //         .copyWith(fontWeight: FontWeight.bold)
                          //     :
                          Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  conversationModel.userId !=
                              controller.myServices.box
                                  .read('user')['user_id'] &&
                          conversationModel.userId ==
                              conversationModel.fromId &&
                          conversationModel.messageStatus == '0'
                      ? Container(
                          height: 20,
                          width: 20,
                          margin: EdgeInsets.symmetric(horizontal: 3.spMin),
                          decoration: BoxDecoration(
                              color: AppColor.primaryC1,
                              borderRadius: BorderRadius.circular(20.r)),
                        )
                      : Container()
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
