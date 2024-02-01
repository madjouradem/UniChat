import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/GroupsModel.dart';
import '../../../data/models/SeasonModel.dart';
import '../../../data/models/SpecialtyModel.dart';
import '../CreateWSController.dart';

class CustomDropDownButton extends GetView<CreateWSCtr> {
  const CustomDropDownButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: GetBuilder<CreateWSCtr>(builder: (context) {
        return ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(30),
                // padding: const EdgeInsets.all(8.0),
                // decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(10)),
                child: DropdownButton<SpecialtyModel>(
                  padding: const EdgeInsets.all(8),
                  borderRadius: BorderRadius.circular(30),
                  elevation: 3,
                  isExpanded: true,
                  value: controller.specialtyVal,
                  onChanged: (value) {
                    controller.onChangeSpe(value);
                  },
                  hint: const Text("Select Specialty"),
                  items: controller.specialtyList.map((value) {
                    return DropdownMenuItem<SpecialtyModel>(
                      value: value,
                      child: Text(value.speName!),
                    );
                  }).toList(),
                  underline: Container(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(30),
                // padding: const EdgeInsets.all(8.0),
                // decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(10)),
                child: DropdownButton<SeasonModel>(
                  padding: const EdgeInsets.all(8),
                  borderRadius: BorderRadius.circular(30),
                  elevation: 3,
                  isExpanded: true,
                  value: controller.seasonVal,
                  onChanged: (value) {
                    controller.onChangeSea(value);
                  },
                  hint: const Text("Select Season"),
                  items: controller.seasonList.map((value) {
                    return DropdownMenuItem<SeasonModel>(
                      value: value,
                      child: Text(value.seaName!),
                    );
                  }).toList(),
                  underline: Container(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(30),
                // padding: const EdgeInsets.all(8.0),
                // decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(10)),
                child: DropdownButton<GroupsModel>(
                  padding: const EdgeInsets.all(8),
                  borderRadius: BorderRadius.circular(30),
                  elevation: 3,
                  isExpanded: true,
                  value: controller.groupVal,
                  onChanged: (value) {
                    controller.onChangeGroup(value);
                  },
                  hint: const Text("Select Group"),
                  items: controller.groupsList.map((value) {
                    return DropdownMenuItem<GroupsModel>(
                      value: value,
                      child: Text(value.groName!),
                    );
                  }).toList(),
                  underline: Container(),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
