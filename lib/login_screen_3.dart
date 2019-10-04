import 'package:flutter/material.dart';
import 'package:gam_app/MyAccount.dart';

class LoginScreen3 extends StatefulWidget {
  @override
  _LoginScreen3State createState() => new _LoginScreen3State();
}

Map map = new Map();

class _LoginScreen3State extends State<LoginScreen3>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  Widget div_dec(double _size) {
    return new Divider(
      height: _size,
    );
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

  Widget HomePage() {
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.1), BlendMode.dstATop),
          image: AssetImage('assets/images/mountains.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 250.0),
            child: Center(
              child: Icon(
                Icons.person_pin,
                color: Colors.white,
                size: 100.0,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "الوصول الحكومي",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  " نموذج",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 150.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new OutlineButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.redAccent,
                    highlightedBorderColor: Colors.white,
                    onPressed: () => gotoSignup(),
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
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.white,
                    onPressed: () => gotoLogin(),
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
                              "تسجيل الدخول",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.redAccent,
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
      ),
    );
  }

  Widget LoginPage() {
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.05), BlendMode.dstATop),
          image: AssetImage('assets/images/mountains.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(120.0),
            child: Center(
              child: Icon(
                Icons.person_pin,
                color: Colors.redAccent,
                size: 50.0,
              ),
            ),
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: new Text(
                    "الرقم القومي",
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
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
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
                    obscureText: true,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '297XXXXXXXXXXX',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          div_dec(24),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Padding(
                  padding: const EdgeInsets.only(right: 40.0),
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
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
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
                    obscureText: true,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '*********',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          div_dec(24),
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: new FlatButton(
                  child: new Text(
                    "نسيت كلمة المرور؟",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                      fontSize: 15.0,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  onPressed: () => {},
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    color: Colors.redAccent,
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyAccount()),
                      )
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
                              "الدخول",
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
      ),
    );
  }

  Widget SignupPage() {
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
            ),
            new Text(
              'ذكر',
              style: new TextStyle(fontSize: 16.0),
            ),
            new Radio(
              value: 1,
            ),
            new Text(
              'أنثي',
              style: new TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        col(false, "الجنسيّة", "مصري", "1", new TextEditingController()),
        div_dec(20),
        col(false, "الديانة", "مسلِم/مسِيحي", "2", new TextEditingController()),
        div_dec(20),
        col(false, "محلّ الولادة", "إسم البلدة", "3",
            new TextEditingController()),
        div_dec(20),
        col(false, "تاريخ المِيلاد", "يوم/شهر/سنة", "4",
            new TextEditingController()),
        div_dec(20),
        col(true, "رقم السّر", "**********", "5", new TextEditingController()),
        div_dec(20),
        col(false, "تأكِيد رقم السّر", "**********", "6",
            new TextEditingController()),
        new Text(
          "بيانات الوالدين",
          textAlign: TextAlign.center,
          style: new TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        col(false, "اسم اﻷب", "مثال: محمّد", "7", new TextEditingController()),
        div_dec(20),
        col(false, "ديانة اﻷب", "مسلِم/مسِيحي", "8",
            new TextEditingController()),
        div_dec(20),
        col(false, "جنسيّة اﻷب", "مصري", "9", new TextEditingController()),
        div_dec(20),
        col(false, "اسم اﻷم", "مثال: مِيرنا", "10",
            new TextEditingController()),
        div_dec(20),
        col(false, "ديانة اﻷم", "مسلِمة/مسِيحية", "11",
            new TextEditingController()),
        div_dec(20),
        col(false, "جنسيّة اﻷم", "مصرية", "12", new TextEditingController()),
        div_dec(20),
        new Text(
          "بيانات المبلغ",
          textAlign: TextAlign.center,
          style: new TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        col(false, "اسم المُبلّغ", "مثال: محمّد", "13",
            new TextEditingController()),
        div_dec(20),
        col(false, "اسم اﻷب", "مثال: محمّد", "14", new TextEditingController()),
        div_dec(20),
        col(false, "اسم الجدّ أو اللقب", "مثال: محمّد", "15",
            new TextEditingController()),
        div_dec(20),
        col(false, "الرقم القومي", "15 رقم", "16", new TextEditingController()),
        div_dec(20),
        col(false, "جهة الصُدور", "مثال: القَاهرة", "17",
            new TextEditingController()),
        div_dec(20),
        col(false, "علاقته بالمَولود", "مثال: اﻷب", "18",
            new TextEditingController()),
        div_dec(20),
        col(false, "التّاريخ", "يوم/شهر/سنة", "19",
            new TextEditingController()),
        div_dec(20),
        col(false, "العنوَان", "مثال: القَاهرة", "20",
            new TextEditingController()),
        div_dec(20),
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
                  onPressed: () {
                    map.forEach((k, v) => debugPrint('${k}: ${v}'));
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

  gotoLogin() {
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  gotoSignup() {
    _controller.animateToPage(
      2,
      duration: Duration(milliseconds: 800),
      curve: Curves.bounceOut,
    );
  }

  PageController _controller =
      new PageController(initialPage: 1, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: PageView(
          controller: _controller,
          physics: new AlwaysScrollableScrollPhysics(),
          children: <Widget>[LoginPage(), HomePage(), SignupPage()],
          scrollDirection: Axis.horizontal,
        ));
  }
}
