import 'package:environ/shared/components/course_card.dart';
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
            heading: "Paper & Cardboard",
            body:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            icon: Icons.description_rounded,
            imagePath: "assets/trash_category/cardboard.jpg",
          ),
          CourseCard(
            heading: "Glass",
            body:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            icon: Icons.liquor_rounded,
            imagePath: "assets/trash_category/glass.jpg",
          ),
          CourseCard(
            heading: "Metal",
            body:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            icon: Icons.iron_rounded,
            imagePath: "assets/trash_category/metal.jpg",
          ),
          CourseCard(
            heading: "Plastic",
            body:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            icon: Icons.casino_rounded,
            imagePath: "assets/trash_category/plastic.jpg",
          ),
          CourseCard(
            heading: "Trash",
            body:
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            icon: Icons.delete,
            imagePath: "assets/trash_category/trash.jpg",
          ),
          SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
