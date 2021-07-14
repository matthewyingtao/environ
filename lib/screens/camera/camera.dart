import 'dart:async';
import 'package:environ/shared/constants.dart';
import 'package:environ/shared/loading.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class TakePictureScreen extends StatefulWidget {
  final Function changeData;

  const TakePictureScreen({this.changeData});

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen>
    with WidgetsBindingObserver {
  List<CameraDescription> _cameras;
  CameraController _controller;
  int _selected = 0;

  bool _isModelRunning = false;
  String _result;

  @override
  void initState() {
    super.initState();
    setupCamera();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (_controller == null || !_controller.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _controller.dispose();
    } else if (state == AppLifecycleState.resumed) {
      setupCamera();
    }
  }

  Future<void> setupCamera() async {
    _cameras = await availableCameras();
    var controller = await selectCamera();
    setState(() => _controller = controller);
  }

  selectCamera() async {
    var controller = CameraController(
      _cameras[_selected],
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    await controller.initialize();
    return controller;
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

    return result;
  }

  Future<CameraDescription> getMainCamera() async {
    // Obtain a list of the available cameras on the device.
    final List<CameraDescription> cameras = await availableCameras();
    final CameraDescription firstCamera = cameras.first;
    return firstCamera;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //prevents the camera screen from overflowing
        ClipRect(
          child: OverflowBox(
            maxWidth: double.infinity,
            alignment: Alignment.center,
            child: _controller == null ? Loading() : CameraPreview(_controller),
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
                      child: Icon(
                        Icons.camera_alt,
                        color: themeGreen,
                        size: 32.0,
                      ),
                      fillColor: Colors.white,
                      padding: EdgeInsets.all(12.0),
                      shape: CircleBorder(
                        side: BorderSide(
                          color: themeGreen,
                          width: 4,
                        ),
                      ),
                      // runs the model and sets the variable to the result
                      onPressed: () async {
                        try {
                          setState(() {
                            _isModelRunning = true;
                          });

                          _controller.setFlashMode(FlashMode.off);

                          final image = await _controller.takePicture();

                          List result = await _runModel(image.path);

                          widget.changeData(result);

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
