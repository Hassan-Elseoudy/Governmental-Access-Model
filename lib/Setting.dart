import 'package:flutter/material.dart';
import 'package:gam_app/A1_Gover_Services/S1_ShhadtMelad.dart';
import 'package:gam_app/MyAccount.dart';
import 'package:gam_app/Edited.dart';
class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("الاعدادات            "),
          ],
        ),
      ),
      body: new Column(
        children: <Widget>[

              new Container(

                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: new Column (
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        new FlatButton(
                          child: new Text(
                            "رؤيه الملف الشخصي",
                            style: new TextStyle(fontSize: 20),
                          ),
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyAccount()),
                            ),
                          },
                        ),
                        new Icon(
                          Icons.remove_red_eye,
                          size: 20,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    new Divider(
                      height: 20,
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        new FlatButton(
                          child: new Text(
                            "تغير رقم السر",
                            style: new TextStyle(fontSize: 20),
                          ),
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Edited()),
                            ),
                          },
                        ),
                        new Icon(
                          Icons.lock_open,
                          size: 20,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    new Divider(
                      height: 20,
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        new FlatButton(
                          child: new Text(
                            "حذف الحساب",
                            style: new TextStyle(fontSize: 20),
                          ),
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Setting()),
                            ),
                          },
                        ),
                        new Icon(
                          Icons.remove_circle,
                          size: 20,
                          color: Colors.red.shade800,
                        ),
                      ],
                    ),
                  ],
                ),
              ),


        ],
      ),

    );
  }
}
