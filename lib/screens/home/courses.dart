import 'package:brewcrew/shared/components/course_card.dart';
import 'package:flutter/material.dart';

class Courses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: 24.0),
          CourseCard(
            heading: "Saving Water",
            body:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            icon: Icons.water,
          ),
          SizedBox(height: 16.0),
          CourseCard(
            heading: "Saving Water",
            body:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            icon: Icons.water,
          ),
          SizedBox(height: 16.0),
          CourseCard(
            heading: "Saving Water",
            body:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            icon: Icons.water,
          ),
          SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
