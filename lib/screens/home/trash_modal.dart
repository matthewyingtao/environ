import 'package:environ/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TrashModal extends StatelessWidget {
  final List data;
  const TrashModal({this.data});

  @override
  Widget build(BuildContext context) {
    final bool isRecyclable = this.data[0]['label'] == "trash" ? false : true;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        ),
        color: isRecyclable ? themeBlue : themeRed,
      ),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        children: [
          Text(
            isRecyclable ? "Recyclable" : "Non-Recyclable",
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          Text(
            this.data == null ? "you haven't got data" : this.data[0]['label'],
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.0),
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/cardboard.jpg"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
