import 'package:flutter/material.dart';

class ActualService extends StatefulWidget {
  @override
  _ActualServiceState createState() => _ActualServiceState();
}

class _ActualServiceState extends State<ActualService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("شهادة المِيلاد"),
        backgroundColor: Colors.redAccent.shade700,
      ),
      
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('العودة للخلف!'),
        ),
      ),
    );
  }
}
