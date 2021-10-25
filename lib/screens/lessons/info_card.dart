import 'package:environ/shared/components/pop_up_dialog.dart';
import 'package:environ/shared/constants.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
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
    Future<void> _showInfoScreen() async => showDialog<void>(
          context: context,
          builder: (context) => Dialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: PopUpDialog(
              bodyWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    heading,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: black),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    body,
                    style: const TextStyle(color: black),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Close',
                        style: linkButtonStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

    return GestureDetector(
      onTap: _showInfoScreen,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16),
              child: Icon(
                icon,
                color: Colors.white,
                size: 48,
              ),
            ),
            Text(
              heading,
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }
}
