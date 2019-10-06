import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gam_app/MyAccount.dart';

import 'package:gam_app/CountryPicker/pick.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final Firestore db = Firestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

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
int _genderValue = -1;
List<TextEditingController> txtControllers =
    new List<TextEditingController>(21);

class _Signup extends State<SignupPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  bool isArabicString(String txt) {
    return new RegExp(r"[\u0600-\u06FF]").hasMatch(txt) == true ? true : false;
  }

  Widget decoration(double _size) {
    return new Divider(
      height: _size,
    );
  }

  void _handleChangeGenger(result) {
    setState(() {
      _genderValue = result;
    });
  }

  Column col(bool flag, String txt, String hint, String idx,
      TextEditingController txtController) {
    return new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Expanded(
              child: new Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: new Text(
                  txt,
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
        new Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: Colors.redAccent,
                  width: 0.5,
                  style: BorderStyle.solid),
            ),
          ),
          padding: const EdgeInsets.only(left: 0.0, right: 10.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                child: TextField(
                  onChanged: (text) {
                    map[idx] = txtController.text;
                    debugPrint("new");
                  },
                  controller: txtController,
                  obscureText: flag,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

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
              activeColor: Colors.red,
              groupValue: _genderValue,
              onChanged: _handleChangeGenger,
            ),
            new Text(
              'ذكر',
              style: new TextStyle(fontSize: 16.0),
            ),
            new Radio(
              value: 1,
              onChanged: _handleChangeGenger,
              groupValue: _genderValue,
            ),
            new Text(
              'أنثي',
              style: new TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        col(false, "الجنسيّة", "مصري", "1", txtControllers[0]),
        Picker(),
        decoration(20),
        col(false, "الديانة", "مسلِم/مسِيحي", "2", txtControllers[1]),
        decoration(20),
        col(false, "محلّ الولادة", "إسم البلدة", "3", txtControllers[2]),
        decoration(20),
        col(false, "تاريخ المِيلاد", "يوم/شهر/سنة", "4", txtControllers[3]),
        decoration(20),
        col(true, "رقم السّر", "**********", "5", txtControllers[5]),
        decoration(20),
        col(false, "تأكِيد رقم السّر", "**********", "6", txtControllers[6]),
        new Text(
          "بيانات الوالدين",
          textAlign: TextAlign.center,
          style: new TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        col(false, "اسم اﻷب", "مثال: محمّد", "7", txtControllers[7]),
        decoration(20),
        col(false, "ديانة اﻷب", "مسلِم/مسِيحي", "8", txtControllers[8]),
        decoration(20),
        col(false, "جنسيّة اﻷب", "مصري", "9", txtControllers[9]),
        decoration(20),
        col(false, "اسم اﻷم", "مثال: مِيرنا", "10", txtControllers[10]),
        decoration(20),
        col(false, "ديانة اﻷم", "مسلِمة/مسِيحية", "11", txtControllers[11]),
        decoration(20),
        col(false, "جنسيّة اﻷم", "مصرية", "12", txtControllers[12]),
        decoration(20),
        new Text(
          "بيانات المبلغ",
          textAlign: TextAlign.center,
          style: new TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        col(false, "اسم المُبلّغ", "مثال: محمّد", "13", txtControllers[13]),
        decoration(20),
        col(false, "اسم اﻷب", "مثال: محمّد", "14", txtControllers[14]),
        decoration(20),
        col(false, "اسم الجدّ أو اللقب", "مثال: محمّد", "15",
            txtControllers[15]),
        decoration(20),
        col(false, "الرقم القومي", "15 رقم", "16", txtControllers[16]),
        decoration(20),
        col(false, "جهة الصُدور", "مثال: القَاهرة", "17", txtControllers[17]),
        decoration(20),
        col(false, "علاقته بالمَولود", "مثال: اﻷب", "18", txtControllers[18]),
        decoration(20),
        col(false, "التّاريخ", "يوم/شهر/سنة", "19", txtControllers[19]),
        decoration(20),
        col(false, "العنوَان", "مثال: القَاهرة", "20", txtControllers[20]),
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
                    handleSignUp(map['4'], map['5']);

                    map.forEach((k, v) => debugPrint('$k: $v'));
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
