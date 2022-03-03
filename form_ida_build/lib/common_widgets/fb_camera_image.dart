import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:form_ida_build/utils/app_constants.dart';
import 'package:image_picker/image_picker.dart';

class FbCameraView extends StatefulWidget {
  List<String> sizeCheck = <String>["Small", "Medium", "Large", "Custom"];
  double? fieldsize;
  List<String> fieldalign = <String>["Left", "Center", "Right"];
  final Color color;
  final double radius;
  final double strokeWidth;
  final double padding;
  final double iconSize;
  final double height;
  Alignment fieldAlignM;
  num customWidth;
  num customHeight;
  String textFieldName;
  String textHidedName;

  FbCameraView({
    this.textFieldName = "Filed Name",
    this.textHidedName = "",
    this.color = Colors.blue,
    this.strokeWidth = 1,
    this.radius = 4,
    this.padding = 6,
    this.iconSize = 48,
    this.height = 175,
    this.fieldsize = double.infinity,
    this.fieldAlignM = Alignment.centerLeft,
    this.customWidth = 0.9,
    this.customHeight = 0.2,
  });

  @override
  _FbCameraViewState createState() => _FbCameraViewState();
}

class _FbCameraViewState extends State<FbCameraView> {
  bool mandotoryvalue = false;
  bool mandotorysetValue = false;

  String selectedSize = "Large";
  String selectedsetSize = "Large";

  String selectedfieldalign = "Left";
  String selectedsetfieldalign = "Left";

  bool value = false;

  File image = File("");

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: widget.fieldAlignM,
      child: Container(
        width: widget.fieldsize,
        height: MediaQuery.of(context).size.height * widget.customHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.blueAccent),
        ),
        padding: EdgeInsets.all(widget.padding),
        child: GestureDetector(
          onLongPress: () {
            showMyDialog();
          },
          onTap: showCamera,
          child: value == false
              ? Container(
                  width: double.infinity,
                  height: widget.height,
                  child: Icon(
                    CupertinoIcons.add_circled_solid,
                    color: Colors.blueAccent,
                    size: widget.iconSize,
                  ),
                )
              : Container(
                  width: double.infinity,
                  height: widget.height,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: FileImage(image),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> showMyDialog() async {
    TextEditingController customWidthController = new TextEditingController();
    TextEditingController customHeightController = new TextEditingController();
    customWidthController.text = widget.customWidth.toString();
    customHeightController.text = widget.customHeight.toString();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(0, 24.0, 0, 24.0),
          title: Text('Text Property Window'),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.all(8.0),
            child: StatefulBuilder(
              builder: (context, _setState) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(flex: 1, child: Text("Field Size")),
                          Expanded(
                            flex: 2,
                            child: DropdownButtonFormField<String>(
                                value: selectedSize,
                                items: widget.sizeCheck.map((String value) {
                                  return DropdownMenuItem<String>(
                                    alignment: Alignment.topRight,
                                    value: value,
                                    child: Text(
                                      value,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  _setState(() {
                                    print(newValue);
                                    selectedSize = newValue!;
                                  });
                                }),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: selectedSize == "Custom"
                                ? Text("Custom Width")
                                : Text(""),
                          ),
                          Expanded(
                            flex: 2,
                            child: selectedSize == "Custom"
                                ? TextField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    controller: customWidthController,
                                  )
                                : Text(""),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: selectedSize == "Custom"
                                ? Text("Custom Height")
                                : Text(""),
                          ),
                          Expanded(
                            flex: 2,
                            child: selectedSize == "Custom"
                                ? TextField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    controller: customHeightController,
                                  )
                                : Text(""),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(flex: 1, child: Text("Field Alignment")),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                                value: selectedfieldalign,
                                items: widget.fieldalign.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  _setState(() {
                                    selectedfieldalign = newValue!;
                                  });
                                }),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text("Mandatory"),
                          ),
                          Expanded(
                            child: Transform.scale(
                              scale: 0.7,
                              child: StatefulBuilder(
                                builder: (context, _setState) {
                                  return CupertinoSwitch(
                                    value: mandotoryvalue,
                                    onChanged: (value) {
                                      _setState(() {
                                        this.mandotoryvalue = value;
                                        print(value);
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ADD', style: TextStyle(fontSize: 15.0)),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  mandotorysetValue = mandotoryvalue;
                  selectedsetfieldalign = selectedfieldalign;
                  if (selectedfieldalign == "Left") {
                    widget.fieldAlignM = Alignment.centerLeft;
                  } else if (selectedfieldalign == "Center") {
                    widget.fieldAlignM = Alignment.center;
                  } else if (selectedfieldalign == "Right") {
                    widget.fieldAlignM = Alignment.centerRight;
                  }
                  if (selectedSize == "Small") {
                    widget.fieldsize = MediaQuery.of(context).size.width * 0.40;
                  } else if (selectedSize == "Medium") {
                    widget.fieldsize = MediaQuery.of(context).size.width * 0.60;
                  } else if (selectedSize == "Large") {
                    widget.fieldsize = MediaQuery.of(context).size.width;
                  } else if (selectedSize == "Custom") {
                    widget.fieldsize =
                        MediaQuery.of(context).size.width * widget.customWidth;
                  }
                });
              },
            ),
            TextButton(
              child: const Text('Duplicate', style: TextStyle(fontSize: 15.0)),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  AppConstants.elementsList.add(ElementTypes(
                      elementName: "Text",
                      element: FbCameraView(
                        color: widget.color,
                        radius: widget.radius,
                        strokeWidth: widget.strokeWidth,
                        padding: widget.padding,
                        iconSize: widget.iconSize,
                        height: widget.height,
                        fieldsize: widget.fieldsize,
                        fieldAlignM: widget.fieldAlignM,
                        customHeight: widget.customHeight,
                        customWidth: widget.customWidth,
                      ),
                      elementId: "Media${AppConstants.elementID}"));
                });
              },
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    if (selectedsetfieldalign != selectedfieldalign) {
                      selectedfieldalign = selectedsetfieldalign;
                    }
                    if (mandotorysetValue != mandotoryvalue) {
                      mandotoryvalue = mandotorysetValue;
                    }
                    if (selectedsetSize != selectedSize) {
                      selectedSize = selectedsetSize;
                    }
                  });
                },
                child: const Text(
                  'Close',
                  style: TextStyle(fontSize: 15.0),
                )),
          ],
        );
      },
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
