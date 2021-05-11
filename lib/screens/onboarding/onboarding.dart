import 'package:brewcrew/screens/onboarding/sustainably.dart';
import 'package:brewcrew/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:math';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  double leafSize = 4;
  final PageController controller = PageController(initialPage: 0);
  Color _bgColor = themeGreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: _bgColor,
      body: Stack(
        children: [
          AnimatedContainer(
            constraints: BoxConstraints.expand(),
            duration: Duration(milliseconds: 500),
            color: _bgColor,
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: leafSize),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              builder: (BuildContext context, double size, Widget widget) {
                return Transform.scale(
                  alignment: Alignment.center,
                  scale: 2,
                  child: SvgPicture.asset(
                    "assets/leavesbg.svg",
                    color: Color.fromRGBO(255, 255, 255, 0.15),
                  ),
                );
              },
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    controller: controller,
                    onPageChanged: (index) {
                      setState(() {
                        switch (index) {
                          case 0:
                            {
                              _bgColor = themeGreen;
                            }
                            break;

                          case 1:
                            {
                              _bgColor = themeBlue;
                            }
                            break;

                          case 2:
                            {
                              _bgColor = themeRed;
                            }
                            break;
                        }
                      });
                    },
                    children: <Widget>[
                      // Sustainably(),
                      Center(
                        child: Sustainably(),
                      ),
                      Center(
                        child: Text('Second Page'),
                      ),
                      Center(
                        child: Text('Third Page'),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 24.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white30,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 6.0,
                      horizontal: 16.0,
                    ),
                    child: SmoothPageIndicator(
                        controller: controller,
                        count: 3,
                        effect: WormEffect(
                            dotColor: Colors.white70,
                            activeDotColor: Colors.grey[800]),
                        onDotClicked: (index) {}),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
