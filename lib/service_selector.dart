import 'package:flutter/material.dart';
import 'package:gam_app/A1_Gover_Services/S1_ShhadtMelad.dart';
class SelectServicesA1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Let's See"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                RaisedButton(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => actualService()),
                          );
                        },
                  child: Text('يلّا!'),
                ),
                Text(
                  "استخراج شهادة ميلاد ناو",
                  textDirection: TextDirection.rtl,
                  style: new TextStyle(fontSize: 20, color: Colors.redAccent),
                )
              ],
              textDirection: TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            )
          ],
        ),
      ),
    );
  }
}