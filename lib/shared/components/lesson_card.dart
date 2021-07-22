import 'package:flutter/material.dart';

class LessonCard extends StatelessWidget {
  LessonCard({
    required this.icon,
    required this.body,
    required this.heading,
    required this.imagePath,
  });

  final IconData icon;
  final String body;
  final String heading;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.5),
            blurRadius: 6,
            offset: Offset(0, 6),
          ),
        ],
        image: DecorationImage(
          image: AssetImage(this.imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4), BlendMode.dstATop),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            this.heading,
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  this.body,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 16),
                child: Icon(
                  this.icon,
                  color: Colors.white,
                  size: 48,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
