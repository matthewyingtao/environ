import 'package:flutter/material.dart';

class Knowledge extends StatelessWidget {
  const Knowledge({Key? key}) : super(key: key);

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
                    "Grow your",
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
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
                    child: const Icon(
                      Icons.school,
                      size: 140,
                      color: Colors.white,
                    ),
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
              "KNOWLEDGE",
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
