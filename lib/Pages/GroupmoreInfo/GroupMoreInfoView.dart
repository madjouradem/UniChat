import 'package:flutter/material.dart';
import 'package:flutter_chatapp/core/constant/AppColor.dart';
import 'package:flutter_chatapp/core/constant/AppRoute.dart';
import 'package:get/get.dart';

import '../../core/calsses/DefaultAvater/DefaultAvater.dart';
import 'GroupMoreInfoController.dart';

class GroupMoreInfo extends GetView<GroupMoreInfoCtr> {
  const GroupMoreInfo({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GroupMoreInfoCtr());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColor.primaryC1),
        ),
        body: Container(
          margin: const EdgeInsets.all(8),
          child: ListView(
            children: [
              Center(
                child: Text(
                  controller.channelInfo.chanName!,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                  alignment: Alignment.center,
                  child: DefaultAvater(
                      height: 90,
                      width: 90,
                      radius: 90,
                      fontSize: 30,
                      name: controller.channelInfo.chanName![0],
                      userState: 'off')),
              const Divider(
                height: 70,
                thickness: 1,
                color: Colors.black,
              ),
              controller.myServices.box.read('user')['user_type'] == 'prof'
                  ? CostumListTile(
                      text: 'Edit channel',
                      icon: '',
                      onTap: () {
                        controller.goToEditChanMember();
                      },
                    )
                  : Container(),
              controller.myServices.box.read('user')['user_type'] == 'prof'
                  ? CostumListTile(
                      text: 'Delete channel',
                      icon: '',
                      onTap: () {
                        controller.deleteChannel(controller.channelInfo.chanId!,
                            "${controller.wsFile}/${controller.channelInfo.chanFile}");
                      },
                    )
                  : Container(),
              CostumListTile(
                text: 'view media and files and links',
                icon: '',
                onTap: () {
                  Get.toNamed(AppRoute.groupveiwFiles);
                },
              ),
              controller.myServices.box.read('user')['user_type'] == 'prof'
                  ? CostumListTile(
                      text: 'Add members',
                      icon: '',
                      onTap: () {
                        controller.goToAddChanMember();
                      },
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}

class CostumListTile extends StatelessWidget {
  const CostumListTile({
    super.key,
    this.onTap,
    required this.text,
    required this.icon,
  });

  final Function()? onTap;
  final String text;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            const Icon(Icons.file_copy),
          ],
        ),
      ),
    );
  }
}
