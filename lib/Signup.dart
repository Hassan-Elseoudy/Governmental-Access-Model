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

TextEditingController txtDOAController =
    new TextEditingController(text: "اختر التاريخ");
TextEditingController txtDOBController =
    new TextEditingController(text: "اختر التاريخ");
TextEditingController txtMilitaryController =
    new TextEditingController(text: "اختر التاريخ");

List<TextEditingController> txtControllers =
    new List<TextEditingController>(100000);

int religionButton = -1;
List<Country> _selectedDialogCountry = [
  CountryPickerUtils.getCountryByPhoneCode('20'),
  CountryPickerUtils.getCountryByPhoneCode('20'),
  CountryPickerUtils.getCountryByPhoneCode('20')
];

Future<FirebaseUser> handleSignUp(email, password) async {
  AuthResult result = await auth.createUserWithEmailAndPassword(
      email: email, password: password);
  final FirebaseUser user = result.user;
  user.sendEmailVerification();

  assert(user != null);
  assert(await user.getIdToken() != null);

  return user;
}

int i = 0;

class SignupPage extends StatefulWidget {
  @override
  _Signup createState() => new _Signup();
}

Map map = new Map();
int genderValue = -1;

class _Signup extends State<SignupPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  void intializeOurMap() {
    map['Nationality'] =
        map['Father_Nationality'] = map['Mother_Nationality'] = 'مصر';
    map['Child_Religion'] =
        map['Father_Religion'] = map['Mother_Religion'] = 'اﻹسلام';
map['Email']=map['Password']=map['Re_Password']=map['Gender']=map['POB']=map['DOB']=map['Village_Name']=map['Center_Name']=map['Gover_Name']=map['M_Status']=map['Father_Name']=map['Mother_Name']=map['Husband_Wife_Name']=map['Card_Type']=map['Card_Number']=map['Building_Number']=map['Street_Name']=map['Apartment_Block']=map['Station_Name']=map['Governorate_Name']=map['Best_Qualification']=map['Name_Best_Qualification']=map['Date_Best_Qualification']=map['University_Name']=map['College_Name']=map['Job_Name']=map['Job_Date']=map['Job_Place']=map['Commercial_Register']=map['Commercial_Register_Number']=map['Mi_Status']=map['Mi_Number']=map['DOM']=map['DOS']= "Default";
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
    return new Container(
      padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.70, 0, 0, 0),
      child: DropdownButton<String>(
        underline: new SizedBox(),
        value: dropdownBtns[idx],
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
  /// [_verifyText]: If we want to set validation method to each TextFormField, we can pass a function.

  Column col(bool flag, String txt, String hint, String idx,
      Function _verifyText, int i) {
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
                    onChanged: (value) {
                      setState(() {
                        debugPrint(idx);
                        txtControllers[i].text = value;
                        map[idx] = txtControllers[i].text;
                      });
                      if (_verifyText(txtControllers[i].text)) {}
                    },
                    controller: txtControllers[i],
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

  Widget _buildDialogItem(Country country) => new Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 8.0),
          SizedBox(width: 8.0),
          Flexible(child: Text(country.name))
        ],
      );

  /// Responsible to open the dialouge for flags and countries. (Open Source)

  void _openCountryPickerDialog(String key, int i) {
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
                    _selectedDialogCountry[i] = country;
                    map[key] = country.name;
                  }),
              itemBuilder: _buildDialogItem)),
    );
  }

  /// Main function for the sign up Page.
  @override
  Widget build(BuildContext context) {
    intializeOurMap();
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
        loginData("بيانات الحساب"),
        Divider(
          color: Colors.white,
          height: 30,
        ),
        personalData("البيانات الشخصيّة"),
        Divider(
          color: Colors.white,
          height: 30,
        ),
        familyData("البيانات العائلية"),
        Divider(
          color: Colors.white,
          height: 30,
        ),
        addressData("بيانات العنوان"),
        Divider(
          color: Colors.white,
          height: 30,
        ),
        scientificData("البيانات العلميّة"),
        Divider(
          color: Colors.white,
          height: 30,
        ),
        jobData("البيانات الوظيفية"),
        Divider(
          color: Colors.white,
          height: 30,
        ),
        militaryServiceData("بيانات الخدمة العسكرّية"),
        Divider(
          color: Colors.white,
          height: 30,
        ),
        electionData("البيانات اﻹنتخابية"),
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
        Divider(
          color: Colors.white,
          height: 10,
        ),
      ],
    ));
  }

  Widget personalData(String str) {
    return new Column(
      children: <Widget>[
        new Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: new Text(
            str,
            textAlign: TextAlign.center,
            style: new TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        decoration(20),
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
        decoration(20),
        col(false, "الجنسية", "مصري", "Nationality", isArabicString, i++),
        Container(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            children: <Widget>[
              Container(
                child: ListTile(
                  onTap: () {
                    _openCountryPickerDialog('Nationality', i++);
                  },
                  title: _buildDialogItem(_selectedDialogCountry[0]),
                ),
              )
            ],
          ),
        ),
        decoration(5),
        col(false, "الديانة", "مسلم/مسيحي", ".", isArabicString, i++),
        dropDownBtn(religions, 0, 'Child_Religion'),
        decoration(20),
        col(false, "محل الولادة", "إسم البلدة", "POB", isArabicString, i++),
        decoration(20),
        col(false, "تاريخ الميلاد", "يوم/شهر/سنة", "DOB", isArabicString, i++),
        new FlatButton(
            onPressed: () {
              DatePicker.showDatePicker(context,
                  minTime: DateTime(1920, 1, i++),
                  maxTime: DateTime(2100, 12, i++), onChanged: (date) {
                setState(() {
                  txtDOBController.text =
                      '${date.year}:${date.month}:${date.day}';
                });
                map['DOB'] = '${date.year}:${date.month}:${date.day}';
              }, currentTime: DateTime.now(), locale: LocaleType.ar);
            },
            child: Text(
              txtDOBController.text,
              textDirection: TextDirection.rtl,
              style: TextStyle(color: Colors.black45),
            )),
        decoration(20),
        col(false, "قرية", "مثال: طربنبا", "Village_Name", isArabicString, i++),
        decoration(20),
        col(false, "قسم", "مثال: مركز دمنهور", "Center_Name", isArabicString,
            i++),
        decoration(20),
        col(false, "محافظة", "مثال: محافظة البحيرة", "Gover_Name",
            isArabicString, i++),
        decoration(20),
        col(false, "الحالة اﻹجتماعية", "مثال: أعزب", "M_Status", isArabicString,
            i++),
        decoration(20),
        col(false, "اسم اﻷب", "مثال: محمد", "Father_Name", isArabicString, i++),
        decoration(20),
        col(false, "ديانة اﻷب", ".", ".", isArabicString, i++),
        dropDownBtn(religions, 1, "Father_Religion"),
        decoration(20),
        col(false, "جنسية اﻷب", "مصري", "Father_Nationality", isArabicString,
            i++),
        new Container(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            children: <Widget>[
              Container(
                child: ListTile(
                  onTap: () {
                    _openCountryPickerDialog('Father_Nationality', i++);
                  },
                  title: _buildDialogItem(_selectedDialogCountry[1]),
                ),
              )
            ],
          ),
        ),
        decoration(5),
        col(false, "اسم اﻷم", "مثال: ميرنا", "Mother_Name", isArabicString,
            i++),
        decoration(20),
        col(false, "ديانة اﻷم", ".", ".", isArabicString, i++),
        dropDownBtn(religions, 2, "Mother_Religion"),
        decoration(20),
        col(false, "جنسية اﻷم", ".", ".", isArabicString, i++),
        new Container(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            children: <Widget>[
              Container(
                child: ListTile(
                  onTap: () {
                    _openCountryPickerDialog('Mother_Nationality', i++);
                  },
                  title: _buildDialogItem(_selectedDialogCountry[2]),
                ),
              )
            ],
          ),
        ),
        decoration(20),
      ],
    );
  }

  Widget militaryServiceData(String str) {
    return new Column(
      children: <Widget>[
        new Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: new Text(
            str,
            textAlign: TextAlign.center,
            style: new TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        decoration(20),
        col(false, "الموقف", "تحت التنجيد", "Mi_Status", isArabicString,
            i++),
        decoration(20),
        col(false, "رقم بطاقة الخدمة العسكرية", "أرقام", "Mi_Number",
            isArabicString, i++),
        decoration(20),
        new FlatButton(
            onPressed: () {
              DatePicker.showDatePicker(context,
                  minTime: DateTime(1920, 1, i++),
                  maxTime: DateTime(2100, 12, i++), onChanged: (date) {
                setState(() {
                  txtMilitaryController.text =
                      '${date.year}:${date.month}:${date.day}';
                });
                map['DOM'] = '${date.year}:${date.month}:${date.day}';
              }, currentTime: DateTime.now(), locale: LocaleType.ar);
            },
            child: Text(
              txtDOBController.text,
              textDirection: TextDirection.rtl,
              style: TextStyle(color: Colors.black45),
            )),
        decoration(20),
      ],
    );
  }

  Widget scientificData(String str) {
    return new Column(
      children: <Widget>[
        new Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: new Text(
            str,
            textAlign: TextAlign.center,
            style: new TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        decoration(20),
        col(false, "أعلى مؤهل", "مثال: دكتوراه", "Best_Qualification",
            isArabicString, i++),
        decoration(20),
        col(false, "اسم المؤهل", "مثال: دكتوراه فى الهندسة المدنية",
            "Name_Best_Qualification", isArabicString, i++),
        decoration(20),
        col(false, "سنة الحصول عليه", "مثال: 2015", "Date_Best_Qualification",
            isArabicString, i++),
        decoration(20),
        col(false, "جامعة/وزارة", "مثال: جامعة اﻹسكندرية", "University_Name",
            isArabicString, i++),
        decoration(20),
        col(false, "كلية/معهد/مدرسة", "مثال: كلية الهندسة", "College_Name",
            isArabicString, i++),
        decoration(20),
      ],
    );
  }

  Widget familyData(String str) {
    return new Column(
      children: <Widget>[
        new Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: new Text(
            str,
            textAlign: TextAlign.center,
            style: new TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        decoration(20),
        col(false, "اسم الزوجة/الزوجة", "مثال: محمد/سمر", "Husband_Wife_Name",
            isArabicString, i++),
        decoration(20),
        col(false, "نوع البطاقة", "مثال: دكتوراه فى الهندسة المدنية",
            "Card_Type", isArabicString, i++),
        decoration(20),
        col(false, "رقم البطاقة", "أرقام", "Card_Number", isArabicString, i++),
        decoration(20),
      ],
    );
  }

  Widget jobData(String str) {
    return new Column(
      children: <Widget>[
        new Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: new Text(
            str,
            textAlign: TextAlign.center,
            style: new TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        decoration(20),
        col(false, "الوظيفة", "مثال: رجل أعمال", "Job_Name", isArabicString,
            i++),
        decoration(20),
        col(false, "سنة شغل الوظيفة", "مثال: 2015", "Job_Date", isArabicString,
            i++),
        decoration(20),
        col(false, "جهة العمل", "مثال: وزارة الكهرباء", "Job_Place",
            isArabicString, i++),
        decoration(20),
        col(false, "مكتب السجل التجاري", "مثال: مكتب قسم المنتزه",
            "Commercial_Register", isArabicString, i++),
        decoration(20),
        col(false, "رقم السجل التجارى", "ثمان أرقام",
            "Commercial_Register_Number", isArabicString, i++),
        decoration(20),
      ],
    );
  }

  Widget addressData(String str) {
    return new Column(
      children: <Widget>[
        new Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: new Text(
            str,
            textAlign: TextAlign.center,
            style: new TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        decoration(20),
        col(false, "رقم العقار", "مثال: 17", "Building_Number", isArabicString,
            i++),
        decoration(20),
        col(false, "إسم الشارع", "مثال: شارع المعهد الدينى", "Street_Name",
            isArabicString, i++),
        decoration(20),
        col(false, "مجمع سكنى", "مثال: مجمّع السلام", "Apartment_Block",
            isArabicString, i++),
        decoration(20),
        col(false, "قسم/مركز", "مثال: قسم أول الرمل", "Station_Name",
            isArabicString, i++),
        decoration(20),
        col(false, "محافظة", "مثال: اﻹسكندرية", "Governorate_Name",
            isArabicString, i++),
        decoration(20),
      ],
    );
  }

  Widget electionData(String str) {
    return new Column(
      children: <Widget>[
        new Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: new Text(
            str,
            textAlign: TextAlign.center,
            style: new TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        decoration(20),
        col(false, "الموطن اﻹنتخابي", "مثال: الجيزة", "Husband_Wife_Name",
            isArabicString, i++),
        decoration(20),
      ],
    );
  }

  Widget loginData(String str) {
    return new Column(
      children: <Widget>[
        new Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: new Text(
            str,
            textAlign: TextAlign.center,
            style: new TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        decoration(20),
        col(false, "البريد اﻹلكتروني", "example@example.com", "Email",
            isArabicString, i++),
        decoration(20),
        col(true, "رقم السر", "**********", "Password", isArabicString, i++),
        decoration(20),
        col(false, "تأكيد رقم السر", "**********", "Re_Password",
            isArabicString, i++),
        decoration(20),
      ],
    );
  }
}
