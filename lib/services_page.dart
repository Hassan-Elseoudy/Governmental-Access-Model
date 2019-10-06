import 'package:flutter/material.dart';
import 'package:gam_app/A1_Gover_Services/S1_ShhadtMelad.dart';

class Services extends StatelessWidget {
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
          new Column(
            children: <Widget>[
              new Container(
                color: Colors.redAccent.shade700,
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new Text(
                      "وزارة الداخلية",
                      style: new TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new FlatButton(
                    child: new Text(
                      "إستخراج شهادة ميلاد -",
                      style: new TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ActualService()),
                          );
                        },
                  )
                ],
              ),
            new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new FlatButton(
                    child: new Text(
                      "إستخراج بطاقة الرقم القومي -",
                      style: new TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new FlatButton(
                    child: new Text(
                      "إستخراج أخري -",
                      style: new TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            
            ],
          )
        ],
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
    );
  }
}
