import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FbCameraView extends StatefulWidget {
  final Color color;
  final double radius;
  final double strokeWidth;
  final double padding;
  final double iconSize;
  final double height;
  num custWidth;
  num custHeight;
  double mBorderWidth;

  FbCameraView({
    this.color = Colors.blue,
    this.strokeWidth = 1,
    this.radius = 4,
    this.padding = 6,
    this.iconSize = 48,
    this.height = 175,
    required this.custWidth,
    required this.custHeight,
    required this.mBorderWidth,
  });

  @override
  _FbCameraViewState createState() => _FbCameraViewState();
}

class _FbCameraViewState extends State<FbCameraView> {
  bool value = false;

  File image = File("");

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color:
          widget.mBorderWidth == 0 ? Colors.transparent : Colors.blueAccent,
          width: widget.mBorderWidth,
        ),
      ),
      padding: EdgeInsets.all(widget.padding),
      child: GestureDetector(
        onTap: showCamera,
        child: value == false
            ? Container(
          width: MediaQuery.of(context).size.height * widget.custWidth,
          height: MediaQuery.of(context).size.height *
              (widget.custHeight - 0.1),
          child: Icon(
            CupertinoIcons.add_circled_solid,
            color: Colors.blueAccent,
            size: widget.iconSize,
          ),
        )
            : Container(
          width: MediaQuery.of(context).size.height * widget.custWidth,
          height: MediaQuery.of(context).size.height *
              (widget.custHeight - 0.1),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: FileImage(image),
            ),
          ),
        ),
      ),
    );
  }

  Future showCamera() async {
    final picture = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      if (picture != null) {
        image = File(picture.path);
        value = true;
      }
    });
  }
}
