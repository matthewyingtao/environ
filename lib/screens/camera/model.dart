import 'package:environ/services/database.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class Model {
  Model({required this.path});
  final String path;

  Future<List?> useModel() async {
    await Tflite.loadModel(
      model: 'assets/model/saved_model.tflite',
      labels: 'assets/model/labels.txt',
    );

    final result = await Tflite.runModelOnImage(
      path: path,
    );

    final DatabaseService database =
        DatabaseService(data: Map<String, dynamic>.from(result![0]));
    final int objects = database.updateAchievement();

    debugPrint(objects.toString());

    return result;
  }

  Future<void> closeModel() async {
    await Tflite.close();
  }
}
