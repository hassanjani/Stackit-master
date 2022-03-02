import 'package:flutter_forget_pass_recover_with_verify/Services/model/subject_data_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class AppDataController extends GetxController {
  List<SubjectModel> subjectData = [];
  List<MultiSelectItem> dropDownData = [];

  getSubjectData() {
    subjectData.clear();
    dropDownData.clear();

    Map<String, dynamic> apiResponse = {
      "code": 200,
      "message": "Course subject lists.",
      "data": [
        {"subject_id": "1", "subject_name": "English"},
        {"subject_id": "2", "subject_name": "Physics"},
        {"subject_id": "3", "subject_name": "Chemistry"},
        {"subject_id": "4", "subject_name": "Geography"},
        {"subject_id": "5", "subject_name": "Math"},
        {"subject_id": "6", "subject_name": "History"},
        {"subject_id": "7", "subject_name": "Computer Science"},
        {"subject_id": "8", "subject_name": "Arts"}
      ]
    };

    if (apiResponse['code'] == 200) {
      List<SubjectModel> tempSubjectData = [];
      apiResponse['data'].forEach(
        (data) {
          tempSubjectData.add(
            SubjectModel(
              subjectId: data['subject_id'],
              subjectName: data['subject_name'],
            ),
          );
        },
      );
      print(tempSubjectData);
      subjectData.addAll(tempSubjectData);

      dropDownData = subjectData.map((subjectdata) {
        return MultiSelectItem(subjectdata, subjectdata.subjectName);
      }).toList();

      update();
    } else if (apiResponse['code'] == 400) {
      print("Show Error model why error occurred..");
    } else {
      print("show some error model like something went worng..");
    }
  }
}
