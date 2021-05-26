import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {

  ReportCard({this.icon, this.body, this.main});

  final IconData icon;
  final String body;
  final bool main;


  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: main ? BoxConstraints(minWidth: 100, maxWidth: 200) : BoxConstraints(minWidth: 80, maxWidth: 120),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
      ),
      padding: EdgeInsets.all(16),
      child: AspectRatio(
        aspectRatio: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(this.icon, size: main ? 48.0 : 32.0),
            SizedBox(height: 8.0),
            Text(this.body)
          ],
        ),
      ),
    );
  }
}
