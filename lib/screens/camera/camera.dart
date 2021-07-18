import 'dart:async';
import 'package:environ/screens/camera/model.dart';
import 'package:environ/screens/camera/shutter_button_bar.dart';
import 'package:environ/shared/loading.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  bool _isModelRunning = false;

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
    CameraController controller = await selectCamera();
    setState(() => _controller = controller);
  }

  Future<CameraController> selectCamera() async {
    var controller = CameraController(
      // picks the main camera on the device
      _cameras.first,
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    await controller.initialize();
    return controller;
  }

  // callback for the shutter button
  // takes the photo, runs the model and updates the data
  void takePhoto() async {
    // ensure that the photo taken won't use flash because flash freezes the camera
    _controller.setFlashMode(FlashMode.off);
    final image = await _controller.takePicture();

    Model _model = Model(path: image.path);

    setState(() {
      _isModelRunning = true;
    });

    try {
      List result = await _model.useModel();
      widget.changeData(result);
    } catch (e) {
      print(e);
    }
    setState(() {
      _isModelRunning = false;
    });
    await _model.closeModel();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          // forces the widget to be take up all available space
          height: double.infinity,
          width: double.infinity,
          child: _controller == null || _isModelRunning
              ? Loading()
              : CameraPreview(_controller),
        ),
        Container(
          width: double.infinity,
          child: Column(
            children: [
              // spacer makes sure that the shutter button bar is pushed to the bottom
              Spacer(),
              ShutterButtonBar(
                onPressed: takePhoto,
              )
            ],
          ),
        ),
      ],
    );
  }
}
