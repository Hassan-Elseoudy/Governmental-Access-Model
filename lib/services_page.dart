import 'package:flutter/material.dart';
import 'package:gam_app/service_selector.dart';

class Services extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Container(
    decoration: BoxDecoration(
      color: Colors.white,
      image: DecorationImage(
        colorFilter: new ColorFilter.mode(
            Colors.black.withOpacity(0.2), BlendMode.dstATop),
        image: AssetImage('assets/images/mountains.jpg'),
        fit: BoxFit.cover,
      ),
    ),
    child: new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Container(
              child: new Column(
                children: <Widget>[
                  new Icon(
                    Icons.description,
                    size: 40,
                    textDirection: TextDirection.rtl,
                  ),
                  new Text(
                    "وزارة اﻷوقاف",
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style:
                        new TextStyle(color: Colors.red.shade700, fontSize: 20),
                  ),
                  new RaisedButton(
                      child: Text("Click Here"),
                      color: Colors.red,
                      textColor: Colors.yellow,
                      splashColor: Colors.grey,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectServicesA1()),
                        );
                      }),
                ],
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            ),
            new Container(
              child: new Column(
                children: <Widget>[
                  new Icon(
                    Icons.description,
                    size: 40,
                    textDirection: TextDirection.rtl,
                  ),
                  new Text(
                    "وزارة الصحة",
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style:
                        new TextStyle(color: Colors.red.shade700, fontSize: 20),
                  ),
                  new RaisedButton(
                    child: Text("Click Here"),
                    color: Colors.red,
                    textColor: Colors.yellow,
                    splashColor: Colors.grey,
                  ),
                ],
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            ),
            new Container(
              child: new Column(
                children: <Widget>[
                  new Icon(
                    Icons.description,
                    size: 40,
                    textDirection: TextDirection.rtl,
                  ),
                  new Text(
                    "وزارة الشباب",
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style:
                        new TextStyle(color: Colors.red.shade700, fontSize: 20),
                  ),
                  new RaisedButton(
                    child: Text("Click Here"),
                    color: Colors.red,
                    textColor: Colors.yellow,
                    splashColor: Colors.grey,
                  ),
                ],
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            ),
          ],
        ),
        new Row(
          children: <Widget>[
            new Container(
              child: new Column(
                children: <Widget>[
                  new Icon(
                    Icons.description,
                    size: 40,
                    textDirection: TextDirection.rtl,
                  ),
                  new Text(
                    "وزارة البترول",
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style:
                        new TextStyle(color: Colors.red.shade700, fontSize: 20),
                  ),
                  new RaisedButton(
                    child: Text("Click Here"),
                    color: Colors.red,
                    textColor: Colors.yellow,
                    splashColor: Colors.grey,
                  ),
                ],
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            ),
            new Container(
              child: new Column(
                children: <Widget>[
                  new Icon(
                    Icons.description,
                    size: 40,
                    textDirection: TextDirection.rtl,
                  ),
                  new Text(
                    "وزارة التجارة",
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style:
                        new TextStyle(color: Colors.red.shade700, fontSize: 20),
                  ),
                  new RaisedButton(
                    child: Text("Click Here"),
                    color: Colors.red,
                    textColor: Colors.yellow,
                    splashColor: Colors.grey,
                  ),
                ],
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            ),
            new Container(
              child: new Column(
                children: <Widget>[
                  new Icon(
                    Icons.description,
                    size: 40,
                    textDirection: TextDirection.rtl,
                  ),
                  new Text(
                    "وزارة التعليم",
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style:
                        new TextStyle(color: Colors.red.shade700, fontSize: 20),
                  ),
                  new RaisedButton(
                    child: Text("Click Here"),
                    color: Colors.red,
                    textColor: Colors.yellow,
                    splashColor: Colors.grey,
                  ),
                ],
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            ),
          ],
        ),
        new Row(
          children: <Widget>[
            new Container(
              child: new Column(
                children: <Widget>[
                  new Icon(
                    Icons.description,
                    size: 40,
                    textDirection: TextDirection.rtl,
                  ),
                  new Text(
                    "وزارة التنمية",
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style:
                        new TextStyle(color: Colors.red.shade700, fontSize: 20),
                  ),
                  new RaisedButton(
                    child: Text("Click Here"),
                    color: Colors.red,
                    textColor: Colors.yellow,
                    splashColor: Colors.grey,
                  ),
                ],
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            ),
            new Container(
              child: new Column(
                children: <Widget>[
                  new Icon(
                    Icons.description,
                    size: 40,
                    textDirection: TextDirection.rtl,
                  ),
                  new Text(
                    "وزارة الكهرباء",
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style:
                        new TextStyle(color: Colors.red.shade700, fontSize: 20),
                  ),
                  new RaisedButton(
                    child: Text("Click Here"),
                    color: Colors.red,
                    textColor: Colors.yellow,
                    splashColor: Colors.grey,
                  ),
                ],
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            ),
            new Container(
              child: new Column(
                children: <Widget>[
                  new Icon(
                    Icons.description,
                    size: 40,
                    textDirection: TextDirection.rtl,
                  ),
                  new Text(
                    "وزارة التنمية",
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style:
                        new TextStyle(color: Colors.red.shade700, fontSize: 20),
                  ),
                  new RaisedButton(
                    child: Text("Click Here"),
                    color: Colors.red,
                    textColor: Colors.yellow,
                    splashColor: Colors.grey,
                  ),
                ],
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            ),
          ],
        ),
        new Row(
          children: <Widget>[
            new Container(
              child: new Column(
                children: <Widget>[
                  new Icon(
                    Icons.description,
                    size: 40,
                    textDirection: TextDirection.rtl,
                  ),
                  new Text(
                    "وزارة السياحة",
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style:
                        new TextStyle(color: Colors.red.shade700, fontSize: 20),
                  ),
                  new RaisedButton(
                    child: Text("Click Here"),
                    color: Colors.red,
                    textColor: Colors.yellow,
                    splashColor: Colors.grey,
                  ),
                ],
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            ),
            new Container(
              child: new Column(
                children: <Widget>[
                  new Icon(
                    Icons.description,
                    size: 40,
                    textDirection: TextDirection.rtl,
                  ),
                  new Text(
                    "وزارة النقل",
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style:
                        new TextStyle(color: Colors.red.shade700, fontSize: 20),
                  ),
                  new RaisedButton(
                    child: Text("Click Here"),
                    color: Colors.red,
                    textColor: Colors.yellow,
                    splashColor: Colors.grey,
                  ),
                ],
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            ),
            new Container(
              child: new Column(
                children: <Widget>[
                  new Icon(
                    Icons.description,
                    size: 40,
                    textDirection: TextDirection.rtl,
                  ),
                  new Text(
                    "وزارة العدل",
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style:
                        new TextStyle(color: Colors.red.shade700, fontSize: 20),
                  ),
                  new RaisedButton(
                    child: Text("Click Here"),
                    color: Colors.red,
                    textColor: Colors.yellow,
                    splashColor: Colors.grey,
                  ),
                ],
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            ),
          ],
        ),
      ],
    ),
    alignment: Alignment.center,
    padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
  );
}
  }
}