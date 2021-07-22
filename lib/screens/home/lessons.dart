import 'package:environ/shared/components/lesson_card.dart';
import 'package:flutter/material.dart';

class Lessons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: 24.0),
          Text(
            "Lessons",
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(height: 24.0),
          LessonCard(
            heading: "Paper & Cardboard",
            body:
                "This includes: \n• Newspapers and magazines \n• Corrugated cardboard \n• Office paper",
            icon: Icons.description_rounded,
            imagePath: "assets/trash_category/cardboard.jpg",
          ),
          LessonCard(
            heading: "Glass",
            body:
                "This includes: \n• Bottles, jars and containers \n• Clear and colored Glass",
            icon: Icons.liquor_rounded,
            imagePath: "assets/trash_category/glass.jpg",
          ),
          LessonCard(
            heading: "Metal",
            body: "This includes: \n• Aluminium and tin cans \n• Aerosols",
            icon: Icons.iron_rounded,
            imagePath: "assets/trash_category/metal.jpg",
          ),
          LessonCard(
            heading: "Plastic",
            body:
                "This includes: \n• Milk and drink bottles \n• Plastic shrink wrap",
            icon: Icons.casino_rounded,
            imagePath: "assets/trash_category/plastic.jpg",
          ),
          LessonCard(
            heading: "Reducing Waste",
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
