import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingInfoScreen extends StatelessWidget {
  const OnboardingInfoScreen({
    required this.title,
    required this.subheading,
    required this.body,
    required this.icon,
    Key? key,
  }) : super(key: key);

  final String title;
  final String subheading;
  final String body;
  final Widget icon;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                left: 24,
                top: 32,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: SvgPicture.asset(
                      'assets/leavesbg.svg',
                      color: Colors.white,
                      height: 120,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      subheading,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    body,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(24),
                      child: icon,
                    ),
                  ),
                ],
              ),
            ),
          ),
          RotatedBox(
            quarterTurns: 1,
            child: FittedBox(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          )
        ],
      );
}
