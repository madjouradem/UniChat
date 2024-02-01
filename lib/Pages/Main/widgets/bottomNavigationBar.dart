import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/Main/widgets/BNBandDarwerCtr.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/constant/AppColor.dart';
import '../../../data/static/static.dart';

class BNB extends StatelessWidget {
  const BNB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BNBandDarwerCtr bnbCtr = Get.put(BNBandDarwerCtr(), permanent: true);
    return Container(
      height: 65.spMin,
      width: double.infinity,
      // padding: EdgeInsets.all(4.spMin),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: const [
            BoxShadow(
              color: AppColor.shadowC,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r))),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...bnblist.map((e) => GestureDetector(
                  onTap: () {
                    bnbCtr.goTo(e.route);
                    bnbCtr.changeNum(e.defaultNum);
                  },
                  child: GetBuilder<BNBandDarwerCtr>(builder: (_) {
                    return Container(
                      height: 50..spMin,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.spMin,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: bnbCtr.currentNum.isEqual(e.defaultNum)
                            ? AppColor.primaryC1WithOpacity4
                            : Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: bnbCtr.currentNum.isEqual(e.defaultNum)
                                ? EdgeInsets.only(right: 8.spMin)
                                : const EdgeInsets.only(right: 0),
                            child: SvgPicture.asset(e.icon),
                          ),
                          bnbCtr.currentNum.isEqual(e.defaultNum)
                              ? Padding(
                                  padding: EdgeInsets.only(top: 4.spMin),
                                  child: Text(
                                    e.name,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    );
                  }),
                )),
          ],
        ),
      ),
    );
  }
}
