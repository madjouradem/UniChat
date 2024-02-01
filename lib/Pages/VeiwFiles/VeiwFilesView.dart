import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/VeiwFiles/VeiwFilesController.dart';
import 'package:flutter_chatapp/core/constant/AppColor.dart';
import 'package:flutter_chatapp/core/constant/AppLinkes.dart';
import 'package:flutter_chatapp/core/functions/crypte.dart';
import 'package:get/get.dart';

import '../../core/calsses/DownloadCtr.dart';
import '../../core/constant/AppRoute.dart';
import '../ChatRoom/widgets/VideoFirstFrame.dart';

class VeiwFiles extends GetView<VeiwFilesCtr> {
  const VeiwFiles({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VeiwFilesCtr());
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.primaryC1.withOpacity(0.4),
            elevation: 0,
            bottom: TabBar(
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [AppColor.primaryC1, AppColor.primaryC1],
                    end: Alignment.bottomLeft,
                    begin: Alignment.topRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.shadowC.withOpacity(0.25),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ]),
              labelColor: Colors.black,
              labelStyle: Theme.of(context).textTheme.headlineMedium,
              tabs: [
                Tab(
                  child: Text(
                    "Files",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                Tab(
                  child: Text(
                    "Media",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                Tab(
                  child: Text(
                    "Linkes",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              FilesTab(),
              MediaTab(),
              LinksTab(),
            ],
          ),
        ),
      ),
    );
  }
}

class FilesTab extends GetView<VeiwFilesCtr> {
  const FilesTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: GetBuilder<VeiwFilesCtr>(builder: (_) {
        return ListView.builder(
          itemCount: controller.filesList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                FileCtr fileCtr = Get.put(FileCtr());
                fileCtr.openFile(
                    "Conversations/${controller.chatroomCtr.convFile}/${decodeString(controller.filesList[index].mesContent)}");
              },
              child: Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black38,
                            blurRadius: 20,
                            offset: Offset(0, 3))
                      ],
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        // padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.amberAccent,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 280,
                        child: Text(
                          decodeString(controller.filesList[index].mesContent!),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  )),
            );
          },
        );
      }),
    );
  }
}

class MediaTab extends GetView<VeiwFilesCtr> {
  const MediaTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
// VideoFirstFrameCtr ctr=    Get.put(VideoFirstFrameCtr().firstFrame());
    return Container(
      margin: const EdgeInsets.all(8),
      child: GetBuilder<VeiwFilesCtr>(builder: (_) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 4),
          itemCount: controller.mediaList.length,
          itemBuilder: (context, index) {
            return Container(
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColor.primaryC1,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: controller.mediaList[index].mesType == 'image'
                  ? GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoute.imageViwer, arguments: {
                          'image': Image.network(
                            "${AppLink.upload}Conversations/${controller.chatroomCtr.convFile}/${decodeString(controller.mediaList[index].mesContent)}",
                            fit: BoxFit.cover,
                          ),
                        });
                      },
                      child: CachedNetworkImage(
                        imageUrl:
                            "${AppLink.upload}Conversations/${controller.chatroomCtr.convFile}/${decodeString(controller.mediaList[index].mesContent)}",
                        fit: BoxFit.cover,
                      ),
                    )
                  : GetBuilder<VideoFirstFrameCtr>(
                      init: VideoFirstFrameCtr(
                          "Conversations/${controller.chatroomCtr.convFile}/${decodeString(controller.mediaList[index].mesContent)}"),
                      builder: (ctr) {
                        return SizedBox(
                            // height: 200,
                            // width: 200,
                            child: ctr.fileName != null
                                ? Stack(
                                    children: [
                                      SizedBox(
                                        height: 200,
                                        width: 200,
                                        child: Image.file(
                                          File(ctr.fileName),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controller.showVideo(
                                              "Conversations/${controller.chatroomCtr.convFile}/${decodeString(controller.mediaList[index].mesContent)}");
                                        },
                                        child: const Align(
                                          // top: ,
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.play_arrow_outlined,
                                            size: 50,
                                            color: AppColor.primaryC1,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : Container());
                      }),
            );
          },
        );
      }),
    );
  }
}

class LinksTab extends GetView<VeiwFilesCtr> {
  const LinksTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: GetBuilder<VeiwFilesCtr>(builder: (_) {
        return ListView.builder(
          itemCount: controller.linksList.length,
          itemBuilder: (context, index) {
            return Container(
                height: 55,
                width: double.infinity,
                decoration: const BoxDecoration(color: AppColor.primaryC1),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration:
                          const BoxDecoration(color: Colors.amberAccent),
                    ),
                    Text(decodeString(controller.linksList[index].mesContent!)),
                  ],
                ));
          },
        );
      }),
    );
  }
}
