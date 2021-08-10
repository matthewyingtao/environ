import 'package:environ/services/database.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class Model {
  Model({required this.path});
  final String path;

  Future<List?> useModel() async {
    final DatabaseService database = DatabaseService();

    await Tflite.loadModel(
      model: 'assets/model/saved_model.tflite',
      labels: 'assets/model/labels.txt',
    );
    final int objects = await database.updateAchievement();

    debugPrint(objects.toString());

    return Tflite.runModelOnImage(
      path: path,
    );
  }

  Future<void> closeModel() async {
    await Tflite.close();
  }
}
