import 'package:flutter/material.dart';

class MyClass extends StatefulWidget {
  @override
  _MyClassState createState() => new _MyClassState();
}

class _MyClassState extends State<MyClass> with SingleTickerProviderStateMixin {
  TextEditingController nameTextEditingController = TextEditingController();
  String _labelText;

  @override
  void initState() {
    super.initState();
    // nameTextEditingController.addListener(_hasStartedTyping);
  }

//  void _hasStartedTyping() {
//    setState(() {
//      if (nameTextEditingController.text.isNotEmpty) {
//        _labelText = 'Name';
//      } else {
//        _labelText = null;
//      }
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                autofocus: false,
                textAlign: TextAlign.start,
                onChanged: (v){
                  setState(() {
                    if(v.isNotEmpty){
                      _labelText = 'Name';
                    }else{
                      _labelText = null;
                    }
                  });

                },
                textInputAction: TextInputAction.done,
                controller: nameTextEditingController,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                  labelText: _labelText,
                  hintText: 'Name',
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.transparent, width: 1)),
                ),
              ),
            ],
          )),
    );
  }
}