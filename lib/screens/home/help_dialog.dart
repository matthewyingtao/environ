import 'package:environ/shared/components/custom_about.dart';
import 'package:environ/shared/components/pop_up_dialog.dart';
import 'package:environ/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HelpDialog extends StatelessWidget {
  const HelpDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopUpDialog(
      bodyWidget: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'How to scan items',
              style:
                  Theme.of(context).textTheme.headline6!.copyWith(color: black),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '''Place the item you want to scan on a surface with a quiet background.''',
            style: TextStyle(color: black),
          ),
          const SizedBox(height: 12),
          const Text(
            '''The AI works best when the object is against a white background and placed in the center.''',
            style: TextStyle(color: black),
          ),
          const SizedBox(height: 12),
          const Text(
            '''Keep in mind that the AI is not perfect. It's meant to be an indicator and to assist in identification, not to make the final judgement.''',
            style: TextStyle(color: black),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: const Text(
                  'About App',
                  style: linkButtonStyle,
                ),
                onPressed: () {
                  showCustomLicensePage(
                    context: context,
                    applicationIcon: SvgPicture.asset(
                      'assets/leavesbg.svg',
                      color: Colors.white,
                      height: 64,
                      width: 64,
                    ),
                    applicationName: 'Environ',
                    applicationVersion: '1.3.2',
                  );
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Close',
                  style: linkButtonStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
