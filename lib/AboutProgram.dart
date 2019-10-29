import 'package:flutter/material.dart';

class AboutProgram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("معلومات عنا            ")
          ],
        ),
      ),
      body: new Column(
        children: <Widget>[
          new Column(
            children: <Widget>[
              new Container(

                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child:new Column(
                  children: <Widget>[
                    new Text("تعد منصه نموذج الوصول الحكومي وجهه رئيسيه للراغبين في استخراج الاوراق المهمه التي توفر"
                        " المجهود المبذول في استخراج هذه الاوراق عن طريق التسجيل في البرنامج. ",
                        textDirection: TextDirection.rtl,
                        style:new TextStyle(
                          fontSize: 15,
                        )
                    ),
                new Container(

                   padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                 child: new Text("وقد تم اطلاق هذه المنصه في 2019 .                                 ",
                     textAlign: TextAlign.end,
                      textDirection: TextDirection.rtl,
                      style:new TextStyle(
                        fontSize: 15,
                      )
                  ),
              ),
                    new Container(

                      padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                      child: new Text("رؤيتنا ان نكون اكبر منصه الكترونيه لاستخراج الاوراق الحكوميه . ",
                         // textAlign: TextAlign.end,
                          textDirection: TextDirection.rtl,
                          style:new TextStyle(
                            fontSize: 15,
                          )
                      ),
                    ),
                  ],
                ),
              ),

//
            ],
          )
        ],
      ),

    );
  }
}
