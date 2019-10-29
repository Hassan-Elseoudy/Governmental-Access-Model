import 'dart:core';

import 'package:flutter/material.dart';
import 'package:gam_app/country.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gam_app/country_pickers.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:gam_app/E_Governorate.dart';

final Firestore db = Firestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

Future<FirebaseUser> handleSignUp(email, password) async {
  AuthResult result = await auth.createUserWithEmailAndPassword(
      email: email, password: password);
  final FirebaseUser user = result.user;
  await user.sendEmailVerification();
  assert(user != null);
  assert(await user.getIdToken() != null);

  return user;
}

bool isStartingApplication = true;
Governorate _initGovs;

class SignupPage extends StatefulWidget {
  @override
  _Signup createState() => new _Signup();
}

Map<String, Container> labelsMap = new Map();
Map<String, Widget> fieldsMap = new Map();
Map<String, TextEditingController> controllers = new Map();

/*String email,
    password,
    re_password,
    gender,
    nationality,
    religion,
    dob,
    gob,
    cob,
    status,
    father_name,
    father_religion,
    father_nationality,
    mother_name,
    mother_religion,
    mother_nationality,
    spouse_name,
    card_type,
    card_number,
    gov,
    city,
    block,
    street,
    building_number,
    qualification,
    qualification_name,
    qualification_date,
    qualification_university,
    qualification_faculty,
    job,
    job_date,
    job_place,
    job_office_place,
    job_office_number,
    marital_status,
    marital_status_number,
    marital_status_date,
    election_place; */

