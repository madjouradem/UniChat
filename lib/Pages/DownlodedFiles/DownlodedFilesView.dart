import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';

import '../../core/constant/AppColor.dart';
import '../../core/constant/AppImage.dart';
import '../Main/widgets/bottomNavigationBar.dart';
import 'DownlodedFilesController.dart';

class DownlodedFiles extends GetView<DownlodedFilesCtr> {
  const DownlodedFiles({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DownlodedFilesCtr());

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
            onPressed: () {},
            icon: SvgPicture.asset(
              AppImage.setting,
              color: AppColor.appBarIconColor,
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          height: double.infinity,
          width: double.infinity,
          child: GetBuilder<DownlodedFilesCtr>(builder: (_) {
            return ListView.builder(
              itemCount: controller.downloadedFileList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    await OpenFilex.open(controller.downloadedFileList[index]);
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
                            controller.downloadedFileList[index]
                                .split('/')
                                .last,
                            maxLines: 2,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        ),
        bottomNavigationBar: const BNB(),
      ),
    );
  }
}
