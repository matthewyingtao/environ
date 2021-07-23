import 'dart:math';
import 'package:environ/screens/wrapper.dart';
import 'package:environ/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:environ/screens/onboarding/sustainably.dart';
import 'package:environ/screens/onboarding/progress.dart';
import 'package:environ/screens/onboarding/knowledge.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  double _leafRotation = -(pi / 12);
  final PageController _controller = PageController(initialPage: 0);
  Color _bgColor = themeGreen;
  bool _goSignIn = false;

  @override
  Widget build(BuildContext context) {
    if (_goSignIn) {
      return const Wrapper();
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: _bgColor,
        body: Stack(
          children: [
            Transform.scale(
              scale: 2,
              child: AnimatedContainer(
                constraints: const BoxConstraints.expand(),
                duration: const Duration(milliseconds: 500),
                color: _bgColor,
                transform: Matrix4.rotationZ(_leafRotation),
                transformAlignment: Alignment.center,
                curve: Curves.easeOut,
                child: SvgPicture.asset(
                  "assets/leavesbg.svg",
                  color: const Color.fromRGBO(255, 255, 255, 0.10),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      controller: _controller,
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
                          _leafRotation = (index - 1) * (pi / 12);
                        });
                      },
                      children: const [
                        Sustainably(),
                        Progress(),
                        Knowledge(),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 24.0,
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white30,
                          ),
                          margin: const EdgeInsets.only(left: 16.0),
                          padding: const EdgeInsets.symmetric(
                            vertical: 6.0,
                            horizontal: 16.0,
                          ),
                          child: SmoothPageIndicator(
                            controller: _controller,
                            count: 3,
                            effect: WormEffect(
                              dotColor: Colors.white70,
                              activeDotColor: Colors.grey[800]!,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.only(right: 16.0),
                          child: ElevatedButton(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 24.0,
                              ),
                              child: const Text("Continue"),
                            ),
                            style: roundedButtonWhite,
                            onPressed: () async {
                              if (_controller.page == 2) {
                                setState(() => _goSignIn = true);
                              } else {
                                _controller.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease);
                              }
                            },
                          ),
                        ),
                      ],
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
}
