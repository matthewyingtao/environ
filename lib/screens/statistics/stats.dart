import 'package:environ/screens/statistics/achievement_progress_indicator.dart';
import 'package:environ/services/database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Stats extends StatelessWidget {
  const Stats({Key? key}) : super(key: key);

  Future<String> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.get('name').toString();
  }

  @override
  Widget build(BuildContext context) {
    final Database database = Database();
    final List<int> achievements = database.getAchievementData();

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const SizedBox(height: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Statistics',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FutureBuilder(
                future: getName(),
                initialData: 'loading',
                builder: (context, snapshot) => Text(
                  "${snapshot.data.toString()}'s achievements",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            const SizedBox(height: 16),
            AchievementProgressIndicator(
              challengeProgress: achievements[0],
              challengeMax: 10,
              challengeTitle: 'Scan 10 items',
            ),
            AchievementProgressIndicator(
              challengeProgress: achievements[0],
              challengeMax: 25,
              challengeTitle: 'Scan 25 items',
            ),
            AchievementProgressIndicator(
              challengeProgress: achievements[0],
              challengeMax: 50,
              challengeTitle: 'Scan 50 items',
            ),
            const AchievementProgressIndicator(
              challengeProgress: 5,
              challengeMax: 10,
              challengeTitle: 'Scan 10 red recyclables',
            ),
            const AchievementProgressIndicator(
              challengeProgress: 2,
              challengeMax: 5,
              challengeTitle: 'Open the app on 5 different days',
            ),
            const AchievementProgressIndicator(
              challengeProgress: 1,
              challengeMax: 5,
              challengeTitle: 'Scan 5 bottles',
            ),
            const AchievementProgressIndicator(
              challengeProgress: 1,
              challengeMax: 15,
              challengeTitle: 'Scan 15 bottles',
            ),
            const AchievementProgressIndicator(
              challengeProgress: 10,
              challengeMax: 10,
              challengeTitle: 'Scan 10 red recyclables',
            ),
            const AchievementProgressIndicator(
              challengeProgress: 2,
              challengeMax: 5,
              challengeTitle: 'Open the app on 5 different days',
            ),
            const SizedBox(height: 16),
          ],
        ),
      ],
    );
  }
}
