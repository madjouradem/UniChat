import 'package:flutter/material.dart';
import 'package:flutter_chatapp/core/calsses/HandlingDataView.dart';
import 'package:flutter_chatapp/core/constant/AppImage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../core/constant/AppColor.dart';
import 'FoldersController.dart';

class Folders extends GetView<FoldersCtr> {
  const Folders({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FoldersCtr());
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Folders'),
        backgroundColor: AppColor.primaryC1,
      ),
      body: GetBuilder<FoldersCtr>(builder: (context) {
        return HandlingDataView(
          statusRequest: controller.statusRequest,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            margin:
                EdgeInsets.symmetric(horizontal: 10.spMin, vertical: 5.spMin),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 10.h,
                );
              },
              itemCount: controller.foldersList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    controller.goToFiles(controller.foldersList[index]);
                  },
                  child: Container(
                    height: 55.h,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10.spMin),
                    decoration: BoxDecoration(
                        color: AppColor.primaryC1WithOpacity2,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 100,
                          child: Text(
                            controller.foldersList[index].folderName!,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        PopupMenuButton<dynamic>(
                          icon: SvgPicture.asset(AppImage.more),
                          // color: Colors.amber,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          splashRadius: 10,
                          padding: const EdgeInsets.all(5),
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                child: InkWell(
                                  onTap: () {
                                    controller.goEditFolder(
                                        controller.foldersList[index]);
                                  },
                                  child: Text(
                                    "Edit folder",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                child: InkWell(
                                  onTap: () {
                                    controller.removeFolder(
                                        controller.foldersList[index]);
                                  },
                                  child: Text(
                                    "Delete folder",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                ),
                              ),
                            ];
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.goToAddFolder();
        },
        backgroundColor: AppColor.primaryC1WithOpacity4,
        elevation: 0,
        child: Icon(
          Icons.add,
          color: AppColor.primaryC1,
          size: 40.spMin,
        ),
      ),
    ));
  }
}
