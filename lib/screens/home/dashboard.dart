import 'dart:math';
import 'package:environ/shared/components/wide_stadium_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:environ/shared/components/achievement_progress_indicator.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  final Function? changePage;

  const Dashboard({
    this.changePage,
    Key? key,
  }) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
              color: const Color.fromRGBO(0, 0, 0, 0.1),
              height: 400,
              width: 400,
            ),
          ),
        ),
        Column(
          children: [
            const SizedBox(height: 24.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dashboard",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    "Achievement Progress",
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
                    challengeProgress: 11,
                    challengeMax: 25,
                    challengeTitle: "Scan 25 items",
                  ),
                  const AchievementProgressIndicator(
                    challengeProgress: 10,
                    challengeMax: 10,
                    challengeTitle: "Scan 10 red recyclables",
                  ),
                  const SizedBox(height: 8.0),
                  WideStadiumButton(
                    text: "Scan Item",
                    onPressed: () => widget.changePage!(1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
