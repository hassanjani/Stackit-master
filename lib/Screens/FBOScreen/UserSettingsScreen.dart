import 'dart:convert';
import 'dart:io';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/SplashScreen.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/Component/simpleText.dart';

class FBO_UserSettings extends StatefulWidget {
  @override
  _FBO_UserSettingsState createState() => _FBO_UserSettingsState();
}

class _FBO_UserSettingsState extends State<FBO_UserSettings> {
  bool check = true;
  DataModel model;

  TextEditingController fNamee = TextEditingController();
  TextEditingController LNamee = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController phone2 = TextEditingController();

  getDataAgain() async {
    print("Tenant_UserSettings page");
    model = await Tenant_Services().getData();
    fNamee.text = model.firstName;
    LNamee.text = model.lastName;
    email.text = model.email;
    pass.text = "";
    note.text = model.note;
    phone.text = model.phone1;
    phone2.text = model.phone2;

    setState(() {
      check = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getDataAgain();
  }

  Future<File> file;
  String status;

  choseImage() {
    cameraImage();
  }

  File _image;

  cameraImage() async {
    var image = await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,
      maxHeight: 240.0,
      maxWidth: 240.0,
    );
    setState(() {
      _image = File(image.path);
    });
    base64Image = base64Encode(_image.readAsBytesSync());
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
    print(status);
  }

  String base64Image;
  File tmpFile;

  @override
  Widget build(BuildContext context) {
    print("User Setting Screen");
    return Scaffold(
      body: check
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AircraftText("User Setting"),
                      SizedBox(height: 10),
                      Center(
                        child: Container(
                          height: 100,
                          // width: MediaQuery.of(context).size.width * 0.70,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              border: Border.all(color: Colors.blue, width: 1)),
                          child: InkWell(
                            onTap: () {
                              choseImage();
                            },
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: _image == null
                                    ? model.profilePic != null
                                        ? Image.network(
                                            model.profilePic,
                                            // height: 100,
                                            // width: MediaQuery.of(context)
                                            //         .size
                                            //         .width /
                                            //     1.6,
                                            fit: BoxFit.cover,
                                          )
                                        : Text("")
                                    : Image.file(
                                        _image,
                                        // width: MediaQuery.of(context)
                                        //         .size
                                        //         .width /
                                        //     1.6,
                                        // height: 100,
                                        fit: BoxFit.cover,
                                      )),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      //////////////////////////////////////////////////////////////////////////////////
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserProfileText("F-Name:"),
                          // SizedBox(width: 2),
                          Container(
                            height: 35,
                            width: double.infinity,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                controller: fNamee,
                                // onChanged: (val) {
                                //   fNamee = val;
                                // },
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 1.0),
                                  ),
                                  contentPadding: EdgeInsets.all(8),
                                  border: OutlineInputBorder(),
                                  hintText: model.firstName,
                                ),
                              ),
                            ),
                          ),
                          // SizedBox(width: 2),
                        ],
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserProfileText("L-Name:"),
                          SizedBox(width: 2),
                          Container(
                            height: 35,
                            width: double.infinity,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                controller: LNamee,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 1.0),
                                  ),
                                  contentPadding: EdgeInsets.all(8),
                                  border: OutlineInputBorder(),
                                  hintText: model.lastName == null
                                      ? "Last Name"
                                      : model.lastName,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserProfileText("Email:  "),
                          SizedBox(width: 2),
                          Container(
                            height: 35,
                            width: double.infinity,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                controller: email,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 1.0),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      left: 5, bottom: 5, top: 5),
                                  border: OutlineInputBorder(),
                                  hintText: model.email,
                                ),
                              ),
                            ),
                          ),
                          // SizedBox(width: 2),
                        ],
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserProfileText("C Email: "),
                          // SizedBox(width: 2),
                          Container(
                            height: 35,
                            // width: MediaQuery.of(context).size.width / 3.3,
                            width: double.infinity,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                onChanged: (c_email) {
                                  // email = c_email;
                                },
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 1.0),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      left: 5, bottom: 5, top: 5),
                                  border: OutlineInputBorder(),
                                  hintText: model.email,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserProfileText("Password:    "),
                          SizedBox(width: 2),
                          Container(
                            height: 35,
                            // width: MediaQuery.of(context).size.width / 3.3,
                            width: double.infinity,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                controller: pass,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 1.0),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      left: 5, bottom: 5, top: 5),
                                  border: OutlineInputBorder(),
                                  hintText: "Password",
                                ),
                              ),
                            ),
                          ),
                          // SizedBox(width: 2),
                        ],
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserProfileText("C-Password: "),
                          // SizedBox(width: 2),
                          Container(
                            height: 35,
                            width: double.infinity,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 1.0),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      left: 5, bottom: 5, top: 5),
                                  border: OutlineInputBorder(),
                                  hintText: "C-Password",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserProfileText("Phone #"),
                          // SizedBox(width: 2),
                          Container(
                            height: 35,
                            // width: MediaQuery.of(context).size.width / 3.3,
                            width: double.infinity,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                keyboardType: TextInputType.phone,
                                controller: phone,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 1.0),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      left: 5, bottom: 5, top: 5),
                                  border: OutlineInputBorder(),
                                  hintText: model.phone1,
                                ),
                              ),
                            ),
                          ),
                          // SizedBox(width: 2),
                        ],
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserProfileText("After Ph #"),
                          SizedBox(width: 2),
                          Container(
                            height: 35,
                            width: double.infinity,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                keyboardType: TextInputType.phone,
                                controller: phone2,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 1.0),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      left: 5, bottom: 5, top: 5),
                                  border: OutlineInputBorder(),
                                  hintText: model.phone2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserProfileText("Notes:"),
                          // SizedBox(width: 2),
                          Container(
                            height: 150,
                            width: double.infinity,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                controller: note,
                                maxLines: 5,
                                minLines: 5,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 1.0),
                                  ),
                                  border: OutlineInputBorder(),
                                  hintText: model.note,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 12),
                              width: 90,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.blue)),
                              child: TextButton(
                                onPressed: () async {
                                  // if (base64Image != null) {
                                  UpdateUserDetails();
                                  // } else {
                                  //   ScaffoldMessenger.of(context)
                                  //       .showSnackBar(SnackBar(
                                  //     content: Text("Chose Image"),
                                  //   ));
                                  // }
                                },
                                child: Text(
                                  "Submit",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  UpdateUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString('userid');
    print("called");
    print(base64Image.toString());
    var map = {
      "id": "$id",
      "first_name": fNamee.text,
      "Last_name": LNamee.text,
      "email": email.text,
      "password": pass.text,
      "phone": phone.text,
      "phone2": phone2.text,
      "notes": note.text,
      "image": "data:image/jpeg;base64,$base64Image"
    };
    String url =
        'http://wordpresswebsiteprogrammer.com/stackit/public/api/update-settings/fbo?id=$id';
    var response = await post(Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: map,
        encoding: Encoding.getByName("utf-8"));
    print(response.body.toString());
    Map<String, dynamic> data = jsonDecode(response.body);
    print(data["success"]);
    String success = data["success"].toString();
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text(response.body.toString())));
    if (success == "1") {
      print(response.statusCode);
      print('done');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          width: MediaQuery.of(context).size.width * 0.90,
          content: Text(data["message"])));
    } else {
      print("Sorry we have an error");
      print(response.statusCode);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          width: MediaQuery.of(context).size.width * 0.90,
          content: Text(data["message"])));
    }
    return response.body;
  }
}

