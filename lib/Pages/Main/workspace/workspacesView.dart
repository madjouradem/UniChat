import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/Main/mainController.dart';
import 'package:flutter_chatapp/Pages/Main/widgets/bottomNavigationBar.dart';
import 'package:flutter_chatapp/Pages/Main/workspace/workspacesController.dart';
import 'package:flutter_chatapp/core/constant/AppRoute.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/constant/AppColor.dart';
import '../../../core/constant/AppImage.dart';

class Workspaces extends GetView<WorkspaceCtr> {
  const Workspaces({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WorkspaceCtr());
    return Scaffold(
      appBar: AppBar(
        // foregroundColor: Colors.transparent,

        backgroundColor: AppColor.primaryC1,
        title: const Text('Uni Chat'),
        elevation: 0,

        shadowColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              AppImage.setting,
              color: AppColor.appBarIconColor,
            )),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.all(8.spMin),
        child: GetBuilder<MainCtr>(builder: (ctr) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 80.spMin,
            ),
            itemCount: ctr.workspaceList.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 0,
                child: GestureDetector(
                  onTap: () {
                    controller.goToChannel(ctr.workspaceList[index].wsId!,
                        ctr.workspaceList[index].wsFile!);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            offset: const Offset(0, 3),
                            blurRadius: 5)
                      ],
                    ),
                    height: 70.spMin,
                    width: double.infinity,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 5,
                            child: SizedBox(
                              child: Text(
                                ctr.workspaceList[index].wsName!,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          controller.myServices.box.read('user')['user_type'] ==
                                  'prof'
                              ? Expanded(
                                  flex: 1,
                                  child: PopupMenuButton<dynamic>(
                                    icon: Padding(
                                        padding: EdgeInsets.all(0.spMin),
                                        child: SvgPicture.asset(AppImage.more)),
                                    // color: Colors.amber,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    splashRadius: 10,
                                    padding: const EdgeInsets.all(0),
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          child: InkWell(
                                            onTap: () {
                                              Get.toNamed(AppRoute.editWS,
                                                  arguments: {
                                                    'ws_id': ctr
                                                        .workspaceList[index]
                                                        .wsId,
                                                    'ws_name': ctr
                                                        .workspaceList[index]
                                                        .wsName,
                                                    'ws_desc': ctr
                                                        .workspaceList[index]
                                                        .wsDesc,
                                                    'ws_gro_id': ctr
                                                        .workspaceList[index]
                                                        .wsGroId,
                                                    'ws_sea_id': ctr
                                                        .workspaceList[index]
                                                        .wsSeaId,
                                                    'ws_spe_id': ctr
                                                        .workspaceList[index]
                                                        .wsSpeId,
                                                    'ws_image': ctr
                                                        .workspaceList[index]
                                                        .wsImage,
                                                  });
                                            },
                                            child: const Text(
                                              "Edit worksapce",
                                              // style: Theme.of(context).textTheme.headline4,
                                            ),
                                          ),
                                        ),
                                        PopupMenuItem(
                                          onTap: () {
                                            // controller.deleteWS(
                                            //     ctr.workspaceList[index].wsId!,
                                            //     ctr.workspaceList[index].wsFile!);
                                          },
                                          child: InkWell(
                                            onTap: () {
                                              controller.deleteWS(
                                                  ctr.workspaceList[index]
                                                      .wsId!,
                                                  ctr.workspaceList[index]
                                                      .wsFile!);
                                            },
                                            child: const Text(
                                              "Delete worksapce",
                                              // style: Theme.of(context).textTheme.headline4,
                                            ),
                                          ),
                                        ),
                                      ];
                                    },
                                  ),
                                )
                              : Container(),
                        ]),
                  ),
                ),
              );
            },
          );
        }),
      ),
      bottomNavigationBar: const BNB(),
      floatingActionButton:
          controller.myServices.box.read('user')['user_type'] == 'prof'
              ? FloatingActionButton(
                  onPressed: () {
                    controller.goToCreateWS();
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
    );
  }
}
