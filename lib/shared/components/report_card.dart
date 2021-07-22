import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  final IconData icon;
  final String body;
  final bool main;

  ReportCard({
    required this.icon,
    required this.body,
    required this.main,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      constraints: main
          ? BoxConstraints(minWidth: 100, maxWidth: 200)
          : BoxConstraints(minWidth: 80, maxWidth: 120),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            this.icon,
            size: main ? 48.0 : 32.0,
            color: Colors.white,
          ),
          SizedBox(height: 8.0),
          Text(
            this.body,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
