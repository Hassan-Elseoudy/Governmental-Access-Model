import 'package:flutter/material.dart';
import 'package:gam_app/MyAccount.dart';
import 'package:gam_app/country.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gam_app/country_pickers.dart';
import 'package:gam_app/PDFBuilder.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

final Firestore db = Firestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
List<String> religions = ["الإسلام", "المسيحية", "اليهيودية", "غير ذلك"];
List<String> relatives = ["اﻷب", "الأم", "الجد", "الجدة"];

List<String> dropdownBtns = ["الإسلام", "الإسلام", "الإسلام", "اﻷب"];
// Index 0 => ديانة الطفل
// Index 1 => ديانة اﻷب
// Index 2 => ديانة اﻷم
// Index 3 => علاقة المُبلّغ بالطفل

int religionButton = -1;
Country _selectedDialogCountry = CountryPickerUtils.getCountryByPhoneCode('20');

Future<FirebaseUser> handleSignUp(email, password) async {
  AuthResult result = await auth.createUserWithEmailAndPassword(
      email: email, password: password);
  final FirebaseUser user = result.user;
  user.sendEmailVerification();

  assert(user != null);
  assert(await user.getIdToken() != null);

  return user;
}

class SignupPage extends StatefulWidget {
  @override
  _Signup createState() => new _Signup();
}

Map map = new Map();
int genderValue = -1;

List<TextEditingController> txtControllers =
    new List<TextEditingController>(21);

