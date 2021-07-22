import 'package:environ/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';

class TrashModal extends StatelessWidget {
  final Map<String, dynamic>? data;
  const TrashModal({Key? key, this.data}) : super(key: key);

  // returns the asset location, given the category of the trash
  String _getTrashImage(trashName) {
    switch (trashName) {
      case "trash":
        return "assets/trash_category/trash.jpg";
      case "plastic":
        return "assets/trash_category/plastic.jpg";
      case "metal":
        return "assets/trash_category/metal.jpg";
      case "paper-cardboard":
        return "assets/trash_category/cardboard.jpg";
      case "clothing":
        return "assets/trash_category/clothing.jpg";
      case "colored-glass":
        return "assets/trash_category/glass.jpg";
      case "clear-glass":
        return "assets/trash_category/glass.jpg";

      default:
        return "assets/trash_category/trash.jpg";
    }
  }

  @override
  Widget build(BuildContext context) {
    // checks if user has scanned an item
    if (data != null) {
      final bool isRecyclable = data!['label'] == "trash" ? false : true;
      final String trashImage = _getTrashImage(data!['label']);

      return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32.0),
            topRight: Radius.circular(32.0),
          ),
          color: isRecyclable ? themeBlue : themeRed,
          image: DecorationImage(
            image: AssetImage(trashImage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.dstATop,
            ),
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              isRecyclable ? "Recyclable" : "Non-Recyclable",
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            ),
            Text(
              data!['label'],
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(
                        File(
                          data!["imagePath"],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.0),
            topRight: Radius.circular(32.0),
          ),
          color: themeYellow,
        ),
        child: Center(
          child: Text(
            "Scan an item first",
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }
}
