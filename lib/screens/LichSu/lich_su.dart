import 'package:flutter/material.dart';

class LichSuScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LichSuScreenState();
  }
}

class LichSuScreenState extends State<LichSuScreen>{
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.only(top:16.0, bottom: 16.0),
        itemBuilder: (context, index) {
          return new Card(
            child: Column(
              children: <Widget>[
                new Text("GG")
              ],
            ),
          );
        },
      ),
    );
  }
}