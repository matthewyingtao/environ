import 'package:tflite/tflite.dart';

class Model {
  final String? path;

  Model({this.path});

  Future<List?> useModel() async {
    await Tflite.loadModel(
      model: "assets/model/saved_model.tflite",
      labels: "assets/model/labels.txt",
    );

    return Tflite.runModelOnImage(
      path: path!,
    );
  }

  Future<void> closeModel() async {
    Tflite.close();
  }
}
