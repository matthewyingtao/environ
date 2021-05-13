import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
              left: 24.0,
              top: 32.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Placeholder(
                  fallbackHeight: 200,
                ),
                SizedBox(
                  height: 32.0,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Track your",
                    style: Theme.of(context).textTheme.headline3.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: Colors.white,
                      ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(24.0),
                    child: Icon(
                      Icons.insights,
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
          child: Transform.translate(
            offset: Offset(0.0, -10.0),
            child: Text(
              "PROGRESS",
              style: Theme.of(context).textTheme.headline1.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        )
      ],
    );
  }
}
