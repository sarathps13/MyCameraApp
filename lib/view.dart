import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_camera/viewFolder.dart';

class ViewImage extends StatelessWidget {
  ViewImage({super.key, required this.picture});
  String picture;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    useSafeArea: true,
                    builder: (context) => AlertDialog(
                          title: const Text(
                            'Delete',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          content: const Text(
                            'Are you Sure ?',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          actions: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white),
                              onPressed: () {
                                File(picture).deleteSync();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (ctx) => ImageView()),
                                    (route) => false);
                              },
                              child: const Text(
                                'yes',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No'))
                          ],
                        ));
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.black),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 20, left: 12),
            child: Image.file(
              File(picture),
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
    );
  }
}
