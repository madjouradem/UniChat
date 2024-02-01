import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/Pages/EditWS/widgets/CustomDropDownButton.dart';
import 'package:flutter_chatapp/Pages/EditWS/widgets/CustomTextFormField.dart';
import 'package:flutter_chatapp/core/constant/AppColor.dart';
import 'package:flutter_chatapp/core/constant/AppImage.dart';
import 'package:flutter_chatapp/core/functions/validinput.dart';
import 'package:get/get.dart';

import '../../data/static/static.dart';
import 'EditWSController.dart';
import 'widgets/customButton.dart';

class EditWS extends GetView<EditWSCtr> {
  const EditWS({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EditWSCtr());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryC1,
        title: const Text('Edit Workspace'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        child: Form(
          key: controller.key,
          child: ListView(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 150.0,
                  aspectRatio: 2.0,
                  animateToClosest: true,
                ),
                items: images.map((i) {
                  return GetBuilder<EditWSCtr>(
                    builder: (_) {
                      return Container(
                        width: double.infinity,
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(
                            right: 5.0, left: 5.0, bottom: 10),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('${AppImage.imageRoute}/$i'),
                              fit: BoxFit.cover,
                            ),
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(30)),
                        child: Radio(
                          groupValue: controller.radioValue,
                          value: i,
                          onChanged: (value) {
                            controller.chooseImage(value);
                          },
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              CustomTextFormField(
                hintText: 'Workspace Name',
                lableText: 'Workspace Name',
                tec: controller.wsNameCtr,
                validator: (val) {
                  return validInput(val!, 2, 50, '');
                },
              ),
              CustomTextFormField(
                hintText: 'Workspace Description',
                lableText: 'Workspace desc',
                tec: controller.wsDescCtr,
              ),
              const CustomDropDownButton(),
              CustomButtom(
                text: 'Save',
                onPressed: () {
                  controller.editWS();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
