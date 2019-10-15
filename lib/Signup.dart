import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:gam_app/MyAccount.dart';
import 'package:gam_app/country.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gam_app/country_pickers.dart';
import 'package:gam_app/PDFBuilder.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

final Firestore db = Firestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
List<String> religions = ["الإسلام", "المسيحية", "اليهيودية", "غير ذلك"];
List<String> relatives = ["اﻷب", "الأم", "الجد", "الجدة"];
Map<String, String> dropdownBtns = new Map();
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

Map<String, TextEditingController> txtControllers =
    new Map<String, TextEditingController>();

int religionButton = -1;
Map<String, Country> _selectedDialogCountry = {
  'Nationality': CountryPickerUtils.getCountryByPhoneCode('20'),
  'Father_Nationality': CountryPickerUtils.getCountryByPhoneCode('20'),
  'Mother_Nationality': CountryPickerUtils.getCountryByPhoneCode('20')
};

Future<FirebaseUser> handleSignUp(email, password) async {
  AuthResult result = await auth.createUserWithEmailAndPassword(
      email: email, password: password);
  final FirebaseUser user = result.user;
  user.sendEmailVerification();

  assert(user != null);
  assert(await user.getIdToken() != null);

  return user;
}

//int i = 0;

class SignupPage extends StatefulWidget {
  @override
  _Signup createState() => new _Signup();
}

Map<String, dynamic> map = new Map();
int genderValue = -1;

class _Signup extends State<SignupPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

