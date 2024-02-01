import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/library/LibraryController.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/constant/AppColor.dart';
import '../../../core/functions/validinput.dart';

class CustomSearchBar extends GetView<LibraryCtr> {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60.h,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
        width: double.infinity,
        child: GetBuilder<LibraryCtr>(builder: (context) {
          return Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                    margin: EdgeInsets.only(right: 5.spMin),
                    child: IconButton(
                        onPressed: () {
                          controller.onTapFilter();
                        },
                        icon: Icon(
                          controller.isFilter
                              ? Icons.close
                              : Icons.filter_alt_rounded,
                          color: AppColor.primaryC1,
                        ))),
              ),
              !controller.isFilter
                  ? Expanded(
                      flex: 5,
                      child: Form(
                        key: controller.formState,
                        child: Builder(builder: (context) {
                          return TextFormField(
                            textInputAction: TextInputAction.search,
                            controller: controller.textEditingController,
                            onFieldSubmitted: (_) {
                              controller.onTapSearch();
                            },
                            enableInteractiveSelection: true,
                            validator: (val) {
                              return validInput(val!, 1, 200, '');
                            },
                            onChanged: (value) {
                              controller.onWriteInField();
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColor.primaryC1WithOpacity2,
                              contentPadding: const EdgeInsets.all(20),
                              labelText: 'Search',
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(color: AppColor.primaryC1),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: AppColor.primaryC1,
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: AppColor.primaryC1WithOpacity2,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: AppColor.primaryC1,
                                  )),
                              // suffixIcon: Container(
                              //   margin: const EdgeInsets.only(bottom: 4.0),
                              //   child: SvgPicture.asset(AppImage.send),
                              // ),
                              suffixIcon: SizedBox(
                                  width: 75,
                                  child: IconButton(
                                    icon: const Icon(Icons.search),
                                    onPressed: () {
                                      controller.onTapSearch();
                                    },
                                  )),
                              prefixIcon:
                                  GetBuilder<LibraryCtr>(builder: (context) {
                                return SizedBox(
                                  width: 69.w,
                                  child: DropdownButton<String>(
                                    padding: const EdgeInsets.only(left: 4),
                                    borderRadius: BorderRadius.circular(30),
                                    elevation: 3,
                                    isExpanded: true,
                                    value: controller.groupValue,
                                    onChanged: (value) {
                                      controller.onChangeDropDown(value);
                                    },
                                    items: ['Files', 'Folders'].map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Builder(builder: (context) {
                                          return Text(
                                            value,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall,
                                          );
                                        }),
                                      );
                                    }).toList(),
                                    underline: Container(),
                                  ),
                                );
                              }),
                            ),
                          );
                        }),
                      ),
                    )
                  : Container(),
            ],
          );
        }));
  }
}
