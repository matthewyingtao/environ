import 'dart:async';
import 'package:environ/screens/camera/model.dart';
import 'package:environ/shared/constants.dart';
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
  int _selected = 0;

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
        // forces the widget to be take up all available space
        Container(
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
              // makes sure that the shutter button bar is pushed to the bottom
              Spacer(),
              // shutter button bar
              Container(
                color: Colors.black45,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  children: [
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

                      // runs the model and sets the result as a variable
                      onPressed: () async {
                        // ensure that the photo taken won't use flash
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
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
