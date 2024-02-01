import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/moreInfoConv/MoreInfoConvController.dart';
import 'package:flutter_chatapp/core/constant/AppColor.dart';
import 'package:flutter_chatapp/core/constant/AppRoute.dart';
import 'package:get/get.dart';

import '../../core/calsses/DefaultAvater/DefaultAvater.dart';

class MoreInfoConv extends GetView<MoreInfoConvCtr> {
  const MoreInfoConv({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MoreInfoConvCtr());
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
                  controller.userName,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                  alignment: Alignment.center,
                  child: DefaultAvater(
                      image: controller.userImage,
                      height: 90,
                      width: 90,
                      radius: 90,
                      fontSize: 30,
                      name: controller.userName[0],
                      userState: 'off')),
              const Divider(
                height: 70,
                thickness: 1,
                color: Colors.black,
              ),
              CostumListTile(
                text: 'Media and Files and Links',
                icon: '',
                onTap: () {
                  Get.toNamed(AppRoute.veiwFiles);
                },
              ),
              // const CostumListTile(
              //   text: 'view pinned messgaes',
              //   icon: '',
              // ),
              // const CostumListTile(
              //   text: 'view , media and files',
              //   icon: '',
              // )
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
            const Icon(
              Icons.source_outlined,
              color: AppColor.primaryC1,
            ),
          ],
        ),
      ),
    );
  }
}
