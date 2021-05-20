import 'package:brewcrew/shared/components/challenge_progress_indicator.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Dashboard",
              style: Theme.of(context).textTheme.headline3
            ),
            SizedBox(height: 24.0),
            Text(
              "Daily Challenges",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline5
            ),
            SizedBox(height: 16.0),
            ChallengeProgressIndicator(
              challengeProgress: 1,
              challengeMax: 5,
              challengeTitle: "Recycle Bottles",
            ),
            SizedBox(height: 16.0),
            ChallengeProgressIndicator(
              challengeProgress: 0,
              challengeMax: 1,
              challengeTitle: "Use Public Transport",
            ),
            SizedBox(height: 16.0),
            ChallengeProgressIndicator(
              challengeProgress: 7,
              challengeMax: 7,
              challengeTitle: "Water Plants",
            ),
          ],
        ),
      ),
    );
  }
}
