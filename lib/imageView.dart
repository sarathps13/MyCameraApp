import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

class ImagePreview extends StatefulWidget {
  ImagePreview({required this.file, super.key});
  XFile file;

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  var album_name = 'Flutter';

  @override
  Widget build(BuildContext context) {
    File picture = File(widget.file.path);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Image Preview'),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              height: 550,
              width: double.infinity,
              child: Image.file(
                picture,
                fit: BoxFit.fill,
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  await GallerySaver.saveImage(picture.path,
                      albumName: album_name);
                  Navigator.pop(context);
                },
                child: Text('SAVE'))
          ],
        ));
  }
}
