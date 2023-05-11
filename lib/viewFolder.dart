import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_camera/camera.dart';
import 'package:my_camera/view.dart';

final Directory _image = Directory('/storage/emulated/0/Pictures/Flutter');

class ImageView extends StatefulWidget {
  const ImageView({super.key});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    var imageList = _image
        .listSync()
        .map((item) => item.path)
        .where((item) => item.endsWith('.jpg'))
        .toList();

    if (imageList.length > 0) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => CameraApp()),
                );
              },
              icon: Icon(Icons.arrow_back)),
          title: Text('Gallery'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5),
            padding: EdgeInsets.only(left: 5, right: 5, top: 5),
            itemBuilder: (context, index) {
              String imagePath = imageList[index];
              return Material(
                elevation: 3.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => ViewImage(picture: imagePath),
                      ),
                    );
                  },
                  child: Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            itemCount: imageList.length,
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (ctx) => CameraApp()),
              );
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text('Gallery'),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.all(30),
          child: Center(
            child: Text(
              'Folder is Empty !!',
            ),
          ),
        ),
      );
    }
  }
}
