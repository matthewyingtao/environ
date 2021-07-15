import 'package:environ/shared/constants.dart';
import 'package:flutter/material.dart';

class TrashModal extends StatelessWidget {
  final List data;
  const TrashModal({this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeBlue,
      child: Text(
        this.data == null ? "you haven't got data" : data[0]['label'],
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
