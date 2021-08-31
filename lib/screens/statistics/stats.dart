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
    final Map<dynamic, int> achievements = database.getAchievementData();

    final int objects = achievements['objects'] ?? 0;
    final int openAppOnSeparateDays =
        achievements['open_app_separate_days'] ?? 0;

    final int clearGlass = achievements['clear-glass'] ?? 0;
    final int coloredGlass = achievements['colored-glass'] ?? 0;
    final int clothing = achievements['clothing'] ?? 0;
    final int metal = achievements['metal'] ?? 0;
    final int paperCardboard = achievements['paper-cardboard'] ?? 0;
    final int plastic = achievements['plastic'] ?? 0;
    final int trash = achievements['trash'] ?? 0;

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
              challengeProgress: objects,
              challengeMax: 10,
              challengeTitle: 'Scan 10 items',
            ),
            AchievementProgressIndicator(
              challengeProgress: objects,
              challengeMax: 25,
              challengeTitle: 'Scan 25 items',
            ),
            AchievementProgressIndicator(
              challengeProgress: objects,
              challengeMax: 50,
              challengeTitle: 'Scan 50 items',
            ),
            AchievementProgressIndicator(
              challengeProgress: openAppOnSeparateDays,
              challengeMax: 5,
              challengeTitle: 'Open the app on 5 different days',
            ),
            AchievementProgressIndicator(
              challengeProgress: openAppOnSeparateDays,
              challengeMax: 15,
              challengeTitle: 'Open the app on 15 different days',
            ),
            AchievementProgressIndicator(
              challengeProgress: metal,
              challengeMax: 5,
              challengeTitle: 'Scan 5 metal items',
            ),
            AchievementProgressIndicator(
              challengeProgress: metal,
              challengeMax: 15,
              challengeTitle: 'Scan 15 metal items',
            ),
            AchievementProgressIndicator(
              challengeProgress: clearGlass,
              challengeMax: 5,
              challengeTitle: 'Scan 5 clear glass items',
            ),
            AchievementProgressIndicator(
              challengeProgress: clearGlass,
              challengeMax: 15,
              challengeTitle: 'Scan 15 clear glass items',
            ),
            AchievementProgressIndicator(
              challengeProgress: coloredGlass,
              challengeMax: 5,
              challengeTitle: 'Scan 5 colored glass items',
            ),
            AchievementProgressIndicator(
              challengeProgress: coloredGlass,
              challengeMax: 15,
              challengeTitle: 'Scan 15 colored glass items',
            ),
            AchievementProgressIndicator(
              challengeProgress: clothing,
              challengeMax: 5,
              challengeTitle: 'Scan 5 clothing items',
            ),
            AchievementProgressIndicator(
              challengeProgress: clothing,
              challengeMax: 15,
              challengeTitle: 'Scan 15 clothing items',
            ),
            AchievementProgressIndicator(
              challengeProgress: paperCardboard,
              challengeMax: 5,
              challengeTitle: 'Scan 5 paper or cardboard items',
            ),
            AchievementProgressIndicator(
              challengeProgress: paperCardboard,
              challengeMax: 15,
              challengeTitle: 'Scan 15 paper or cardboard items',
            ),
            AchievementProgressIndicator(
              challengeProgress: plastic,
              challengeMax: 5,
              challengeTitle: 'Scan 5 plastic items',
            ),
            AchievementProgressIndicator(
              challengeProgress: plastic,
              challengeMax: 15,
              challengeTitle: 'Scan 15 plastic items',
            ),
            AchievementProgressIndicator(
              challengeProgress: trash,
              challengeMax: 100,
              challengeTitle: 'Scan 5 clothing items',
            ),
            const SizedBox(height: 16),
          ],
        ),
      ],
    );
  }
}
