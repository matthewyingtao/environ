import 'dart:math';
import 'package:brewcrew/shared/components/report_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:brewcrew/shared/components/challenge_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:matrix4_transform/matrix4_transform.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  PageController _controller =
  PageController(initialPage: 0, viewportFraction: 0.6);
  int _currentPage = 0;

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
                    Text("Dashboard",
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline3),
                    SizedBox(height: 24.0),
                    Text(
                      "Daily Challenges",
                      textAlign: TextAlign.left,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline5,
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
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () => print("hi"),
                        child: Text(
                          "Challenges >",
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Yesterday's Report",
                      textAlign: TextAlign.left,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline5,
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
              Container(
                height: 200,
                child: PageView(
                  physics: BouncingScrollPhysics(),
                  controller: _controller,
                  onPageChanged: (value) {
                    setState(() {
                      _currentPage = value;
                    });
                  },
                  children: [
                    AnimatedContainer(
                      transformAlignment: Alignment.center,
                      transform: _currentPage == 0
                          ? Matrix4.identity()
                          : Matrix4Transform()
                          .scale(0.8)
                          .matrix4,
                      height: 200,
                      width: 200,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                      child: ReportCard(
                        icon: Icons.battery_charging_full_rounded,
                        body: "You saved 20 hours of phone use!",
                        main: true,
                      ),
                    ),
                    AnimatedContainer(
                      transformAlignment: Alignment.center,
                      transform: _currentPage == 1
                          ? Matrix4.identity()
                          : Matrix4Transform()
                          .scale(0.8)
                          .matrix4,
                      height: 200,
                      width: 200,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                      child: ReportCard(
                        icon: Icons.flare_rounded,
                        body: "Three day streak",
                        main: false,
                      ),
                    ),
                    AnimatedContainer(
                      transformAlignment: Alignment.center,
                      transform: _currentPage == 2
                          ? Matrix4.identity()
                          : Matrix4Transform()
                          .scale(0.8)
                          .matrix4,
                      height: 200,
                      width: 200,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                      child: ReportCard(
                        icon: Icons.favorite_rounded,
                        body: "Hello",
                        main: false,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.0),
            ],
          ),
        ),
      ],
    );
  }
}