/*
  void intializeOurMap() {
    for (String key in map.keys){

  }
    map['Nationality'] = map['Father_Nationality'] = map['Mother_Nationality'] = 'مصر';
    map['Child_Religion'] = map['Father_Religion'] = map['Mother_Religion'] = 'اﻹسلام';
    map['Email'] =
    map['Password'] =
    map['Re_Password'] =
    map['Gender'] =
    map['POB'] =
    map['DOB'] =
    map['Village_Name'] = map['Center_Name']=map['Gover_Name']=map['M_Status']=map['Father_Name']=map['Mother_Name']=map['Husband_Wife_Name']=map['Card_Type']=map['Card_Number']=map['Building_Number']=map['Street_Name']=map['Apartment_Block']=map['Station_Name']=map['Governorate_Name']=map['Best_Qualification']=map['Name_Best_Qualification']=map['Date_Best_Qualification']=map['University_Name']=map['College_Name']=map['Job_Name']=map['Job_Date']=map['Job_Place']=map['Commercial_Register']=map['Commercial_Register_Number']=map['Mi_Status']=map['Mi_Number']=map['DOM']=map['DOS']= "Default";
  }
*/
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

  String _errors;
  String _warnings;

  bool _isValid() {
    map.forEach((k, v) => debugPrint('$k : $v'));
    _errors = "";
    if (EmailValidator.validate((map["Email"] as String)) == false)
      _errors += "الرجاء التأكد من البريد الالكتروني\n";
    if ((map["Password"]as String).length < 8)
      _errors += "الرجاء ادخال كلمة سر تتكون من 8 رموز على الأقل\n";
    if ((map["Re_Password"] as String) != (map["Password"] as String))
      _errors += "الرجاء التأكد من تطابق كلمة السر\n";
    if (map["Gender"] == '-1') _errors += "الرجاء اختيار النوع (ذكر/أنثى)\n";
    if (map["POB"] == "Default") _errors += "الرجاء ادخال محل الولادة\n";
    if (map["DOB"] == "Default") _errors += "الرجاء اختيار تاريخ الميلاد\n";
    if (map["Village_Name"] == "Default")
      _errors += "الرجاء اختيار اسم القرية\n";
    if (map["Center_Name"] == "Default")
      _errors += "الرجاء اختيار اسم المركز\n";
    if (map["Gover_Name"] == "Default")
      _errors += "الرجاء اختيار اسم المحافطة\n";
    if (map["M_status"] == "Default")
      _errors += "الرجاء اختيار الحالة الاجتماعية\n";
    if (map["Father_Name"] == "Default") _errors += "الرجاء اختيار اسم الأب\n";
    if (map["Mother_Name"] == "Default") _errors += "الرجاء اختيار اسم الأم\n";
    // warnings
    if (_errors == "")
      return true;
    else
      return false;
  }

  /// Returns a `Container` which contains list of items [_items]
  /// And because every `Container` needs a controller, I created list of `dropDownBtn`
  /// where each element is responsible for one list, so i needed an [idx] to differentiate
  Container dropDownBtn(List<String> _items, String key, {String def = "الإسلام"}) {
    return new Container(
      padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.70, 0, 0, 0),
      child: DropdownButton<String>(
        underline: new SizedBox(),
        value: def,
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
            dropdownBtns[key] = newVal;
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

  /// [flag]: It's mainly used to differentiate between password fields & non-password ones.
  /// [txt]: It has the main text for the component.
  /// [hint]: It contains the hint text for every component.
  /// [idx]: It was designed to get each text and save it in [map] public variable.
  /// [txtController]: Because every text needs a controller so we can keep changes in each Text Field.
  /// [_verifyText]: If we want to set validation method to each TextFormField, we can pass a function.

  Column col(bool mandatoryField, String txt, String hint, String key,
      Function _verifyText,
      // Optional Parameters
      {String def: "",
      bool obscureText: false,
      TextDirection textDirection: TextDirection.rtl,
      TextAlign textAlign: TextAlign.right}) {
    map[key] = def;
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
                    textDirection: textDirection,
                    onChanged: (value) {
                      //setState(() {
                        debugPrint('Hi1');
                        debugPrint('Hi2');
                        txtControllers[key].text = value;
                        debugPrint('Hi3');
                        debugPrint('value : ' + value);
                      //});
                      //if (_verifyText(txtControllers[key].text)) {}
                    },
                    controller: txtControllers[key],
                    obscureText: obscureText,
                    textAlign: textAlign,
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

  void _openCountryPickerDialog(String key) {
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
                    _selectedDialogCountry[key] = country;
                    map[key] = country.name;
                  }),
              itemBuilder: _buildDialogItem)),
    );
  }

  /// Main function for the sign up Page.
  @override
  Widget build(BuildContext context) {
    //intializeOurMap();
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
                    //map.forEach((k, v) => debugPrint('$k: $v'));
                    setupPDF();
                    if (_isValid()) {
                      debugPrint(
                          "-------------------------no Errors-------------------------");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyAccount()),
                      );
                    } else {
                      debugPrint(
                          "-------------------------errors-------------------------");
                      debugPrint(_errors);
                    } // display an error
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
        col(true, "الجنسية", "مصري", "Nationality", isArabicString, def: "مصر"),
        /*Container(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            children: <Widget>[
              Container(
                child: ListTile(
                  onTap: () {
                    _openCountryPickerDialog('Nationality');
                  },
                  title: _buildDialogItem(_selectedDialogCountry[0]),
                ),
              )
            ],
          ),
        ),*/
        decoration(5),
        col(true, "الديانة", "مسلم/مسيحي", "Child_Religion", isArabicString, def: "مسلم"),
        dropDownBtn(religions, 'Child_Religion'),
        decoration(20),
        col(true, "محل الولادة", "إسم البلدة", "POB", isArabicString),
        decoration(20),
        col(true, "تاريخ الميلاد", "يوم/شهر/سنة", "DOB", isArabicString),
        new FlatButton(
            onPressed: () {
              DatePicker.showDatePicker(context,
                  minTime: DateTime(1920, 1, 1),
                  maxTime: DateTime(2100, 12, 30), onChanged: (date) {
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
        col(true, "قرية", "مثال: طربنبا", "Village_Name", isArabicString),
        decoration(20),
        col(true, "قسم", "مثال: مركز دمنهور", "Center_Name", isArabicString),
        decoration(20),
        col(true, "محافظة", "مثال: البحيرة", "Gover_Name", isArabicString),
        decoration(20),
        col(true, "الحالة اﻹجتماعية", "مثال: أعزب", "M_Status", isArabicString),
        decoration(20),
        col(true, "اسم اﻷب", "مثال: محمد", "Father_Name", isArabicString),
        decoration(20),
        col(true, "ديانة اﻷب", ".", ".", isArabicString),
        dropDownBtn(religions, "Father_Religion"),
        decoration(20),
        col(true, "جنسية اﻷب", "مصري", "Father_Nationality", isArabicString, def : 'مصر'),
       /* new Container(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            children: <Widget>[
              Container(
                child: ListTile(
                  onTap: () {
                    _openCountryPickerDialog('Father_Nationality');
                  },
                  title: _buildDialogItem(_selectedDialogCountry[1]),
                ),
              ),
            ],
          ),
        ),*/
        decoration(5),
        col(true, "اسم اﻷم", "مثال: ميرنا", "Mother_Name", isArabicString),
        decoration(20),
        col(true, "ديانة اﻷم", ".", ".", isArabicString),
        dropDownBtn(religions, "Mother_Religion"),
        decoration(20),
        col(true, "جنسية اﻷم", ".", "Mother_Nationality", isArabicString, def : 'مصر'),
        /*new Container(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            children: <Widget>[
              Container(
                child: ListTile(
                  onTap: () {
                    _openCountryPickerDialog('Mother_Nationality');
                  },
                  title: _buildDialogItem(_selectedDialogCountry[2]),
                ),
              )
            ],
          ),
        ),*/
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
        col(false, "الموقف", "تحت التنجيد", "Mi_Status",
            isArabicString), // should be mandatory if boy
        decoration(20),
        col(false, "رقم بطاقة الخدمة العسكرية", "أرقام", "Mi_Number",
            isArabicString), // should be mandatory if boy
        decoration(20),
        new FlatButton(
            onPressed: () {
              DatePicker.showDatePicker(context,
                  minTime: DateTime(1920, 1, 1),
                  maxTime: DateTime(2100, 12, 30), onChanged: (date) {
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
            isArabicString),
        decoration(20),
        col(false, "اسم المؤهل", "مثال: دكتوراه فى الهندسة المدنية",
            "Name_Best_Qualification", isArabicString),
        decoration(20),
        col(false, "سنة الحصول عليه", "مثال: 2015", "Date_Best_Qualification",
            isArabicString),
        decoration(20),
        col(false, "جامعة/وزارة", "مثال: جامعة اﻹسكندرية", "University_Name",
            isArabicString),
        decoration(20),
        col(false, "كلية/معهد/مدرسة", "مثال: كلية الهندسة", "College_Name",
            isArabicString),
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
            isArabicString),
        decoration(20),
        col(false, "نوع البطاقة", "مثال: دكتوراه فى الهندسة المدنية",
            "Card_Type", isArabicString),
        decoration(20),
        col(false, "رقم البطاقة", "أرقام", "Card_Number", isArabicString),
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
        col(true, "الوظيفة", "مثال: رجل أعمال", "Job_Name", isArabicString),
        decoration(20),
        col(false, "سنة شغل الوظيفة", "مثال: 2015", "Job_Date", isArabicString),
        decoration(20),
        col(false, "جهة العمل", "مثال: وزارة الكهرباء", "Job_Place",
            isArabicString),
        decoration(20),
        col(false, "مكتب السجل التجاري", "مثال: مكتب قسم المنتزه",
            "Commercial_Register", isArabicString),
        decoration(20),
        col(false, "رقم السجل التجارى", "ثمان أرقام",
            "Commercial_Register_Number", isArabicString),
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
        col(true, "رقم العقار", "مثال: 17", "Building_Number", isArabicString),
        decoration(20),
        col(true, "إسم الشارع", "مثال: شارع المعهد الدينى", "Street_Name",
            isArabicString),
        decoration(20),
        col(true, "مجمع سكنى", "مثال: مجمّع السلام", "Apartment_Block",
            isArabicString),
        decoration(20),
        col(true, "قسم/مركز", "مثال: قسم أول الرمل", "Station_Name",
            isArabicString),
        decoration(20),
        col(true, "محافظة", "مثال: اﻹسكندرية", "Governorate_Name",
            isArabicString),
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
            isArabicString),
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
        col(true, "البريد اﻹلكتروني", "example@example.com", "Email",
            isArabicString,
            textAlign: TextAlign.left, textDirection: TextDirection.ltr),
        decoration(20),
        col(true, "رقم السر", "**********", "Password", isArabicString,
            textAlign: TextAlign.left,
            textDirection: TextDirection.ltr,
            obscureText: true),
        decoration(20),
        col(false, "تأكيد رقم السر", "**********", "Re_Password",
            isArabicString,
            textAlign: TextAlign.left,
            textDirection: TextDirection.ltr,
            obscureText: true),
        decoration(20),
      ],
    );
  }
}
