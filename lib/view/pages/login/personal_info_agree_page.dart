import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonalInfoAgreePage extends StatefulWidget {
  @override
  PersonalInfoAgree createState() => PersonalInfoAgree();
}

class PersonalInfoAgree extends State<PersonalInfoAgreePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(children: [
          Container(
            child:
              SingleChildScrollView(
                
                scrollDirection: Axis.vertical,
              )
          )
        ],)
      ),
    );
  }
}
