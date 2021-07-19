import 'package:environ/shared/components/achievement_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';

class Stats extends StatelessWidget {
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
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(height: 24.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Statistics",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    SizedBox(height: 24.0),
                    Text(
                      "All Achievements",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 16.0),
                    AchievementProgressIndicator(
                      challengeProgress: 1,
                      challengeMax: 5,
                      challengeTitle: "Scan 5 bottles",
                    ),
                    AchievementProgressIndicator(
                      challengeProgress: 1,
                      challengeMax: 15,
                      challengeTitle: "Scan 15 bottles",
                    ),
                    AchievementProgressIndicator(
                      challengeProgress: 25,
                      challengeMax: 10,
                      challengeTitle: "Scan 10 items",
                    ),
                    AchievementProgressIndicator(
                      challengeProgress: 11,
                      challengeMax: 25,
                      challengeTitle: "Scan 25 items",
                    ),
                    AchievementProgressIndicator(
                      challengeProgress: 10,
                      challengeMax: 10,
                      challengeTitle: "Scan 10 red recyclables",
                    ),
                    AchievementProgressIndicator(
                      challengeProgress: 2,
                      challengeMax: 5,
                      challengeTitle: "Open the app on 5 different days",
                    ),
                    AchievementProgressIndicator(
                      challengeProgress: 1,
                      challengeMax: 5,
                      challengeTitle: "Scan 5 bottles",
                    ),
                    AchievementProgressIndicator(
                      challengeProgress: 1,
                      challengeMax: 15,
                      challengeTitle: "Scan 15 bottles",
                    ),
                    AchievementProgressIndicator(
                      challengeProgress: 25,
                      challengeMax: 10,
                      challengeTitle: "Scan 10 items",
                    ),
                    AchievementProgressIndicator(
                      challengeProgress: 11,
                      challengeMax: 25,
                      challengeTitle: "Scan 25 items",
                    ),
                    AchievementProgressIndicator(
                      challengeProgress: 10,
                      challengeMax: 10,
                      challengeTitle: "Scan 10 red recyclables",
                    ),
                    AchievementProgressIndicator(
                      challengeProgress: 2,
                      challengeMax: 5,
                      challengeTitle: "Open the app on 5 different days",
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
