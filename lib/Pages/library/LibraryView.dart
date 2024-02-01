import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/Main/widgets/bottomNavigationBar.dart';
import 'package:flutter_chatapp/Pages/library/widgets/CustomSearchBar.dart';
import 'package:flutter_chatapp/core/constant/AppImage.dart';
import 'package:flutter_chatapp/core/functions/alertWaiting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../core/calsses/DownloadCtr.dart';
import '../../core/calsses/HandlingDataView.dart';
import '../../core/constant/AppColor.dart';
import '../../core/constant/AppLinkes.dart';
import 'LibraryController.dart';
import 'widgets/CustomDropDownButton.dart';
import 'widgets/customButton.dart';

class Library extends GetView<LibraryCtr> {
  const Library({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LibraryCtr());
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(),
        body: Column(
          children: [
            const CustomSearchBar(),
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                margin: EdgeInsets.symmetric(
                    horizontal: 10.spMin, vertical: 8.spMin),
                child: Stack(
                  children: [
                    GetBuilder<LibraryCtr>(builder: (_) {
                      return controller.isFilter
                          ? Container()
                          : controller.isSearch
                              ? Container(
                                  margin: EdgeInsets.only(top: 0.spMin),
                                  child: HandlingDataView(
                                    statusRequest: controller.statusRequest,
                                    child: ListView.builder(
                                      // shrinkWrap: true,
                                      // physics: const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          controller.groupValue == 'Files'
                                              ? controller.fileList.length
                                              : controller.folderList.length,
                                      itemBuilder: (context, index) {
                                        return controller.groupValue == 'Files'
                                            ? GestureDetector(
                                                onTap: () async {
                                                  FileCtr fileCtr =
                                                      Get.put(FileCtr());

                                                  alertWaiting();
                                                  fileCtr.openFile(
                                                      "Files/${controller.fileList[index].folderFile}/${controller.fileList[index].fileContent}");
                                                  Get.back();
                                                },
                                                child: Container(
                                                  height: 55.h,
                                                  width: 230.w,
                                                  margin:
                                                      EdgeInsets.all(5.spMin),
                                                  padding:
                                                      EdgeInsets.all(5.spMin),
                                                  decoration: BoxDecoration(
                                                    color: AppColor
                                                        .primaryC1WithOpacity4,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            right: 10.spMin),
                                                        height: 55.spMin,
                                                        width: 55.spMin,
                                                        decoration:
                                                            BoxDecoration(
                                                          // color: Colors.amber,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                        ),
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        child: SvgPicture.asset(
                                                          AppImage.file,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          controller
                                                              .fileList[index]
                                                              .fileName!,
                                                          maxLines: 2,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displayMedium!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                      ),
                                                      PopupMenuButton<dynamic>(
                                                        icon: SvgPicture.asset(
                                                            AppImage.more),
                                                        // color: Colors.amber,

                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        splashRadius: 10,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        itemBuilder: (context) {
                                                          return [
                                                            PopupMenuItem(
                                                              child: InkWell(
                                                                onTap: () {
                                                                  controller.downloadFile(
                                                                      "${AppLink.upload}Files/${controller.fileList[index].folderFile}/${controller.fileList[index].fileContent}",
                                                                      controller
                                                                          .fileList[
                                                                              index]
                                                                          .fileContent,
                                                                      type:
                                                                          'file');
                                                                },
                                                                child: Text(
                                                                  "Download",
                                                                  style: Theme.of(
                                                                          context)
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
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  controller.goToFiles(
                                                      controller
                                                          .folderList[index]);
                                                },
                                                child: Container(
                                                  height: 55.h,
                                                  width: double.infinity,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.spMin),
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 5.spMin),
                                                  decoration: BoxDecoration(
                                                      color: AppColor
                                                          .primaryC1WithOpacity2,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            100,
                                                        child: Text(
                                                          controller
                                                              .folderList[index]
                                                              .folderName!,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displayMedium,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                      },
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    'no result yet',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  ),
                                );
                    }),
                    GetBuilder<LibraryCtr>(builder: (_) {
                      return controller.isFilter
                          ? ListView(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 250.h,
                                  width: double.infinity,
                                  // margin: EdgeInsets.only(
                                  //   top: 90.spMin,
                                  // ),
                                  padding: EdgeInsets.only(
                                    top: 10.spMin,
                                  ),
                                  decoration: BoxDecoration(
                                      color: AppColor.primaryC1WithOpacity2,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: Column(
                                    children: [
                                      const CustomDropDownButton(),
                                      CustomButtom(
                                        text: 'Filter',
                                        onPressed: () {
                                          controller.filter();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                HandlingDataView(
                                  statusRequest: controller.statusRequest2,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: controller.folderList.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          controller.goToFiles(
                                              controller.folderList[index]);
                                        },
                                        child: Container(
                                          height: 55.h,
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.spMin),
                                          margin: EdgeInsets.symmetric(
                                              vertical: 5.spMin),
                                          decoration: BoxDecoration(
                                              color: AppColor
                                                  .primaryC1WithOpacity2,
                                              borderRadius:
                                                  BorderRadius.circular(10.r)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    100,
                                                child: Text(
                                                  controller.folderList[index]
                                                      .folderName!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    // children: [],
                                  ),
                                ),
                              ],
                            )
                          : Container();
                    })
                    // Container(
                    //   margin: EdgeInsets.only(
                    //     top: 390.spMin,
                    //   ),

                    // )
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton:
            controller.myServices.box.read('user')['user_type'] == 'prof'
                ? FloatingActionButton(
                    onPressed: () {
                      controller.goToFolders();
                    },
                    backgroundColor: AppColor.primaryC1WithOpacity4,
                    elevation: 0,
                    child: Icon(
                      Icons.upload_rounded,
                      color: AppColor.primaryC1,
                      size: 40.spMin,
                    ),
                  )
                : Container(),
        bottomNavigationBar: const BNB(),
      ),
    );
  }
}
