import 'dart:ui';

import 'package:environ/shared/constants.dart';
import 'package:flutter/material.dart';

class AchievementProgressIndicator extends StatelessWidget {
  final int challengeProgress;
  final int challengeMax;
  final String challengeTitle;

  const AchievementProgressIndicator(
      {this.challengeProgress, this.challengeMax, this.challengeTitle});

  Color getProgressColor() {
    double percentageDone = this.challengeProgress / this.challengeMax;
    if (percentageDone < 0.3) {
      return themeRed;
    } else if (percentageDone < 0.7) {
      return themeBlue;
    } else {
      return themeYellow;
    }
  }

  double getPercentageDone(progress, max) {
    double percentageDone = this.challengeProgress / this.challengeMax;
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
        getPercentageDone(this.challengeProgress, this.challengeMax);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(this.challengeTitle),
            Spacer(),
            Text(
              this.challengeProgress.toString() +
                  " / " +
                  this.challengeMax.toString(),
              style: percentageDone == 1
                  ? Theme.of(context).textTheme.bodyText2.copyWith(
                      fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)
                  : Theme.of(context).textTheme.bodyText2.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
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
          ),
          child: FractionallySizedBox(
            widthFactor: percentageDone,
            child: Container(
              decoration: BoxDecoration(
                color: getProgressColor(),
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
          ),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}
