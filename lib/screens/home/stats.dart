import 'package:environ/shared/components/achievement_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Stats extends StatelessWidget {
  const Stats({Key? key}) : super(key: key);

  Future<void> isFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('first_time', true);
  }

  @override
  Widget build(BuildContext context) {
    isFirstTime();

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const SizedBox(height: 24.0),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Statistics",
                style: Theme.of(context).textTheme.headline3,
              ),
              const SizedBox(height: 24.0),
              Text(
                "All Achievements",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 16.0),
              const AchievementProgressIndicator(
                challengeProgress: 1,
                challengeMax: 5,
                challengeTitle: "Scan 5 bottles",
              ),
              const AchievementProgressIndicator(
                challengeProgress: 1,
                challengeMax: 15,
                challengeTitle: "Scan 15 bottles",
              ),
              const AchievementProgressIndicator(
                challengeProgress: 25,
                challengeMax: 10,
                challengeTitle: "Scan 10 items",
              ),
              const AchievementProgressIndicator(
                challengeProgress: 11,
                challengeMax: 25,
                challengeTitle: "Scan 25 items",
              ),
              const AchievementProgressIndicator(
                challengeProgress: 10,
                challengeMax: 10,
                challengeTitle: "Scan 10 red recyclables",
              ),
              const AchievementProgressIndicator(
                challengeProgress: 2,
                challengeMax: 5,
                challengeTitle: "Open the app on 5 different days",
              ),
              const AchievementProgressIndicator(
                challengeProgress: 1,
                challengeMax: 5,
                challengeTitle: "Scan 5 bottles",
              ),
              const AchievementProgressIndicator(
                challengeProgress: 1,
                challengeMax: 15,
                challengeTitle: "Scan 15 bottles",
              ),
              const AchievementProgressIndicator(
                challengeProgress: 25,
                challengeMax: 10,
                challengeTitle: "Scan 10 items",
              ),
              const AchievementProgressIndicator(
                challengeProgress: 11,
                challengeMax: 25,
                challengeTitle: "Scan 25 items",
              ),
              const AchievementProgressIndicator(
                challengeProgress: 10,
                challengeMax: 10,
                challengeTitle: "Scan 10 red recyclables",
              ),
              const AchievementProgressIndicator(
                challengeProgress: 2,
                challengeMax: 5,
                challengeTitle: "Open the app on 5 different days",
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ],
    );
  }
}