class Tenant_Services {
  //for fetching a list of notes from server
  Future getData() async {
    final prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString('userid');
    var url = Uri.parse(
        "http://wordpresswebsiteprogrammer.com/stackit/public/api/user-settings/fbo?id=$id");
    var data = await http.get(url);
    if (data.statusCode == 200) {
      print(data.body.toString());

      final jsonData = json.decode(data.body);
      DataModel model = DataModel(
          id: jsonData['id'],
          email: jsonData['email'],
          firstName: jsonData['first_name'],
          lastName: jsonData['last_name'],
          address2: jsonData['address_2'],
          note: jsonData['note'] ?? 'Empty',
          phone1: jsonData['phone'],
          phone2: jsonData['phone2'],
          profilePic: jsonData['profile_picture']);

      return model;
    } else {
      print("Sorry we have an error");
      return null;
    }
  }
}

class DataModel {
  final int id;
  final String firstName;
  final String lastName;
  final String address;
  final String address2;
  final String country;
  final String state;
  final String postal_code;
  final String city;
  final String email;
  final String phone1;
  final String phone2;
  final String note;
  final String profilePic;

  DataModel(
      {this.id,
      this.email,
      this.firstName,
      // this.isValidator = false,
      this.lastName,
      this.address,
      this.address2,
      this.country,
      this.state,
      this.postal_code,
      this.city,
      this.note,
      this.phone1,
      this.phone2,
      this.profilePic});
}
