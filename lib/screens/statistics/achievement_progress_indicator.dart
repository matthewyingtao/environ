import 'dart:ui';

import 'package:environ/shared/constants.dart';
import 'package:flutter/material.dart';

class AchievementProgressIndicator extends StatelessWidget {
  final int challengeProgress;
  final int challengeMax;
  final String challengeTitle;

  const AchievementProgressIndicator({
    required this.challengeProgress,
    required this.challengeMax,
    required this.challengeTitle,
    Key? key,
  }) : super(key: key);

  Color getProgressColor(double percentageDone) {
    if (percentageDone < 0.3) {
      return themeRed;
    } else if (percentageDone < 0.7) {
      return themeBlue;
    } else {
      return themeYellow;
    }
  }

  double getPercentageDone(progress, max) {
    double percentageDone = challengeProgress / challengeMax;
    if (percentageDone > 1) {
      return 1;
    } else if (percentageDone < 0) {
      return 0;
    }
    return percentageDone;
  }

  @override
  Widget build(BuildContext context) {
    final double percentageDone =
        getPercentageDone(challengeProgress, challengeMax);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(challengeTitle),
              const Spacer(),
              Text(
                challengeProgress.toString() + " / " + challengeMax.toString(),
                style: percentageDone == 1
                    // text is bold when task is complete
                    ? Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w900,
                        )
                    // text is italic when task is incomplete
                    : Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Container(
            alignment: Alignment.topLeft,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.circular(50.0),
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
              boxShadow:
                  // makes the bar glow if the task is complete
                  percentageDone == 1
                      ? const [
                          BoxShadow(
                            color: Color.fromRGBO(255, 255, 255, 0.7),
                            blurRadius: 6.0,
                          ),
                        ]
                      : [],
            ),
            child: FractionallySizedBox(
              widthFactor: percentageDone,
              child: Container(
                decoration: BoxDecoration(
                  color: getProgressColor(percentageDone),
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
