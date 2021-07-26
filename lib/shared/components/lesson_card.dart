import 'package:environ/screens/home/pop_up_dialog.dart';
import 'package:environ/shared/constants.dart';
import 'package:flutter/material.dart';

class LessonCard extends StatelessWidget {
  const LessonCard({
    required this.icon,
    required this.body,
    required this.heading,
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final String body;
  final String heading;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    Future<void> _showInfoScreen() async {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: PopUpDialog(
              bodyWidget: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      this.heading,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: black),
                    ),
                  ),
                  const Text(
                    'Place the item you want to scan on a surface with a quiet background.',
                    style: TextStyle(color: black),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      child: const Text(
                        'Close',
                        style: linkButtonStyle,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return GestureDetector(
      onTap: () => _showInfoScreen(),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.5),
              blurRadius: 6,
              offset: Offset(0, 6),
            ),
          ],
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.dstATop),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    body,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
