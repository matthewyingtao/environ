import 'package:flutter/material.dart';

class OnboardingInfoScreen extends StatelessWidget {
  final String title;
  final String subheading;
  final String body;
  final Widget icon;

  const OnboardingInfoScreen({
    required String this.title,
    required String this.subheading,
    required String this.body,
    required Widget this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(
              left: 24.0,
              top: 32.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Placeholder(
                  fallbackHeight: 120,
                ),
                const SizedBox(
                  height: 32.0,
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
                  height: 16.0,
                ),
                Text(
                  body,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Colors.white,
                      ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(24.0),
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
            fit: BoxFit.contain,
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
}
