import 'package:flutter/material.dart';
import 'package:gam_app/services_page.dart';

import 'AboutProgram.dart';
import 'ContactMe.dart';
import 'Homepage.dart';
import 'Setting.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccount createState() => _MyAccount();
}

Map<String, String> status = ({
  "Email": "غير مفعّل",
  "Password": "غير مفعّل",
  "RePassword": "غير مفعّل",
  "Gender": "غير مفعّل",
  "Nationality": "غير مفعّل",
  "MotherNationality": "غير مفعّل",
  "FatherNationality": "غير مفعّل",
  "DOB": "غير مفعّل",
  "GOB": "غير مفعّل",
  "COB": "غير مفعّل",
  "GOV": "غير مفعّل",
  "City": "غير مفعّل",
  "MaritalStatusDate": "غير مفعّل",
  "MaritalStatus": "غير مفعّل",
  "Religion": "غير مفعّل",
  "MotherReligion": "غير مفعّل",
  "FatherReligion": "غير مفعّل",
  "Status": "غير مفعّل",
  "Name": "غير مفعّل",
  "FatherName": "غير مفعّل",
  "MotherName": "غير مفعّل",
  "Qualification": "غير مفعّل",
  "QualificationName": "غير مفعّل",
  "QualificationDate": "غير مفعّل",
  "QualificationFaculty": "غير مفعّل",
  "QualificationUniversity": "غير مفعّل",
  "SpouseName": "غير مفعّل",
  "CardType": "غير مفعّل",
  "CardNumber": "غير مفعّل",
  "Block": "غير مفعّل",
  "Street": "غير مفعّل",
  "BuildingNumber": "غير مفعّل",
  "Job": "غير مفعّل",
  "JobDate": "غير مفعّل",
  "JobPlace": "غير مفعّل",
  "JobOfficePlace": "غير مفعّل",
  "JobOfficeNumber": "غير مفعّل",
  "MaritalStatusNumber": "غير مفعّل",
  "GOE": "غير مفعّل",
});

class _MyAccount extends State<MyAccount> {
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("الملف الشخصي            "),
          ],
        ),
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              color: Colors.red.shade700,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new FlatButton(
                    child: new Text(
                      "الاسم من الداتا بيز",
                      style: new TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyAccount()),
                      ),
                    },
                  ),
                  new Icon(
                    Icons.person_pin,
                    size: 40,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new FlatButton(
                  child: new Text(
                    "خدماتى",
                    style: new TextStyle(fontSize: 20),
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Services()),
                    ),
                  },
                ),
              ],
            ),
            new Divider(
              height: 10,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new FlatButton(
                  child: new Text(
                    "الاعدادات",
                    style: new TextStyle(fontSize: 20),
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Setting()),
                    ),
                  },
                ),
              ],
            ),
            new Divider(
              height: 10,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new FlatButton(
                  child: new Text(
                    "اتصل بنا",
                    style: new TextStyle(fontSize: 20),
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ContactMe()),
                    ),
                  },
                ),
              ],
            ),
            new Divider(
              height: 10,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new FlatButton(
                  child: new Text(
                    "عن البرنامج",
                    style: new TextStyle(fontSize: 20),
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutProgram()),
                    ),
                  },
                ),
              ],
            ),
            new Divider(
              height: 10,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new FlatButton(
                  child: new Text(
                    "تسجيل الخروج",
                    style: new TextStyle(fontSize: 20),
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Homepage()),
                    ),
                  },
                ),
              ],
            )
          ],
        ),
      ),
      body: new Container(
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage('assets/images/mountains.jpg'),
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.4), BlendMode.dstATop),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.all(33.0),
          child: new ListView(
            children: <Widget>[
              new Card(

                color: Colors.white10,
                margin: new EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text("الاسم",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                          fontSize: 20,
                        )),
                    Divider(
                      height: 10.0,
                    ),
                    new Text("hna el asm mn database",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent.shade700,
                          fontSize: 20,
                        )),
                    new Text(
                      status["Name"]
                    ),
                  ],
                ),
              ),
              Divider(
                height: 30.0,
              ),
              new Card(
                color: Colors.white10,
                margin: new EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text("محل الولادة",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                          fontSize: 20,
                        )),
                    Divider(
                      height: 10.0,
                    ),
                    new Text("hna mn database",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent.shade700,
                          fontSize: 20,
                        )),
                    new Text(
                        status["GOB"]
                    ),
                  ],
                ),
              ),
              Divider(
                height: 30.0,
              ),
              new Card(
                color: Colors.white10,
                margin: new EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text("تاريخ الميلاد",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                          fontSize: 20,
                        )),
                    Divider(
                      height: 10.0,
                    ),
                    new Text("hna mn database",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent.shade700,
                          fontSize: 20,
                        )),
                    new Text(
                        status["DOB"]
                    ),
                  ],
                ),
              ),
              Divider(
                height: 30.0,
              ),
              new Card(
                color: Colors.white10,
                margin: new EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text("اﻹيميل",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                          fontSize: 20,
                        )),
                    Divider(
                      height: 10.0,
                    ),
                    new Text("hna mn database",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent.shade700,
                          fontSize: 20,
                        )),
                    new Text(
                        status["اﻹيميل"]
                    ),
                  ],
                ),
              ),
              Divider(
                height: 30.0,
              ),
              new Card(
                color: Colors.white10,
                margin: new EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text("الجنسية",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                          fontSize: 20,
                        )),
                    Divider(
                      height: 10.0,
                    ),
                    new Text("hna el asm mn database",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent.shade700,
                          fontSize: 20,
                        )),
                    new Text(
                        status["Nationality"]
                    ),
                  ],
                ),
              ),
              Divider(
                height: 30.0,
              ),
              new Card(
                color: Colors.white10,
                margin: new EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text("الديانة",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                          fontSize: 20,
                        )),
                    Divider(
                      height: 10.0,
                    ),
                    new Text("hna el asm mn database",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent.shade700,
                          fontSize: 20,
                        )),
                    new Text(
                        status["Religion"]
                    ),
                  ],
                ),
              ),
              Divider(
                height: 30.0,
              ),
            ],
          )),
    );
  }
}
