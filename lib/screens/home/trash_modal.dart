import 'package:environ/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TrashModal extends StatelessWidget {
  final List data;
  const TrashModal({this.data});

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
    final bool isRecyclable = this.data[0]['label'] == "trash" ? false : true;
    final String trashImage = _getTrashImage(this.data[0]['label']);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        ),
        color: isRecyclable ? themeBlue : themeRed,
      ),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        children: [
          Text(
            isRecyclable ? "Recyclable" : "Non-Recyclable",
            style: Theme.of(context).textTheme.headline3,
            textAlign: TextAlign.center,
          ),
          Text(
            this.data == null ? "you haven't got data" : this.data[0]['label'],
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0),
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(trashImage),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
