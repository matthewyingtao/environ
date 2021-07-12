import 'package:flutter/material.dart';

class TrashModal extends StatelessWidget {
  final List data;
  const TrashModal({this.data});

  @override
  Widget build(BuildContext context) {
    return this.data == null
        ? Container(
            child: Text(
              "you haven't got data",
              style: TextStyle(color: Colors.black),
            ),
          )
        : Container(
            child: Text(
              data[0]['label'],
              style: TextStyle(color: Colors.black),
            ),
          );
  }
}
