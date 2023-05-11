import 'dart:math';

import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:my_camera/imageView.dart';
import 'package:my_camera/main.dart';
import 'package:my_camera/viewFolder.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraApp extends StatefulWidget {
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController _controller;
  int direction = 0;

  var status;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startCamera();
  }

  startCamera() async {
    _controller = CameraController(cameras[direction], ResolutionPreset.max,
        enableAudio: false);
    await _controller.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            child: CameraPreview(_controller),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            child: Row(
              children: [
                IconButton(
                  onPressed: () async {
                    status = await Permission.storage.request();
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) => ImageView()));
                  },
                  icon: Icon(
                    Icons.image_outlined,
                    size: 45,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(
                  width: 100,
                ),
                IconButton(
                  onPressed: () async {
                    clickImage();
                  },
                  icon: Icon(
                    Icons.camera,
                    size: 50,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(
                  width: 100,
                ),
                IconButton(
                    onPressed: () async {
                      setState(() {
                        direction = direction == 0 ? 1 : 0;
                        startCamera();
                      });
                    },
                    icon: Icon(
                      Icons.flip_camera_ios_outlined,
                      size: 45,
                      color: Colors.blueAccent,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future clickImage() async {
    await _controller.setFlashMode(FlashMode.auto);
    XFile picture = await _controller.takePicture();

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ImagePreview(file: picture)));
  }
}
