import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:brewcrew/shared/constants.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
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
                child: RawMaterialButton(
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
                      await _initializeControllerFuture;

                      final image = await _controller.takePicture();

                      String res = await Tflite.loadModel(
                          model: "assets/model/hands_model.tflite",
                          labels: "assets/model/labels.txt",
                      );

                      print(res);

                      var result = await Tflite.runModelOnImage(
                          path: image.path,
                          imageMean: 125.0,
                          imageStd: 125.0,
                          numResults: 2,
                          threshold: 0.7,
                          asynch: true
                      );

                      print("That photo contained: $result");


                      await Tflite.close();

                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 150),
                          child: DisplayPictureScreen(
                            imagePath: image.path,
                          ),
                        ),
                      );
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Taken'),
        backgroundColor: themeDarkGreen,
      ),
      body: Image.file(
        File(imagePath),
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
