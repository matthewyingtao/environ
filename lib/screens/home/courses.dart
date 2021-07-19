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
          bottom: -40,
          left: -80,
          child: Transform(
            transform: Matrix4.rotationZ(pi / 12.0),
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
                "Learn To Recycle",
                style: Theme.of(context).textTheme.headline4,
              ),
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
        ),
      ],
    );
  }
}
