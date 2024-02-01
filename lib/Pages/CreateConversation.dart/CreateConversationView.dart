import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/CreateConversation.dart/CreateConversationController.dart';
import 'package:flutter_chatapp/Pages/CreateConversation.dart/widgets/ConvCard.dart';
import 'package:flutter_chatapp/core/constant/AppColor.dart';
import 'package:flutter_chatapp/core/functions/validinput.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../core/constant/AppImage.dart';

class CreateConversation extends GetView<CreateConversationCtr> {
  const CreateConversation({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateConversationCtr());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryC1,
        shadowColor: Colors.transparent,
        elevation: 0,
        actions: [
          Builder(builder: (context) {
            return PopupMenuButton<dynamic>(
              // icon: Icon(Icons.accessibility),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              splashRadius: 10,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    onTap: () {
                      Get.defaultDialog(
                        title: 'Add conversation',
                        content: Form(
                          key: controller.formstate,
                          child: TextFormField(
                            validator: (value) {
                              return validInput(value!, 1, 50, '');
                            },
                            controller: controller.textCtr,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'id',
                            ),
                          ),
                        ),
                        actions: [
                          SizedBox(
                            width: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    controller.addConversationById();
                                  },
                                  child: SizedBox(
                                    width: 60,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text('say'),
                                        SizedBox(width: 5.spMin),
                                        SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: Lottie.asset(AppImage.hi)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                      Get.defaultDialog();
                    },
                    child: const Text(
                      "Add by id",
                      // style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ];
              },
            );
          }),
        ],
      ),
      body: const SizedBox(
        // margin: const EdgeInsets.all(10),
        height: double.infinity,
        width: double.infinity,
        child: ConvCard(),
      ),
    );
  }
}
