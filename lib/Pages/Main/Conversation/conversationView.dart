import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/Main/Conversation/ConversationController.dart';
import 'package:flutter_chatapp/Pages/Main/mainController.dart';
import 'package:flutter_chatapp/core/calsses/webSocketConn.dart';
import 'package:flutter_chatapp/core/constant/AppColor.dart';
import 'package:flutter_chatapp/core/constant/AppRoute.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/constant/AppImage.dart';
import '../widgets/bottomNavigationBar.dart';
import 'widgets/conversationCard.dart';

class Conversations extends GetView<ConversationCtr> {
  const Conversations({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ConversationCtr());
    // Get.put(DefaultAvaterCtr());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // foregroundColor: Colors.transparent,

          backgroundColor: AppColor.primaryC1,
          title: const Text('Uni Chat'),
          elevation: 0,
          shadowColor: Colors.transparent,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.toNamed(AppRoute.downlodedFiles);
              },
              icon: SvgPicture.asset(
                AppImage.setting,
                color: AppColor.appBarIconColor,
              )),
          actions: [
            IconButton(
                onPressed: () {
                  Get.find<MainCtr>().myServices.box.remove('step');
                  Get.find<WebSocketConn>().doneReason = 'sign out';
                  if (Get.find<WebSocketConn>().channel != null) {
                    Get.find<WebSocketConn>().channel!.sink.close(1000);
                  }
                  Get.delete<WebSocketConn>(force: true);
                  Get.find<MainCtr>().myServices.box.remove('user');
                  Get.delete<MainCtr>(force: true);
                  Get.offAllNamed(AppRoute.login);
                },
                icon: const Icon(Icons.exit_to_app)),
          ],
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              GetBuilder<MainCtr>(
                builder: (_) {
                  return GetBuilder<ConversationCtr>(builder: (_) {
                    return ListView.builder(
                      itemCount: controller.homeCtr.conversationsList.length,
                      itemBuilder: (context, index) {
                        return ConversationCard(
                          onTap: () {
                            controller.gotoChatRoom(
                              userId: controller
                                  .homeCtr.conversationsList[index].userId,
                              userName: controller
                                  .homeCtr.conversationsList[index].userName,
                              convId: controller
                                  .homeCtr.conversationsList[index].id,
                              userImage: controller
                                  .homeCtr.conversationsList[index].userAvatar,
                              convFile: controller
                                  .homeCtr.conversationsList[index].convFile,
                            );
                          },
                          conversationModel:
                              controller.homeCtr.conversationsList[index],
                        );
                      },
                    );
                  });
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BNB(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.gotoCreateContact();
          },
          backgroundColor: AppColor.primaryC1WithOpacity4,
          elevation: 0,
          child: Icon(
            Icons.add,
            color: AppColor.primaryC1,
            size: 40.spMin,
          ),
        ),
      ),
    );
  }
}
