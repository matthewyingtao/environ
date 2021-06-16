import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  CourseCard({this.icon, this.body, this.heading});

  final IconData icon;
  final String body;
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.75),
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
            image: DecorationImage(
              image: NetworkImage(
                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.dstATop),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      this.heading,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(height: 8),
                    Text(
                      this.body,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 16),
                padding: EdgeInsets.all(8),
                child: Icon(
                  this.icon,
                  color: Colors.white,
                  size: 48,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
