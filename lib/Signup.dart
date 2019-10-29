import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:gam_app/FieldWidget.dart';
import 'package:gam_app/country.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gam_app/country_pickers.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:gam_app/E_Governorate.dart';

final Firestore db = Firestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
List<String> religions = ["اﻹسلام", "المسيحية", "اليهيودية", "غير ذلك"];
Map<String, String> dropdownBtns = new Map();

const int MALE = 0;
const int FEMALE = 1;

bool start = true;
Map<String, Country> _selectedDialogCountry = {};

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
String _governorate = "محافظة أسوان", cityName = "أسوان";
String governorateOfBirth = "محافظة أسوان", cityOfBirth = "أسوان";

class SignupPage extends StatefulWidget {
  @override
  _Signup createState() => new _Signup();
}

Map<String, Container> labelsMap = new Map();
Map<String, Widget> fieldsMap = new Map();
Map<String, TextEditingController> controllers = new Map();
String email,
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
    election_place;


//new FieldWidget(true, "البريد اﻹلكتروني", TEXT, context, hint: "example@example.com",
//textAlign: TextAlign.left, textDirection: TextDirection.ltr);

Map<String, bool> isMandatory = new Map();
int genderValue = -1;

BuildContext context;

class _Signup extends State<SignupPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  void initializeEmail() {
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
  }

  void initializePassword() {
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
  }

  void initializeRePassword() {
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

  void initializeGender() {
    controllers["Gender"] = new TextEditingController();
    labelsMap["Gender"] = new Container(
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
    fieldsMap["Gender"] = new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Radio(
          value: 0,
          activeColor: Colors.blue,
          groupValue: genderValue,
          onChanged: (value) {
            setState(() {
              genderValue = value;
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
          groupValue: genderValue,
          onChanged: (value) {
            setState(() {
              genderValue = value;
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
  bool _isValid() {
    // map.forEach((k, v) => debugPrint('$k : $v'));
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

  /// [mandatoryField]: It's mainly used to differentiate between fields.
  /// [txt]: It has the main text for the component.
  /// [hint]: It contains the hint text for every component.
  /// [idx]: It was designed to get each text and save it in [map] public variable.
  /// [txtController]: Because every text needs a controller so we can keep changes in each Text Field.
  /// [_verifyText]: If we want to set validation method to each TextFormField, we can pass a function.

  /// Responsible for Flags and countries. (Open Source)

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
        loginData("بيانات الحساب", context),
        Divider(
          color: Colors.white,
          height: 30,
        )
        /*personalData("البيانات الشخصيّة"),
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
                    if (_isValid()) {
                      debugPrint("---------------- no Errors --------------");
                      FirebaseUser user =
                          await handleSignUp(values[keyToIndex["Email"]], values[keyToIndex["Password"]]);
                      db.collection("users/${user.uid}").add({for (var entry in keyToIndex.entries) entry.key: values[entry.value]});
                    } else {
                      debugPrint("--------------- errors ----------------");
                      for (String key in errorFields) {}
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
        ),*/
        ,
        Divider(
          color: Colors.white,
          height: 10,
        ),
      ],
    ));
  }
  /*

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
        col(true, "النوع", "", "Gender", isArabicString,
            def: "-1", fieldType: GENDER),
        decoration(20),
        col(true, "الجنسية", "مصري", "Nationality", isArabicString,
            def: "مصر", fieldType: NATIONALITY),
        decoration(5),
        col(true, "الديانة", "مسلم/مسيحي", "Child_Religion", isArabicString,
            def: "اﻹسلام", fieldType: RELIGION, itemsList: religions),
        decoration(20),
        col(true, "تاريخ الميلاد", "يوم/شهر/سنة", "DOB", isArabicString,
            fieldType: DATE,
            textEditingController: new TextEditingController()),
        decoration(20),
        col(true, "محافظة الميلاد", "مثال: البحيرة", "Gover_Name",
            isArabicString),
        new Container(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.50, 0, 0, 0),
          child: DropdownButton<String>(
            underline: new SizedBox(),
            value: _governorate,
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
                governorateOfBirth = newValue;
                values[keyToIndex['Gover_Name']] = governorateOfBirth;
                cityName = _initGovs.egyptGovernorates
                    .where((n) => n.gov.toString() == _governorate)
                    .first
                    .cities[0]
                    .toString();
              });
            },
            items: _initGovs
                .getGovernorates()
                .map((region) => DropdownMenuItem<String>(
                    child: Text(region), value: region))
                .toList(),
          ),
        ),
        decoration(20),
        col(true, "مدينة الميلاد", "مثال: مدينة دمنهور", "Center_Name",
            isArabicString),
        new Container(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.65, 0, 0, 0),
          child: DropdownButton<String>(
            underline: new SizedBox(),
            value: cityName,
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
                cityOfBirth = newValue;
                values[keyToIndex['Center_Name']] = cityOfBirth;
              });
            },
            items: _initGovs.egyptGovernorates
                .where((n) => (n.gov == _governorate))
                .last
                .cities
                .map((_) =>
                    DropdownMenuItem<String>(child: new Text(_), value: _))
                .toList(),
          ),
        ),
        decoration(20),
        col(true, "الحالة اﻹجتماعية", "مثال: أعزب", "M_Status", isArabicString),
        decoration(20),
        col(true, "اسم اﻷب", "مثال: محمد", "Father_Name", isArabicString),
        decoration(20),
        col(true, "ديانة اﻷب", "", "Father_Religion", isArabicString,
            fieldType: RELIGION, def: "اﻹسلام", itemsList: religions),
        decoration(20),
        col(true, "جنسية اﻷب", "مصري", "Father_Nationality", isArabicString,
            fieldType: NATIONALITY, def: 'مصر'),
        decoration(5),
        col(true, "اسم اﻷم", "مثال: ميرنا", "Mother_Name", isArabicString),
        decoration(20),
        col(true, "ديانة اﻷم", "", "Mother_Religion", isArabicString,
            fieldType: RELIGION, def: "اﻹسلام", itemsList: religions),
        decoration(20),
        col(true, "جنسية اﻷم", "", "Mother_Nationality", isArabicString,
            fieldType: NATIONALITY, def: 'مصر'),
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
        col(false, "تاريخ الخدمة العسكرية", "", "Mi_date", isArabicString,
            textEditingController: new TextEditingController(),
            fieldType: DATE,
            def: "إختر التاريخ"),
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
        col(false, "نوع البطاقة", "مثال: مدنية، جواز السفر", "Card_Type",
            isArabicString),
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
        col(true, "محافظة", "مثال: البحيرة", "Governorate_Name",
            isArabicString),
        new Container(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.50, 0, 0, 0),
          child: DropdownButton<String>(
            underline: new SizedBox(),
            value: _governorate,
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
                _governorate = newValue;
                values[keyToIndex['Governorate_Name']] = _governorate;
                cityName = _initGovs.egyptGovernorates
                    .where((n) => n.gov.toString() == _governorate)
                    .first
                    .cities[0]
                    .toString();
              });
            },
            items: _initGovs
                .getGovernorates()
                .map((region) => DropdownMenuItem<String>(
                    child: Text(region), value: region))
                .toList(),
          ),
        ),
        decoration(20),
        col(
          true,
          "مدينة/مركز",
          "مثال: دمنهور",
          "_City_Name",
          isArabicString,
        ),
        new Container(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.65, 0, 0, 0),
          child: DropdownButton<String>(
            underline: new SizedBox(),
            value: cityName,
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
                cityName = newValue;
                values[keyToIndex['_City_Name']] = cityName;
              });
            },
            items: _initGovs.egyptGovernorates
                .where((n) => (n.gov == _governorate))
                .last
                .cities
                .map((_) =>
                    DropdownMenuItem<String>(child: new Text(_), value: _))
                .toList(),
          ),
        ),
        decoration(20),
        col(true, "مجمع سكنى", "مثال: شبرا", "Apartment_Block", isArabicString),
        decoration(20),
        col(true, "إسم الشارع", "مثال: شارع المعهد الدينى", "Street_Name",
            isArabicString),
        decoration(20),
        col(true, "رقم العقار", "مثال: 17", "Building_Number", isArabicString),
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
  }*/

  Widget loginData(String str, BuildContext context) {
    map["Email"] = new FieldWidget(true, "البريد اﻹلكتروني", TEXT, context,
        hint: "example@example.com",
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    map["Password"] = new FieldWidget(true, "رقم السر", TEXT, context,
        hint: "**********",
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
        obscureText: true);
    map["Re_Password"] = new FieldWidget(false, "تأكيد رقم السر", TEXT, context,
        hint: "**********",
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
        obscureText: true);

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
        map["Email"],
        decoration(20),
        map["Password"],
        decoration(20),
        map["Re_Password"],
        decoration(20),
      ],
    );
  }
}
