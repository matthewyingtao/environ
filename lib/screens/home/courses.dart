import 'package:environ/shared/components/course_card.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';

class Courses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -40,
          left: -40,
          child: Transform(
            transform: Matrix4.rotationZ(10 * pi / 12),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              "assets/leavesbg.svg",
              color: Color.fromRGBO(0, 0, 0, 0.1),
              height: 400,
              width: 400,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(height: 24.0),
              Text(
                "How to Recycle",
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(height: 24.0),
              CourseCard(
                heading: "Paper & Cardboard",
                body:
                    "This includes: \n• Newspapers and magazines \n• Corrugated cardboard \n• Office paper",
                icon: Icons.description_rounded,
                imagePath: "assets/trash_category/cardboard.jpg",
              ),
              CourseCard(
                heading: "Glass",
                body:
                    "This includes: \n• Bottles, jars and containers \n• Clear and colored Glass",
                icon: Icons.liquor_rounded,
                imagePath: "assets/trash_category/glass.jpg",
              ),
              CourseCard(
                heading: "Metal",
                body: "This includes: \n• Aluminium and tin cans \n• Aerosols",
                icon: Icons.iron_rounded,
                imagePath: "assets/trash_category/metal.jpg",
              ),
              CourseCard(
                heading: "Plastic",
                body:
                    "This includes: \n• Milk and drink bottles \n• Plastic shrink wrap",
                icon: Icons.casino_rounded,
                imagePath: "assets/trash_category/plastic.jpg",
              ),
              CourseCard(
                heading: "Reducing Waste",
                body:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                icon: Icons.delete,
                imagePath: "assets/trash_category/trash.jpg",
              ),
              SizedBox(height: 24.0),
            ],
          ),
        ),
      ],
    );
  }
}