class _Signup extends State<SignupPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  /// Responsible for Flags and countries. (Open Source)
  Widget _buildDialogItem(Country country) => new Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8.0),
          SizedBox(width: 8.0),
          Flexible(child: Text(country.name))
        ],
      );

  /// Responsible to open the dialouge for flags and countries. (Open Source)
  void _openCountryPickerDialog(String _key) {
    showDialog(
      context: context,
      builder: (context) => Theme(
          data: Theme.of(context).copyWith(primaryColor: Colors.pink),
          child: CountryPickerDialog(
              titlePadding: EdgeInsets.all(8.0),
              searchCursorColor: Colors.pinkAccent,
              searchInputDecoration: InputDecoration(hintText: 'بحث...'),
              isSearchable: true,
              title: Text(
                'إبحث عن الدولة',
                textDirection: TextDirection.rtl,
              ),
              onValuePicked: (Country country) => setState(() {
                    controllers[_key].text = country.name;
                  }),
              itemBuilder: _buildDialogItem)),
    );
  }

  List<Widget> initializeEmail() {
    controllers["Email"] = new TextEditingController();
    labelsMap["Email"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "البريد الالكتروني",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["Email"] = new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextField(
              textDirection: TextDirection.ltr,
              onChanged: (value) {
                setState(() {
                  controllers["Email"].text = value;
                });
              },
              controller: controllers["Email"],
              obscureText: false,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "example@domain.com",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
    return [labelsMap["Email"],fieldsMap["Email"]];
  }

   List<Widget> initializePassword() {
    controllers["Password"] = new TextEditingController();
    labelsMap["Password"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "كلمة السر",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["Password"] = new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextField(
              textDirection: TextDirection.ltr,
              onChanged: (value) {
                setState(() {
                  controllers["Password"].text = value;
                });
              },
              controller: controllers["Password"],
              obscureText: true,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "********",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
    return [labelsMap["Password"] ,fieldsMap["Password"]];
  }

   List<Widget> initializeRePassword() {
    controllers["RePassword"] = new TextEditingController();
    labelsMap["RePassword"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "إعادة كلمة السر",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["RePassword"] = new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextField(
              textDirection: TextDirection.ltr,
              onChanged: (value) {
                setState(() {
                  controllers["RePassword"].text = value;
                });
              },
              controller: controllers["RePassword"],
              obscureText: true,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "********",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

   List<Widget> initializeGender() {
    controllers["Gender"] = new TextEditingController(text: "0");
    labelsMap["Gender"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "النوع",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["Gender"] = new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Radio(
          value: 0,
          activeColor: Colors.blue,
          groupValue: int.parse(controllers["Gender"].text),
          onChanged: (value) {
            setState(() {
              controllers["Gender"].text = value;
            });
          },
        ),
        new Text(
          'ذكر',
          style: new TextStyle(fontSize: 16.0),
        ),
        new Radio(
          value: 1,
          activeColor: Colors.pink,
          groupValue: int.parse(controllers["Gender"].text),
          onChanged: (value) {
            setState(() {
              controllers["Gender"].text = value;
            });
          },
        ),
        new Text(
          'أنثي',
          style: new TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  List<Widget> initializeNationality() {
    controllers["Nationality"] = new TextEditingController(text: "مصر");
    labelsMap["Nationality"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "الجنسيّة",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["Nationality"] = new Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Column(
        children: <Widget>[
          Container(
            child: ListTile(
              onTap: () {
                _openCountryPickerDialog('Nationality');
              },
              title: _buildDialogItem(
                  new Country(name: "مصر")),
            ),
          )
        ],
      ),
    );
    return [labelsMap["Nationality"],fieldsMap["Nationality"]];
  }

   List<Widget> initializeMotherNationality() {
    controllers["MotherNationality"] = new TextEditingController(text: "مصر");
    labelsMap["MotherNationality"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "جنسيّة اﻷم",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["MotherNationality"] = new Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Column(
        children: <Widget>[
          Container(
            child: ListTile(
              onTap: () {
                _openCountryPickerDialog('MotherNationality');
              },
              title: _buildDialogItem(
                  new Country(name: controllers["MotherNationality"].text)),
            ),
          )
        ],
      ),
    );
  return [labelsMap["MotherNationality"],fieldsMap["MotherNationality"]];
  }

   List<Widget> initializeFatherNationality() {
    controllers["FatherNationality"] = new TextEditingController(text: "مصر");
    labelsMap["FatherNationality"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "جنسيّة اﻷب",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["FatherNationality"] = new Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Column(
        children: <Widget>[
          Container(
            child: ListTile(
              onTap: () {
                _openCountryPickerDialog('FatherNationality');
              },
              title: _buildDialogItem(
                  new Country(name: controllers["FatherNationality"].text)),
            ),
          )
        ],
      ),
    );
  return [labelsMap["FatherNationality"],fieldsMap["FatherNationality"]];
  }

   List<Widget> initializeDOB() {
    controllers["DOB"] = new TextEditingController(text: "إختر التاريخ");
    labelsMap["DOB"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "تاريخ الميلاد",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["DOB"] = new FlatButton(
        onPressed: () {
          DatePicker.showDatePicker(context,
              minTime: DateTime(1920, 1, 1),
              maxTime: DateTime(2100, 12, 30), onChanged: (date) {
            setState(() {
              controllers["DOB"].text =
                  '${date.year}:${date.month}:${date.day}';
            });
          }, currentTime: DateTime.now(), locale: LocaleType.ar);
        },
        child: Text(
          controllers["DOB"].text,
          textDirection: TextDirection.rtl,
          style: TextStyle(color: Colors.black45),
        ));
  return [labelsMap["DOB"],fieldsMap["DOB"]];
  }

   List<Widget> initializeMaritalStatusDate() {
    controllers["MaritalStatusDate"] =
        new TextEditingController(text: "إختر التاريخ");
    labelsMap["MaritalStatusDate"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "تاريخ الخدمة العسكريّة",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["MaritalStatusDate"] = new FlatButton(
        onPressed: () {
          DatePicker.showDatePicker(context,
              minTime: DateTime(1920, 1, 1),
              maxTime: DateTime(2100, 12, 30), onChanged: (date) {
            setState(() {
              controllers["MaritalStatusDate"].text =
                  '${date.year}:${date.month}:${date.day}';
            });
          }, currentTime: DateTime.now(), locale: LocaleType.ar);
        },
        child: Text(
          controllers["MaritalStatusDate"].text,
          textDirection: TextDirection.rtl,
          style: TextStyle(color: Colors.black45),
        ));
  return [labelsMap["MaritalStatusDate"],fieldsMap["MaritalStatusDate"]];
  }

   List<Widget> initializeReligion() {
    controllers["Religion"] = new TextEditingController(text: "اﻹسلام");
    labelsMap["Religion"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "الديانة",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["Religion"] = new Container(
      padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.70, 0, 0, 0),
      child: DropdownButton<String>(
        underline: new SizedBox(),
        value: controllers["Religion"].text,
        icon: new Icon(
          Icons.arrow_downward,
          textDirection: TextDirection.rtl,
        ),
        iconSize: 24,
        elevation: 5,
        style: TextStyle(
          color: Colors.black,
        ),
        onChanged: (String newVal) {
          setState(() {
            controllers["Religion"].text = newVal;
          });
        },
        items: ["اﻹسلام", "المسيحية", "اليهيودية", "غير ذلك"]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
    return [labelsMap["Religion"],fieldsMap["Religion"]];

  }

   List<Widget> initializeMaritalStatus() {
    controllers["MaritalStatus"] =
        new TextEditingController(text: "مطالب للتجنيد");
    labelsMap["MaritalStatus"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "حالة الخدمة العسكرّية",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["MaritalStatus"] = new Container(
      padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.70, 0, 0, 0),
      child: DropdownButton<String>(
        underline: new SizedBox(),
        value: controllers["MaritalStatus"].text,
        icon: new Icon(
          Icons.arrow_downward,
          textDirection: TextDirection.rtl,
        ),
        iconSize: 24,
        elevation: 5,
        style: TextStyle(
          color: Colors.black,
        ),
        onChanged: (String newVal) {
          setState(() {
            controllers["MaritalStatus"].text = newVal;
          });
        },
        items: ["مطالب للتجنيد", "أنهى الخدمة", "إعفاء", "غير ذلك"]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
      return [labelsMap["MaritalStatus"],fieldsMap["MaritalStatus"]];

  }

   List<Widget> initializeMotherReligion() {
    controllers["MotherReligion"] = new TextEditingController(text: "اﻹسلام");
    labelsMap["MotherReligion"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "ديانة اﻷم",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["MotherReligion"] = new Container(
      padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.70, 0, 0, 0),
      child: DropdownButton<String>(
        underline: new SizedBox(),
        value: controllers["MotherReligion"].text,
        icon: new Icon(
          Icons.arrow_downward,
          textDirection: TextDirection.rtl,
        ),
        iconSize: 24,
        elevation: 5,
        style: TextStyle(
          color: Colors.black,
        ),
        onChanged: (String newVal) {
          setState(() {
            controllers["MotherReligion"].text = newVal;
          });
        },
        items: ["اﻹسلام", "المسيحية", "اليهيودية", "غير ذلك"]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
        return [labelsMap["MotherReligion"],fieldsMap["MotherReligion"]];

  }

   List<Widget> initializeFatherReligion() {
    controllers["FatherReligion"] = new TextEditingController(text: "اﻹسلام");
    labelsMap["FatherReligion"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "ديانة اﻷب",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["FatherReligion"] = new Container(
      padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.70, 0, 0, 0),
      child: DropdownButton<String>(
        underline: new SizedBox(),
        value: controllers["FatherReligion"].text,
        icon: new Icon(
          Icons.arrow_downward,
          textDirection: TextDirection.rtl,
        ),
        iconSize: 24,
        elevation: 5,
        style: TextStyle(
          color: Colors.black,
        ),
        onChanged: (String newVal) {
          setState(() {
            controllers["Father_Religion"].text = newVal;
          });
        },
        items: ["اﻹسلام", "المسيحية", "اليهيودية", "غير ذلك"]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
          return [labelsMap["FatherReligion"],fieldsMap["FatherReligion"]];
  }

   List<Widget> initializeStatus() {
    controllers["Status"] = new TextEditingController(text: "أعزب");
    labelsMap["Status"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "الحالة اﻹجتماعية",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["Status"] = new Container(
      padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.70, 0, 0, 0),
      child: DropdownButton<String>(
        underline: new SizedBox(),
        value: controllers["Status"].text,
        icon: new Icon(
          Icons.arrow_downward,
          textDirection: TextDirection.rtl,
        ),
        iconSize: 24,
        elevation: 5,
        style: TextStyle(
          color: Colors.black,
        ),
        onChanged: (String newVal) {
          setState(() {
            controllers["Status"].text = newVal;
          });
        },
        items: ["أعزب", "متزوّج", "مطلق", "غير ذلك"]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
    return [labelsMap["Status"],fieldsMap["Status"]];

  }

   List<Widget> initializeName() {
    controllers["Name"] = new TextEditingController();
    labelsMap["Name"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "اﻹسم",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["Name"] = new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextField(
              textDirection: TextDirection.ltr,
              onChanged: (value) {
                setState(() {
                  controllers["Name"].text = value;
                });
              },
              controller: controllers["Name"],
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "مثال / نور",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
      return [labelsMap["Name"],fieldsMap["Name"]];

  }

   List<Widget> initializeFatherName() {
    controllers["FatherName"] = new TextEditingController();
    labelsMap["FatherName"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "اسم اﻷب",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["FatherName"] = new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextField(
              textDirection: TextDirection.ltr,
              onChanged: (value) {
                setState(() {
                  controllers["FatherName"].text = value;
                });
              },
              controller: controllers["FatherName"],
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "مثال / حسن",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
    return [labelsMap["FatherName"],fieldsMap["FatherName"]];
  
  }

   List<Widget> initializeMotherName() {
    controllers["MotherName"] = new TextEditingController();
    labelsMap["MotherName"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "اسم اﻷم",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["MotherName"] = new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextField(
              textDirection: TextDirection.ltr,
              onChanged: (value) {
                setState(() {
                  controllers["MotherName"].text = value;
                });
              },
              controller: controllers["Mother_Name"],
              obscureText: false,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "مثال / ميرنا",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
      return [labelsMap["MotherName"],fieldsMap["MotherName"]];

  }

  List<Widget> initializeQualification() {
    controllers["Qualification"] = new TextEditingController();
    labelsMap["Qualification"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "أعلى مؤهل",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["Qualification"] = new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextField(
              textDirection: TextDirection.ltr,
              onChanged: (value) {
                setState(() {
                  controllers["Qualification"].text = value;
                });
              },
              controller: controllers["Qualification"],
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "مثال / دكتوراه",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
      return [labelsMap["Qualification"],fieldsMap["Qualification"]];

  }

  List<Widget> initializeQualificationName() {
    controllers["QualificationName"] = new TextEditingController();
    labelsMap["QualificationName"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "اسم المؤهل",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["QualificationName"] = new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextField(
              textDirection: TextDirection.ltr,
              onChanged: (value) {
                setState(() {
                  controllers["QualificationName"].text = value;
                });
              },
              controller: controllers["QualificationName"],
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "مثال / دكتوراه فى الهندسة المدنيّة",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
      return [labelsMap["QualificationName"],fieldsMap["QualificationName"]];

  }


  List<Widget> initializeQualificationDate() {
    controllers["QualificationDate"] = new TextEditingController();
    labelsMap["QualificationDate"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "سنة الحصول عليه",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["QualificationDate"] = new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextField(
              textDirection: TextDirection.ltr,
              onChanged: (value) {
                setState(() {
                  controllers["QualificationDate"].text = value;
                });
              },
              controller: controllers["QualificationDate"],
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "مثال / 2015",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
      return [labelsMap["QualificationDate"],fieldsMap["QualificationDate"]];

  }

  List<Widget> initializeQualificationUniversity() {
    controllers["QualificationUniversity"] = new TextEditingController();
    labelsMap["QualificationUniversity"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "جامعة / وزارة",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["QualificationUniversity"] = new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextField(
              textDirection: TextDirection.ltr,
              onChanged: (value) {
                setState(() {
                  controllers["QualificationUniversity"].text = value;
                });
              },
              controller: controllers["QualificationUniversity"],
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "مثال / جامعة اﻹسكندرية",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
      return [labelsMap["QualificationUniversity"],fieldsMap["QualificationUniversity"]];

  }

  List<Widget> initializeQualificationFaculty() {
    controllers["QualificationFaculty"] = new TextEditingController();
    labelsMap["QualificationFaculty"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "كليّة / معهد / مدرسة",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["QualificationFaculty"] = new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextField(
              textDirection: TextDirection.ltr,
              onChanged: (value) {
                setState(() {
                  controllers["QualificationFaculty"].text = value;
                });
              },
              controller: controllers["QualificationFaculty"],
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "مثال / كليّة الهندسة",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
    return [labelsMap["QualificationFaculty"],fieldsMap["QualificationFaculty"]];
  }

  List<Widget> initializeMaritalStatusNumber() {
    controllers["MaritalStatusNumber"] = new TextEditingController();
    labelsMap["MaritalStatusNumber"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "رقم الخدمة العسكريّة",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["MaritalStatusNumber"] = new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextField(
              textDirection: TextDirection.ltr,
              onChanged: (value) {
                setState(() {
                  controllers["MaritalStatusNumber"].text = value;
                });
              },
              controller: controllers["MaritalStatusNumber"],
              obscureText: false,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "أرقام",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
    return [labelsMap["MaritalStatusNumber"],fieldsMap["MaritalStatusNumber"]];
  }

  List<Widget> initializeSpouseName() {
    controllers["SpouseName"] = new TextEditingController();
    labelsMap["SpouseName"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "اسم الزوج / الزوجة",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["SpouseName"] = new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextField(
              textDirection: TextDirection.ltr,
              onChanged: (value) {
                setState(() {
                  controllers["SpouseName"].text = value;
                });
              },
              controller: controllers["SpouseName"],
              obscureText: false,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "مثال / ميرنا،حسن",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
    return [labelsMap["SpouseName"],fieldsMap["SpouseName"]];

  }

  List<Widget> initializeCardType() {
    controllers["CardType"] = new TextEditingController();
    labelsMap["CardType"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "نوع البطاقة",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["CardType"] = new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextField(
              textDirection: TextDirection.ltr,
              onChanged: (value) {
                setState(() {
                  controllers["CardType"].text = value;
                });
              },
              controller: controllers["CardType"],
              obscureText: false,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "مثال / بطاقة الرقم القومي، جواز السفر",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
    return [labelsMap["CardType"],fieldsMap["CardType"]];
  }

  List<Widget> initializeCardNumber() {
    controllers["CardNumber"] = new TextEditingController();
    labelsMap["CardNumber"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "رقم البطاقة",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["CardNumber"] = new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextField(
              textDirection: TextDirection.ltr,
              onChanged: (value) {
                setState(() {
                  controllers["CardNumber"].text = value;
                });
              },
              controller: controllers["CardNumber"],
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "أرقام",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
    return [labelsMap["CardNumber"],fieldsMap["CardNumber"]];
  }

  List<Widget> initializeBlock() {
    controllers["Block"] = new TextEditingController();
    labelsMap["Block"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "مجمّع سكنى",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["Block"] = new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextField(
              textDirection: TextDirection.ltr,
              onChanged: (value) {
                setState(() {
                  controllers["Block"].text = value;
                });
              },
              controller: controllers["Block"],
              obscureText: false,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "مثال / شبرا",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
    return [labelsMap["Block"],fieldsMap["Block"]];
  }

  List<Widget> initializeStreet() {
    controllers["Street"] = new TextEditingController();
    labelsMap["Street"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "اسم الشارع",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["Street"] = new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextField(
              textDirection: TextDirection.ltr,
              onChanged: (value) {
                setState(() {
                  controllers["Street"].text = value;
                });
              },
              controller: controllers["Street"],
              obscureText: false,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "مثال / شارع المعهد الدينى",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
    return [labelsMap["Street"],fieldsMap["Street"]];

  }

  List<Widget> initializeBuildingNumber() {
    controllers["BuildingNumber"] = new TextEditingController();
    labelsMap["BuildingNumber"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "رقم العقار",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["BuildingNumber"] = new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextField(
              textDirection: TextDirection.ltr,
              onChanged: (value) {
                setState(() {
                  controllers["BuildingNumber"].text = value;
                });
              },
              controller: controllers["BuildingNumber"],
              obscureText: false,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "مثال / 17",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
    return [labelsMap["BuildingNumber"],fieldsMap["BuildingNumber"]];
  }

  List<Widget> initializeJob() {
    controllers["Job"] = new TextEditingController();
    labelsMap["Job"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "الوظيفة",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["Job"] = new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextField(
              textDirection: TextDirection.ltr,
              onChanged: (value) {
                setState(() {
                  controllers["Job"].text = value;
                });
              },
              controller: controllers["Job"],
              obscureText: false,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "مثال / رجل أعمال",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
    return [labelsMap["Job"],fieldsMap["Job"]];
  }

  List<Widget> initializeJobDate() {
    controllers["JobDate"] = new TextEditingController();
    labelsMap["JobDate"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "سنة شغل الوظيفة",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["JobDate"] = new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextField(
              textDirection: TextDirection.ltr,
              onChanged: (value) {
                setState(() {
                  controllers["JobDate"].text = value;
                });
              },
              controller: controllers["JobDate"],
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "مثال / 2015",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
      return [labelsMap["JobDate"],fieldsMap["JobDate"]];
  }

  List<Widget> initializeJobPlace() {
    controllers["JobPlace"] = new TextEditingController();
    labelsMap["JobPlace"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "جهة العمل",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["JobPlace"] = new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextField(
              textDirection: TextDirection.ltr,
              onChanged: (value) {
                setState(() {
                  controllers["JobPlace"].text = value;
                });
              },
              controller: controllers["JobPlace"],
              obscureText: false,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "مثال / وزارة الكهرباء",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
    return [labelsMap["JobPlace"],fieldsMap["JobPlace"]];
  }

  List<Widget> initializeJobOfficePlace() {
    controllers["JobOfficePlace"] = new TextEditingController();
    labelsMap["JobOfficePlace"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "مكتب السجلّ التجاري",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["JobOfficePlace"] = new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextField(
              textDirection: TextDirection.ltr,
              onChanged: (value) {
                setState(() {
                  controllers["JobOfficePlace"].text = value;
                });
              },
              controller: controllers["JobOfficePlace"],
              obscureText: false,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "مثال / مكتب قسم المنتزه",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
    return [labelsMap["JobOfficePlace"],fieldsMap["JobOfficePlace"]];
  }

  List<Widget> initializeJobOfficeNumber() {
    controllers["JobOfficeNumber"] = new TextEditingController();
    labelsMap["JobOfficeNumber"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "رقم السجلّ التجاري",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["JobOfficeNumber"] = new Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: TextField(
              textDirection: TextDirection.ltr,
              onChanged: (value) {
                setState(() {
                  controllers["JobOfficeNumber"].text = value;
                });
              },
              controller: controllers["JobOfficeNumber"],
              obscureText: false,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "ثمان أرقام",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
    return [labelsMap["JobOfficeNumber"],fieldsMap["JobOfficeNumber"]];
  }

  List<Widget> initializeGOV() {
    controllers["GOV"] = new TextEditingController(text: "محافظة أسوان");
    labelsMap["GOV"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "المحافظة",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["GOV"] = new Container(
      padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.50, 0, 0, 0),
      child: DropdownButton<String>(
        underline: new SizedBox(),
        value: controllers["GOV"].text,
        icon: new Icon(
          Icons.arrow_downward,
          textDirection: TextDirection.rtl,
        ),
        iconSize: 24,
        elevation: 5,
        style: TextStyle(
          color: Colors.black,
        ),
        onChanged: (newValue) {
          setState(() {
            controllers["GOV"].text = newValue;
            controllers["City"].text = _initGovs.egyptGovernorates
                .where((n) => n.gov.toString() == controllers["GOV"].text)
                .first
                .cities[0]
                .toString();
          });
        },
        items: _initGovs
            .getGovernorates()
            .map((region) =>
                DropdownMenuItem<String>(child: Text(region), value: region))
            .toList(),
      ),
    );
    return [labelsMap["GOV"],fieldsMap["GOV"]];

  }

  List<Widget> initializeCity() {
    controllers["City"] = new TextEditingController(text: "أسوان");
    labelsMap["City"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "المدينة",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["City"] = new Container(
      padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.65, 0, 0, 0),
      child: DropdownButton<String>(
        underline: new SizedBox(),
        value: controllers["City"].text,
        icon: new Icon(
          Icons.arrow_downward,
          textDirection: TextDirection.rtl,
        ),
        iconSize: 24,
        elevation: 5,
        style: TextStyle(
          color: Colors.black,
        ),
        onChanged: (newValue) {
          setState(() {
            controllers["City"].text = newValue;
          });
        },
        items: _initGovs.egyptGovernorates
            .where((n) => (n.gov == controllers["GOV"].text))
            .last
            .cities
            .map((_) => DropdownMenuItem<String>(child: new Text(_), value: _))
            .toList(),
      ),
    );
    return [labelsMap["City"],fieldsMap["City"]];
  }

  List<Widget> initializeGOB() {
    controllers["GOB"] = new TextEditingController(text: "محافظة أسوان");
    labelsMap["GOB"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "محافظة الميلاد",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["GOB"] = new Container(
      padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.50, 0, 0, 0),
      child: DropdownButton<String>(
        underline: new SizedBox(),
        value: controllers["GOB"].text,
        icon: new Icon(
          Icons.arrow_downward,
          textDirection: TextDirection.rtl,
        ),
        iconSize: 24,
        elevation: 5,
        style: TextStyle(
          color: Colors.black,
        ),
        onChanged: (newValue) {
          setState(() {
            controllers["GOB"].text = newValue;
            controllers["COB"].text = _initGovs.egyptGovernorates
                .where((n) => n.gov.toString() == controllers["GOB"].text)
                .first
                .cities[0]
                .toString();
          });
        },
        items: _initGovs
            .getGovernorates()
            .map((region) =>
                DropdownMenuItem<String>(child: Text(region), value: region))
            .toList(),
      ),
    );
    return [labelsMap["GOB"],fieldsMap["GOB"]];
  }

  List<Widget> initializeCOB() {
    controllers["COB"] = new TextEditingController(text: "أسوان");
    labelsMap["COB"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "مدينة الميلاد",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["COB"] = new Container(
      padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.65, 0, 0, 0),
      child: DropdownButton<String>(
        underline: new SizedBox(),
        value: controllers["COB"].text,
        icon: new Icon(
          Icons.arrow_downward,
          textDirection: TextDirection.rtl,
        ),
        iconSize: 24,
        elevation: 5,
        style: TextStyle(
          color: Colors.black,
        ),
        onChanged: (newValue) {
          setState(() {
            controllers["COB"].text = newValue;
          });
        },
        items: _initGovs.egyptGovernorates
            .where((n) => (n.gov == controllers["GOB"].text))
            .last
            .cities
            .map((_) => DropdownMenuItem<String>(child: new Text(_), value: _))
            .toList(),
      ),
    );
    return [labelsMap["COB"],fieldsMap["COB"]];
  }

  List<Widget> initializeGOE() {
    controllers["GOE"] = new TextEditingController(text: "محافظة أسوان");
    labelsMap["GOE"] = new Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: new Text(
                "الموطن اﻹنتخابي",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    fieldsMap["GOE"] = new Container(
      padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.50, 0, 0, 0),
      child: DropdownButton<String>(
        underline: new SizedBox(),
        value: controllers["GOE"].text,
        icon: new Icon(
          Icons.arrow_downward,
          textDirection: TextDirection.rtl,
        ),
        iconSize: 24,
        elevation: 5,
        style: TextStyle(
          color: Colors.black,
        ),
        onChanged: (newValue) {
          setState(() {
            controllers["GOE"].text = newValue;
          });
        },
        items: _initGovs
            .getGovernorates()
            .map((region) =>
                DropdownMenuItem<String>(child: Text(region), value: region))
            .toList(),
      ),
    );
    return [labelsMap["GOE"],fieldsMap["GOE"]];
  }

  /// Returns `true` if every [txt] is arabic, It's not working till now.
  bool isArabicString(String txt) {
    return new RegExp(r"[\u0600-\u06FF]").hasMatch(txt) == true ? true : false;
  }

  /// Returns `Divider` for decorations purposes with a specific [size].
  Widget decoration(double size) {
    return new Divider(color: Colors.redAccent.shade400, height: size);
  }

  // List<String> MState =['ارملة','ارمل','مطلقة','مطلق','متزوجة','متزوج','عزباء','اعزب'];
  // List<String>  GoverName = ['الوادي الجديد','المنيا','المنوفية','مطروح','كفر الشيخ','قنا','القليوبية','الفيوم','الغربية','شمال سيناء	','الشرقية','السويس','سوهاج','دمياط','الدقهلية','الجيزة','جنوب سيناء	','الجيزة','بورسعيد','بني سويف	','البحيرة','البحر الأحمر','الأقصر','أسيوط','أسوان','الإسماعيلية','الإسكندرية','القاهرة'];
  List<String> errorFields = new List();
  List<String> warningFields = new List();
/*
  bool _isValid() {
    errorFields.clear();
    warningFields.clear();
    for (var entry in map.entries) {
      switch (entry.key) {
        case "Email":
          if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(entry.value.textValue)) errorFields.add(entry.key);
          break;
        case "Password":
          if (entry.value.textValue.length < 8) errorFields.add(entry.key);
          break;
        case "Re_Password":
          if (entry.value.textValue != map["Password"].textValue)
            errorFields.add(entry.key);
          break;
        case "Gender":
          if (entry.value.textValue == "-1") errorFields.add(entry.key);
          break;
        default:
          if (entry.value.textValue == "") {
            if (isMandatory[entry.key])
              errorFields.add(entry.key);
            else
              warningFields.add(entry.key);
          }
          break;
      }
    }
    return errorFields.isEmpty;
  }
*/
  /// Main function for the sign up Page.
  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
        child: new Column(
      children: <Widget>[
        Divider(
          height: 30,
        ),
        Container(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Icon(
              Icons.person_pin,
              color: Colors.redAccent,
              size: 30.0,
            ),
          ),
        ),
        new Column(
          children: initializeNationality(),
        ),
        new Column( children:  initializeEmail()),
 new Column( children:  initializePassword()),
 new Column( children:  initializeRePassword()),
 new Column( children:  initializeGender()),
 new Column( children:  initializeNationality()),
 new Column( children:  initializeMotherNationality()),
 new Column( children:  initializeFatherNationality()),
 new Column( children:  initializeDOB()),
 new Column( children:  initializeMaritalStatusDate()),
 new Column( children:  initializeReligion()),
 new Column( children:  initializeMaritalStatus()),
 new Column( children:  initializeMotherReligion()),
 new Column( children:  initializeFatherReligion()),
 new Column( children:  initializeStatus()),
 new Column( children:  initializeName()),
 new Column( children:  initializeFatherName()),
 new Column( children:  initializeMotherName()),
 new Column( children:  initializeQualification()),
 new Column( children:  initializeQualificationName()),
 new Column( children:  initializeQualificationDate()),
 new Column( children:  initializeQualificationUniversity()),
 new Column( children:  initializeQualificationFaculty()),
 new Column( children:  initializeMaritalStatusNumber()),
 new Column( children:  initializeSpouseName()),
 new Column( children:  initializeCardType()),
 new Column( children:  initializeCardNumber()),
 new Column( children:  initializeBlock()),
 new Column( children:  initializeStreet()),
 new Column( children:  initializeBuildingNumber()),
 new Column( children:  initializeJob()),
 new Column( children:  initializeJobDate()),
 new Column( children:  initializeJobPlace()),
 new Column( children:  initializeJobOfficePlace()),
 new Column( children:  initializeJobOfficeNumber()),
 new Column( children:  initializeGOV()),
 new Column( children:  initializeCity()),
 new Column( children:  initializeGOB()),
 new Column( children:  initializeCOB()),
 new Column( children:  initializeGOE()),
        Divider(
          color: Colors.white,
          height: 10,
        ),
      ],
    ));
  }
}
