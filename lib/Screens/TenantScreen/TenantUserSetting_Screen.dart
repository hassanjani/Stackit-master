import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_forget_pass_recover_with_verify/Screens/SplashScreen.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/Component/simpleText.dart';

class Tenant_UserSettings extends StatefulWidget {
  @override
  _Tenant_UserSettingsState createState() => _Tenant_UserSettingsState();
}

class _Tenant_UserSettingsState extends State<Tenant_UserSettings> {
  bool check = true;
  DataModel model;

  TextEditingController fNamee = TextEditingController();
  TextEditingController LNamee = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController postal_code = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController cityy = TextEditingController();
  TextEditingController phone2 = TextEditingController();
  // TextEditingController ide = TextEditingController();

  String country, state;

  getDataAgain() async {
    print("Tenant_UserSettings page");
    model = await Tenant_Services().getData();
    fNamee.text = model.firstName;
    LNamee.text = model.lastName;
    address1.text = model.address;
    address2.text = model.address2;
    postal_code.text = model.postal_code;
    email.text = model.email;
    cityy.text = model.city;
    pass.text = "";
    note.text = model.note;
    phone.text = model.phone1;
    phone2.text = model.phone2;
    // ide.text = model.id.toString();

    country = model.country;
    state = model.state;

    setState(() {
      check = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getDataAgain();
    getCountries();
    getStates("");
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
    print("Company Screen");
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AircraftText("User Setting"),
                      // SizedBox(height: 10),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // UserProfile("Profile Picture"),
                            // UserSetText("Profile Picture"),
                            // SizedBox(width: 2),
                            Container(
                              height: 100,
                              // width: MediaQuery.of(context).size.width * 0.70,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  border:
                                      Border.all(color: Colors.blue, width: 1)),
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
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      //////////////////////////////////////////////////////////////////////////////////
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserProfileText("First Name:"),
                          // SizedBox(width: 2),
                          Container(
                            height: 35,
                            // width: MediaQuery.of(context).size.width * 0.70,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
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
                        ],
                      ),
                      SizedBox(height: 10),
                      //////////////////////////////////////////////////////////////////////////////////
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserProfileText("Last Name:"),
                          // SizedBox(width: 2),
                          Container(
                            height: 35,
                            // width: MediaQuery.of(context).size.width * 0.70,
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
                                  hintText: model.lastName,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      //////////////////////////////////////////////////////////////////////////////////
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserProfileText("Address 1:"),
                          SizedBox(width: 2),
                          Container(
                            height: 35,
                            // width: MediaQuery.of(context).size.width * 0.70,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                controller: address1,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 1.0),
                                  ),
                                  contentPadding: EdgeInsets.all(8),
                                  border: OutlineInputBorder(),
                                  hintText: model.address,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      //////////////////////////////////////////////////////////////////////////////////
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserProfileText("Address 2:"),
                          // SizedBox(width: 2),
                          Container(
                            height: 35,
                            // width: MediaQuery.of(context).size.width * 0.70,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                controller: address2,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 1.0),
                                  ),
                                  contentPadding: EdgeInsets.all(8),
                                  border: OutlineInputBorder(),
                                  hintText: model.address2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      //////////////////////////////////////////////////////////////////////////////////
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserProfileText("Country:"),
                          // SizedBox(width: 2),
                          Container(
                            height: 35,
                            // width: MediaQuery.of(context).size.width * 0.70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(5),
                                right: Radius.circular(5),
                              ),
                              border:
                                  Border.all(color: Colors.blue, width: 1.0),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: DropdownButton(
                                  isExpanded: true,
                                  hint: Text(model
                                      .country), // Not necessary for Option 1
                                  value: selectedCountry,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedCountry = newValue;
                                      getStates(selectedCountry);
                                      // Provider.of<TenantScheduleProvider>(context,listen: false).onchange("Tid", newValue);
                                    });
                                  },
                                  items: data.map((value) {
                                    return DropdownMenuItem(
                                      value: value["id"].toString(),
                                      child: Text(value["value"],
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600)),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          // SizedBox(width: 2),
                        ],
                      ),
                      SizedBox(height: 10),
                      //////////////////////////////////////////////////////////////////////////////////
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserProfileText("State:   "),
                          // SizedBox(width: 2),
                          Container(
                            height: 35,
                            // width: MediaQuery.of(context).size.width * 0.70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(5),
                                right: Radius.circular(5),
                              ),
                              border: Border.all(color: Colors.blue, width: 1),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: DropdownButton(
                                  isExpanded: true,
                                  hint: Text(model
                                      .state), // Not necessary for Option 1
                                  value: selectedState,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedState = newValue;
                                      // Provider.of<TenantScheduleProvider>(context,listen: false).onchange("Tid", newValue);
                                    });
                                  },
                                  items: StatesData.map((value) {
                                    return DropdownMenuItem(
                                      value: value["id"].toString(),
                                      child: Text(value["value"],
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600)),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      //////////////////////////////////////////////////////////////////////////////////
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserProfileText("Post zip:"),
                          // SizedBox(width: 2),
                          Container(
                            height: 35,
                            // width: MediaQuery.of(context).size.width * 0.70,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                controller: postal_code,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 1.0),
                                  ),
                                  contentPadding: EdgeInsets.all(8),
                                  border: OutlineInputBorder(),
                                  hintText: model.postal_code,
                                ),
                              ),
                            ),
                          ),
                          // SizedBox(width: 2),
                        ],
                      ),
                      SizedBox(height: 10),
                      //////////////////////////////////////////////////////////////////////////////////
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserProfileText("City:     "),
                          // SizedBox(width: 2),
                          Container(
                            height: 35,
                            // width: MediaQuery.of(context).size.width * 0.70,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                controller: cityy,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.blue, width: 1.0),
                                  ),
                                  contentPadding: EdgeInsets.all(8),
                                  border: OutlineInputBorder(),
                                  hintText: model.city,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      //////////////////////////////////////////////////////////////////////////////////
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserProfileText("Email:     "),
                          SizedBox(width: 2),
                          Container(
                            height: 35,
                            // width: MediaQuery.of(context).size.width * 0.70,
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
                      //////////////////////////////////////////////////////////////////////////////////
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserProfileText("Confirm Email:"),
                          // SizedBox(width: 2),
                          Container(
                            height: 35,
                            // width: MediaQuery.of(context).size.width * 0.70,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                // onChanged: (c_email) {
                                //   // email = c_email;
                                // },
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
                      //////////////////////////////////////////////////////////////////////////////////
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserProfileText("Password:      "),
                          // SizedBox(width: 2),
                          Container(
                            height: 35,
                            // width: MediaQuery.of(context).size.width * 0.70,
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
                      //////////////////////////////////////////////////////////////////////////////////
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserProfileText("C-Password:  "),
                          SizedBox(width: 2),
                          Container(
                            height: 35,
                            // width: MediaQuery.of(context).size.width * 0.70,
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
                      //////////////////////////////////////////////////////////////////////////////////
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserProfileText("Phone #"),
                          // SizedBox(width: 2),
                          Container(
                            height: 35,
                            // width: MediaQuery.of(context).size.width * 0.70,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
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
                      //////////////////////////////////////////////////////////////////////////////////
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserProfileText("After Ph #"),
                          // SizedBox(width: 2),
                          Container(
                            height: 35,
                            // width: MediaQuery.of(context).size.width * 0.70,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
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
                      //////////////////////////////////////////////////////////////////////////////////
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UserProfileText("Notes:"),
                          // SizedBox(width: 2),
                          Container(
                            height: 150,
                            // width: MediaQuery.of(context).size.width * 0.70,
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
                      //////////////////////////////////////////////////////////////////////////////////
                      Center(
                        child: Container(
                          width: 90,
                          height: 40,
                          margin: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                              color: Colors.blue.shade500,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.blue)),
                          child: TextButton(
                            onPressed: () async {
                              if (base64Image != null) {
                                UpdateUserDetails();
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Chose Image"),
                                ));
                              }
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
      "last_name": LNamee.text,
      "address": address1.text,
      "address_2": address2.text,
      "country": selectedCountry,
      "state": selectedState,
      "city": cityy,
      "postal_code": postal_code.text,
      "email": email.text,
      "password": pass.text,
      "phone": phone.text,
      "phone2": phone2.text,
      "notes": note.text,
      "image": "data:image/jpeg;base64,$base64Image"
    };
    String url =
        'http://wordpresswebsiteprogrammer.com/stackit/public/api/update-settings/tenant?id=$id';
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

  String selectedCountry;
  List data = List();
  Future getCountries() async {
    var response = await http.get(
        "http://wordpresswebsiteprogrammer.com/stackit/public/api/countries",
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    print(response.statusCode);
    print(response.body.toString());

    setState(() {
      data = jsonData;
    });

    print(jsonData);

    return "success";
  }

  String selectedState;
  List StatesData = List();
  Future getStates(String country) async {
    var map = {"country": "USA"};
    var response = await http.get(
      "http://wordpresswebsiteprogrammer.com/stackit/public/api/states?country=$country",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
    );
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    print(response.statusCode);
    print(response.body.toString());
    String a;
    selectedState = a;
    setState(() {
      StatesData = jsonData;
    });
    print(jsonData);
    return "success";
  }
}

class Tenant_Services {
  //for fetching a list of notes from server
  Future getData() async {
    final prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString('userid');
    var url = Uri.parse(
        "http://wordpresswebsiteprogrammer.com/stackit/public/api/user-settings/tenant?id=$id");
    var data = await http.get(url);
    if (data.statusCode == 200) {
      print(data.body.toString());

      final jsonData = json.decode(data.body);
      DataModel model = DataModel(
          id: jsonData['id'],
          email: jsonData['email'],
          firstName: jsonData['first_name'],
          lastName: jsonData['last_name'],
          address: jsonData['address'],
          address2: jsonData['address_2'],
          country: jsonData['country'],
          state: jsonData['state'],
          city: jsonData['city'],
          postal_code: jsonData['postal_code'],
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
// Center(
//   child: Container(
//     width: 90,
//     height: 40,
//     margin: EdgeInsets.all(12),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(10),
//       color: Colors.red.shade300,
//     ),
//     child: TextButton(
//       onPressed: () async {
//         SharedPreferences prefs =
//             await SharedPreferences.getInstance();
//         prefs.remove("selectedTypeUid");
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) {
//           return SplashScreen();
//         }));
//       },
//       child: Text(
//         "Logout",
//         style: TextStyle(color: Colors.black),
//       ),
//     ),
//   ),
// ),
