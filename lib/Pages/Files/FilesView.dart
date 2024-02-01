import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/Files/FilesController.dart';
import 'package:flutter_chatapp/Pages/library/LibraryController.dart';
import 'package:flutter_chatapp/core/constant/AppColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../core/calsses/DownloadCtr.dart';
import '../../core/calsses/HandlingDataView.dart';
import '../../core/constant/AppImage.dart';
import '../../core/constant/AppLinkes.dart';

class Files extends GetView<FilesCtr> {
  const Files({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FilesCtr());
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Files'),
        backgroundColor: AppColor.primaryC1,
      ),
      body: GetBuilder<FilesCtr>(builder: (context) {
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
              itemCount: controller.filesList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    // await OpenFilex.open(controller.downloadedFileList[index]);
                  },
                  child: GestureDetector(
                    onTap: () {
                      FileCtr fileCtr = Get.put(FileCtr());
                      fileCtr.openFile(
                          "Files/${controller.folderInfo.folderFile}/${controller.filesList[index].fileContent}");
                    },
                    child: Container(
                      height: 55.h,
                      width: 230.w,
                      margin: EdgeInsets.all(5.spMin),
                      padding: EdgeInsets.all(5.spMin),
                      decoration: BoxDecoration(
                        color: AppColor.primaryC1WithOpacity4,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10.spMin),
                            height: 55.spMin,
                            width: 55.spMin,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: SvgPicture.asset(
                              AppImage.file,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              controller.filesList[index].fileName!,
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(fontWeight: FontWeight.w500),
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
                                      controller.goToEditFiles(
                                          controller.filesList[index]);
                                    },
                                    child: Text(
                                      "Edit file",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    ),
                                  ),
                                ),
                                PopupMenuItem(
                                  child: InkWell(
                                    onTap: () {
                                      controller.removeFile(
                                          controller.filesList[index]);
                                    },
                                    child: Text(
                                      "Delete file",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    ),
                                  ),
                                ),
                                PopupMenuItem(
                                  child: InkWell(
                                    onTap: () {
                                      Get.find<LibraryCtr>().downloadFile(
                                          "${AppLink.upload}Files/${controller.folderInfo.folderFile}/${controller.filesList[index].fileContent}",
                                          controller
                                              .filesList[index].fileContent,
                                          type: 'file');
                                    },
                                    child: Text(
                                      "Download",
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
                  ),
                );
              },
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.goToAddFiles();
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