class _Signup extends State<SignupPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  /// Returns `true` if every [txt] is arabic, It's not working till now.
  bool isArabicString(String txt) {
    return new RegExp(r"[\u0600-\u06FF]").hasMatch(txt) == true ? true : false;
  }

  /// Returns `Divider` for decorations purposes with a specific [size].
  Widget decoration(double size) {
    return new Divider(
      color: Colors.redAccent.shade400,
      height: size,
    );
  }

  /// Responsible to change the [genderValue] using [result] .
  /// If `ذكر` then [genderValue] = 0, If `أنثي` then [genderValue] = 1
  void _handleChangeGenger(result) {
    setState(() {
      genderValue = result;
      map['Gender'] = result == 0 ? 'ذكر' : 'أنثي';
    });
  }

  /// Returns a `Conainer` which contians list of items [_items]
  /// And because every `Conainer` needs a controller, I created list of `dropDownBtn`
  /// where each element is responsible for one list, so i needed an [idx] to diffrentiate
  Container dropDownBtn(List<String> _items, int idx, String key) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.70, 0, 0, 0),
      child: DropdownButton<String>(
        underline: SizedBox(),
        value: dropdownBtns[idx],
        icon: Icon(
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
            dropdownBtns[idx] = newVal;
            map[key] = newVal;
          });
        },
        items: _items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  /// [flag]: It's mainly used to diffrentiate between password fields & non-password ones.
  /// [txt]: It has the main text for the component.
  /// [hint]: It contains the hint text for every component.
  /// [idx]: It was designed to get each text and save it in [map] public variable.
  /// [txtController]: Because every text needs a controller so we can keep changes in each Text Field.
  /// [_verifyText]: If we want to set validation method to each TextField, we can pass a function.

  Column col(bool flag, String txt, String hint, String idx,
      TextEditingController txtController, Function _verifyText) {
    return new Column(
      children: <Widget>[
        new Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: new Text(
                    txt,
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
        ),
        if (txt.contains("جنس") == false &&
            txt.contains("علاق") == false &&
            txt.contains("ديانة") == false &&
            txt.contains('تاريخ') == false)
          new Container(
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
                    textDirection: TextDirection.rtl,
                    onChanged: (text) {
                      map[idx] = txtController.text;
                      if (_verifyText(txtController.text)) {
                      }
                    },
                    controller: txtController,
                    obscureText: (txt == "رقم السر" || txt == "تأكيد رقم السر")
                        ? true
                        : false,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hint,
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }

  /// Responsible for Flags and countries. (Open Source)

  Widget _buildDialogItem(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8.0),
          SizedBox(width: 8.0),
          Flexible(child: Text(country.name))
        ],
      );

  /// Responsible to open the dialouge for flags and countries. (Open Source)

  void _openCountryPickerDialog(String key) => showDialog(
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
                      _selectedDialogCountry = country;
                      map[key] = country.name;
                    }),
                itemBuilder: _buildDialogItem)),
      );

  /// Main function for the sign up Page.
  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
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
        new Text(
          "بيانات المولود",
          textAlign: TextAlign.center,
          style: new TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Radio(
              value: 0,
              activeColor: Colors.blue,
              groupValue: genderValue,
              onChanged: _handleChangeGenger,
            ),
            new Text(
              'ذكر',
              style: new TextStyle(fontSize: 16.0),
            ),
            new Radio(
              value: 1,
              activeColor: Colors.pink,
              onChanged: _handleChangeGenger,
              groupValue: genderValue,
            ),
            new Text(
              'أنثي',
              style: new TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        col(false, "الجنسية", "مصري", "Nationality",
            new TextEditingController(), isArabicString),
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            children: <Widget>[
              Container(
                child: ListTile(
                  onTap: () {
                    _openCountryPickerDialog('Nationality');
                  },
                  title: _buildDialogItem(_selectedDialogCountry),
                ),
              )
            ],
          ),
        ),
        decoration(5),
        col(false, "الديانة", "مسلم/مسيحي", "Religion",
            new TextEditingController(), isArabicString),
        dropDownBtn(religions, 0, 'Child_Religion'),
        decoration(20),
        col(false, "محل الولادة", "إسم البلدة", "POB",
            new TextEditingController(), isArabicString),
        decoration(20),
        col(false, "تاريخ الميلاد", "يوم/شهر/سنة", "DOB",
            new TextEditingController(), isArabicString),
        FlatButton(
            onPressed: () {
              DatePicker.showDatePicker(context,
                  minTime: DateTime(1920, 1, 1),
                  maxTime: DateTime(2100, 12, 31), onConfirm: (date) {
                map['DOB'] = '${date.year}:${date.month}:${date.day}';
              }, currentTime: DateTime.now(), locale: LocaleType.ar);
            },
            child: Text(
              'إختر التاريخ',
              textDirection: TextDirection.rtl,
              style: TextStyle(color: Colors.black45),
            )),
        decoration(20),
        col(true, "رقم السر", "**********", "Password",
            new TextEditingController(), isArabicString),
        decoration(20),
        col(false, "تأكيد رقم السر", "**********", "Re_Password",
            new TextEditingController(), isArabicString),
        decoration(20),
        new Text(
          "بيانات الوالدين",
          textAlign: TextAlign.center,
          style: new TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        col(false, "اسم اﻷب", "مثال: محمد", "Father_Name",
            new TextEditingController(), isArabicString),
        decoration(20),
        col(false, "ديانة اﻷب", "Father_Religion", ".",
            new TextEditingController(), isArabicString),
        dropDownBtn(religions, 1, "Father_Religion"),
        decoration(20),
        col(false, "جنسية اﻷب", "مصري", "Father_Nationality",
            new TextEditingController(), isArabicString),
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            children: <Widget>[
              Container(
                child: ListTile(
                  onTap: () {
                    _openCountryPickerDialog('Father_Nationality');
                  },
                  title: _buildDialogItem(_selectedDialogCountry),
                ),
              )
            ],
          ),
        ),
        decoration(5),
        col(false, "اسم اﻷم", "مثال: ميرنا", "10", new TextEditingController(),
            isArabicString),
        decoration(20),
        col(false, "ديانة اﻷم", "مسلمة/مسيحية", "11",
            new TextEditingController(), isArabicString),
        dropDownBtn(religions, 2, "Mother_Religion"),
        decoration(20),
        col(false, "جنسية اﻷم", "مصرية", "12", new TextEditingController(),
            isArabicString),
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            children: <Widget>[
              Container(
                child: ListTile(
                  onTap: () {
                    _openCountryPickerDialog('Mother_Nationality');
                  },
                  title: _buildDialogItem(_selectedDialogCountry),
                ),
              )
            ],
          ),
        ),
        decoration(5),
        new Text(
          "بيانات المُبلّغ",
          textAlign: TextAlign.center,
          style: new TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        col(false, "اسم المبلغ", "مثال: محمد", "13",
            new TextEditingController(), isArabicString),
        decoration(20),
        col(false, "اسم اﻷب", "مثال: محمد", "14", new TextEditingController(),
            isArabicString),
        decoration(20),
        col(false, "اسم الجد أو اللقب", "مثال: محمد", "15",
            new TextEditingController(), isArabicString),
        decoration(20),
        col(false, "الرقم القومي", "خمسة عشر رقم", "16",
            new TextEditingController(), isArabicString),
        decoration(20),
        col(false, "جهة الصدور", "مثال: القاهرة", "17",
            new TextEditingController(), isArabicString),
        decoration(20),
        col(false, "علاقته بالمولود", "مثال: اﻷب", "18",
            new TextEditingController(), isArabicString),
        dropDownBtn(relatives, 3, "Type_Of_Connection"),
        decoration(20),
        col(false, "التاريخ", "يوم/شهر/سنة", "19", new TextEditingController(),
            isArabicString),
        FlatButton(
            onPressed: () {
              DatePicker.showDatePicker(context,
                  minTime: DateTime(1920, 1, 1),
                  maxTime: DateTime(2100, 12, 31), onConfirm: (date) {
                map['DOA'] = '${date.year}:${date.month}:${date.day}';
              }, currentTime: DateTime.now(), locale: LocaleType.ar);
            },
            child: Text(
              'إختر التاريخ',
              textDirection: TextDirection.rtl,
              style: TextStyle(color: Colors.black45),
            )),
        decoration(20),
        col(false, "العنوان", "مثال: القاهرة", "Address",
            new TextEditingController(), isArabicString),
        decoration(20),
        new Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 50.0),
          alignment: Alignment.center,
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new FlatButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  color: Colors.redAccent,
                  onPressed: () async {
                    //    handleSignUp(map['4'], map['5']);
                    map.forEach((k, v) => debugPrint('$k: $v'));
                    setupPDF();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyAccount()),
                    );
                  },
                  child: new Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 20.0,
                    ),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Expanded(
                          child: Text(
                            "إنشاء حساب جديد",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
