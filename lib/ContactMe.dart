import 'package:flutter/material.dart';
import 'package:gam_app/A1_Gover_Services/S1_ShhadtMelad.dart';
import 'package:gam_app/MyAccount.dart';
class ContactMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text("تواصل معنا            ")
            ],
          ),
        ),
        body: new Column(

            children: <Widget>[
              new Column(

                  children: <Widget>[


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
                              textDirection: TextDirection.rtl,

                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "الاسم بالكامل ",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]
              ),
              new Divider(
                height: 20,
              ),
              new Column(

                  children: <Widget>[


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
                              textDirection: TextDirection.rtl,

                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "البريد الالكتروني ",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]
              ),
              new Divider(
                height: 20,
              ),
              new Column(

                  children: <Widget>[


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
                              textDirection: TextDirection.rtl,

                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: " +20رقم الهاتف ",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]
              ),
              new Divider(
                height: 20,
              ),
              new Column(

                  children: <Widget>[

                    new Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(left: 150.0, right:00.0, top: 0),
                     // alignment: Alignment.center,

                       child: new Text("الرساله            ",
                         style: new TextStyle(fontSize: 20,
                           color: Colors.green
                        ),
                       ),
                    ),
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

                        textDirection: TextDirection.rtl,
                            maxLines: 3,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueGrey, width: 5.0),
                          ),
                          hintText: "  ",

                          hintStyle: TextStyle(color: Colors.grey),

                              helperText: 'سوف يتم الرد في اقرب وقت ',
                              labelText: '',
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.green,
                              ),
//الرساله
                              //سيتم الرد في اقرب وقت
                                //
//                            textDirection: TextDirection.rtl,
//
//                              maxLines: 5,
//                              textAlign: TextAlign.right,
//                              decoration: InputDecoration(
//                                border: InputBorder.none,
//                                hintText: "الرساله ",
//                                hintStyle: TextStyle(color: Colors.grey),

                        ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]
              ),
              new Divider(
                height: 20,
              ),
            ]
        )


    );
  }
}
