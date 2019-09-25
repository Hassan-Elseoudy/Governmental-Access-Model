import 'package:flutter/material.dart';

class actualService extends StatelessWidget {
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
