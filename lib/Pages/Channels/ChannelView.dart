import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/Channels/ChannelController.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../../core/constant/AppColor.dart';

class Channel extends GetView<ChannelCtr> {
  const Channel({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChannelCtr());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // foregroundColor: Colors.transparent,

          backgroundColor: AppColor.primaryC1,
          title: const Text('Channels'),
          elevation: 0,
          shadowColor: Colors.transparent,
          centerTitle: true,
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: GetBuilder<ChannelCtr>(builder: (context) {
            return ListView.builder(
              itemCount: controller.channelList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    controller.chanId = controller.channelList[index].chanId!;

                    controller.gotoGroupChatRoom(controller.channelList[index]);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 5.spMin, vertical: 2.spMin),
                    padding: EdgeInsets.symmetric(horizontal: 8.spMin),
                    height: 60.spMin,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            offset: const Offset(0, 3),
                            blurRadius: 4)
                      ],
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(left: 8),
                      alignment: Alignment.centerLeft,
                      height: 50,
                      decoration: BoxDecoration(
                        // color: Colors.indigo,
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // const CircleAvatar(),
                          Row(
                            children: [
                              Container(
                                height: 45.spMin,
                                width: 45.spMin,
                                decoration: BoxDecoration(
                                    color: controller.getColor(controller
                                        .channelList[index].chanName![0]
                                        .toUpperCase()),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Center(
                                  child: Text(
                                    controller.channelList[index].chanName![0]
                                        .toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.spMin),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 140.spMin,
                                    child: Text(
                                      controller.channelList[index].chanName!,
                                      maxLines: 1,
                                      style: controller.channelList[index]
                                                      .chanSenderId !=
                                                  controller.myServices.box
                                                      .read(
                                                          'user')['user_id'] &&
                                              !controller
                                                  .channelList[index].chanRead!
                                                  .contains(controller
                                                      .myServices.box
                                                      .read('user')['user_id'])
                                          ? Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold)
                                          : Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Container(
                                alignment: Alignment.centerRight,
                                width: 100.spMin,
                                child: Text(
                                  Jiffy.parse(controller
                                          .channelList[index].chanLastMesDate
                                          .toString())
                                      .fromNow(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              ),
                              controller.channelList[index].chanSenderId !=
                                          controller.myServices.box
                                              .read('user')['user_id'] &&
                                      !controller.channelList[index].chanRead!
                                          .contains(controller.myServices.box
                                              .read('user')['user_id'])
                                  ? Container(
                                      height: 20.spMin,
                                      width: 20.spMin,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 5.spMin),
                                      decoration: BoxDecoration(
                                          color: AppColor.primaryC1,
                                          borderRadius:
                                              BorderRadius.circular(20.r)),
                                    )
                                  : Container()
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
        floatingActionButton:
            controller.myServices.box.read('user')['user_type'] == 'prof'
                ? FloatingActionButton(
                    onPressed: () {
                      controller.gotoCreateChannel();
                    },
                    backgroundColor: AppColor.primaryC1WithOpacity4,
                    elevation: 0,
                    child: Icon(
                      Icons.add,
                      color: AppColor.primaryC1,
                      size: 40.spMin,
                    ),
                  )
                : Container(),
      ),
    );
  }
}
