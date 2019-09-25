import 'package:flutter/material.dart';

class MyAccount extends StatefulWidget {
  String name;
  @override
  _ThirdState createState() => _ThirdState(name);
}

class _ThirdState extends State<MyAccount> {
  _ThirdState(this.name);
  String name;

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: new Text('MyAccount'),
      ),
      body: new Container(
          padding: EdgeInsets.all(33.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text("الاسم",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade500,
                        fontSize: 20,
                      )),
                  Divider(
                    height: 30.0,
                  ),
                  new Text("hna el asm mn database",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: 20,
                      )),
                ],
              ),
              Divider(
                height: 30.0,
              ),
              new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text("محل الولاده",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade500,
                        fontSize: 20,
                      )),
                  Divider(
                    height: 30.0,
                  ),
                  new Text("hna mn database",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: 20,
                      )),
                ],
              ),
              Divider(
                height: 30.0,
              ),
              new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text("تاريخ الميلاد",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade500,
                        fontSize: 20,
                      )),
                  Divider(
                    height: 30.0,
                  ),
                  new Text("hna mn database",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: 20,
                      )),
                ],
              ),
              Divider(
                height: 30.0,
              ),
              new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text("رقم المستخدم للدخول",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade500,
                        fontSize: 20,
                      )),
                  Divider(
                    height: 30.0,
                  ),
                  new Text("hna mn database",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: 20,
                      )),
                ],
              ),
              Divider(
                height: 30.0,
              ),
              new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text("الجنسيه",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade500,
                        fontSize: 20,
                      )),
                  Divider(
                    height: 30.0,
                  ),
                  new Text("hna el asm mn database",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: 20,
                      )),
                ],
              ),
              Divider(
                height: 30.0,
              ),
              new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text("الجنسيه",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade500,
                        fontSize: 20,
                      )),
                  Divider(
                    height: 30.0,
                  ),
                  new Text("hna el asm mn database",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: 20,
                      )),
                ],
              ),
              Divider(
                height: 30.0,
              ),
              new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text("الديانه",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade500,
                        fontSize: 20,
                      )),
                  Divider(
                    height: 30.0,
                  ),
                  new Text("hna el asm mn database",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: 20,
                      )),
                ],
              ),
              Divider(
                height: 30.0,
              ),
            ],
          )),
    );
  }
}
