import 'dart:async';
import 'package:brewcrew/shared/constants.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({this.camera});

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  bool _isModelRunning = false;
  String _result;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.low,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<List> _runModel(String path) async {
    await Tflite.loadModel(
      model: "assets/model/saved_model.tflite",
      labels: "assets/model/labels.txt",
    );

    var result = await Tflite.runModelOnImage(
      path: path,
      imageMean: 125.0,
      imageStd: 125.0,
      numResults: 2,
      threshold: 0.7,
      asynch: true,
    );

    print(result);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRect(
          child: OverflowBox(
            maxWidth: double.infinity,
            alignment: Alignment.center,
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return Center(child: Loading());
                }
              },
            ),
          ),
        ),
        Container(
          width: double.infinity,
          child: Column(
            children: [
              Spacer(),
              Container(
                color: Colors.black45,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  children: [
                    if (_result != null)
                      Column(
                        children: [
                          Text(
                            _result,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    RawMaterialButton(
                      elevation: 4.0,
                      fillColor: Colors.white,
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: themeGreen,
                        size: 32.0,
                      ),
                      padding: EdgeInsets.all(12.0),
                      shape: CircleBorder(
                        side: BorderSide(
                          color: themeGreen,
                          width: 4,
                        ),
                      ),
                      onPressed: () async {
                        try {
                          setState(() {
                            _isModelRunning = true;
                          });

                          final image = await _controller.takePicture();

                          List result = await _runModel(image.path);

                          setState(() {
                            _isModelRunning = false;
                            _result = result[0]['label'];
                          });
                        } catch (e) {
                          print(e);
                          setState(() {
                            _isModelRunning = false;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (_isModelRunning)
          Center(
            child: Loading(),
          ),
      ],
    );
  }
}
