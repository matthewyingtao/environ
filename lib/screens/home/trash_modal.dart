import 'package:environ/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';

class TrashModal extends StatelessWidget {
  final Map<String, dynamic>? data;
  const TrashModal({this.data});

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
    if (this.data != null) {
      final bool isRecyclable = this.data!['label'] == "trash" ? false : true;
      final String trashImage = _getTrashImage(this.data!['label']);

      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.0),
            topRight: Radius.circular(32.0),
          ),
          color: isRecyclable ? themeBlue : themeRed,
          image: DecorationImage(
            image: AssetImage(trashImage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          children: [
            Text(
              isRecyclable ? "Recyclable" : "Non-Recyclable",
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            ),
            Text(
              this.data!['label'],
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
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
                          this.data!["imagePath"],
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
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        decoration: BoxDecoration(
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
