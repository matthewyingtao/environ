import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Sustainably extends StatelessWidget {
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
                  fallbackHeight: 120,
                ),
                SizedBox(
                  height: 32.0,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Live more",
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
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.white),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(24.0),
                    height: 120,
                    width: 120,
                    child: SvgPicture.asset(
                      "assets/recyclingsymbol.svg",
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
              "SUSTAINABLY",
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
