import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Services/controller/app_data_controller.dart';
import 'package:flutter_forget_pass_recover_with_verify/Services/model/subject_data_model.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';

class MultiSelectDropDownScreen extends StatelessWidget {
  MultiSelectDropDownScreen({Key key}) : super(key: key);

  final AppDataController controller = Get.put(AppDataController());

  @override
  Widget build(BuildContext context) {
    List subjectData = [];

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getSubjectData();
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Multi Select DropDown"),
      ),
      body: Column(
        children: [
          GetBuilder<AppDataController>(builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: MultiSelectDialogField(
                height: 200,
                items: controller.dropDownData,
                title: const Text(
                  "Select Subject",
                  style: TextStyle(color: Colors.black),
                ),
                selectedColor: Colors.black,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                buttonIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.blue,
                ),
                buttonText: const Text(
                  "Select Your Subject",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                onConfirm: (results) {
                  subjectData = [];
                  for (var i = 0; i < results.length; i++) {
                    SubjectModel data = results[i] as SubjectModel;
                    print(data.subjectId);
                    print(data.subjectName);
                    subjectData.add(data.subjectId);
                  }
                  print("data $subjectData");

                  //_selectedAnimals = results;
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
