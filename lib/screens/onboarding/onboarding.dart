import 'dart:math';

import 'package:environ/screens/onboarding/authenticate.dart';
import 'package:environ/screens/onboarding/onboarding_info_screen.dart';
import 'package:environ/screens/wrapper.dart';
import 'package:environ/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  double _leafRotation = -(pi / 12);
  final PageController _controller = PageController();
  Color _bgColor = themeGreen;
  bool _goSignIn = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();

  Future<void> setName(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('name', name);
    await prefs.setBool('first_time', false);
  }

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
                  'assets/leavesbg.svg',
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
                              _bgColor = themeGreen;
                              break;

                            case 1:
                              _bgColor = themeBlue;
                              break;

                            case 2:
                              _bgColor = themeRed;
                              break;

                            case 3:
                              {
                                _bgColor = themeGreen;
                              }
                              break;
                          }
                          _leafRotation = (index - 1) * (pi / 12);
                        });
                      },
                      children: [
                        const OnboardingInfoScreen(
                          title: 'KNOWLEDGE',
                          subheading: 'Grow your',
                          body:
                              '''Environ provides helpful information on how to recycle. We help you better understand what's recyclable and ways to reduce pollution.''',
                          icon: Icon(
                            Icons.school,
                            size: 140,
                            color: Colors.white,
                          ),
                        ),
                        const OnboardingInfoScreen(
                          title: 'PROGRESS',
                          subheading: 'Track your',
                          body:
                              '''With an achievement system, Environ tracks how many items you've recycled, a statistic that you can show off to your friends!''',
                          icon: Icon(
                            Icons.insights,
                            size: 140,
                            color: Colors.white,
                          ),
                        ),
                        OnboardingInfoScreen(
                          title: 'SUSTAINABLY',
                          subheading: 'Live more',
                          body:
                              '''Using cutting edge machine learning technology, we help you to recycle with confidence.''',
                          icon: SvgPicture.asset(
                            'assets/recyclingsymbol.svg',
                            color: Colors.white,
                            height: 120,
                            width: 120,
                          ),
                        ),
                        Authenticate(
                          formKey: formKey,
                          controller: controller,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 24,
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white30,
                          ),
                          margin: const EdgeInsets.only(left: 16),
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 16,
                          ),
                          child: SmoothPageIndicator(
                            controller: _controller,
                            count: 4,
                            effect: WormEffect(
                              dotColor: Colors.white70,
                              activeDotColor: Colors.grey[800]!,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.only(right: 16),
                          child: ElevatedButton(
                            style: roundedButtonWhite,
                            onPressed: () async {
                              if (_controller.page == 3) {
                                if (formKey.currentState!.validate()) {
                                  await setName(controller.value.text);
                                  setState(() => _goSignIn = true);
                                }
                              } else {
                                await _controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 24,
                              ),
                              child: const Text('Continue'),
                            ),
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
