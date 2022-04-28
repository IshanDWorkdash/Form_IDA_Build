import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
  Color? colorFieldName;
  Color? colorbgFieldName;
  Color? fieldColor;
  double? fontSizeFieldName;
  Color? bgfieldColor;

  FbCameraView({
    this.textFieldName = "Filed Name",
    this.textHidedName = "",
    this.color = Colors.blue,
    this.colorFieldName = Colors.black,
    this.colorbgFieldName = Colors.white,
    this.fieldColor = Colors.black,
    this.fontSizeFieldName = 15.0,
    this.strokeWidth = 1,
    this.radius = 4,
    this.padding = 12.0,
    this.iconSize = 48,
    this.height = 175,
    this.fieldsize = double.infinity,
    this.fieldAlignM = Alignment.centerLeft,
    this.customWidth = 0.9,
    this.customHeight = 0.3,
    this.bgfieldColor = Colors.white,
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

  bool disappearvalue = true;
  bool disappearsetValue = true;

  FontWeight fieldBold = FontWeight.normal;
  FontWeight fieldSetBold = FontWeight.normal;

  FontStyle fieldItalic = FontStyle.normal;
  FontStyle fieldSetItalic = FontStyle.normal;

  TextDecoration fieldUnderLine = TextDecoration.none;
  TextDecoration fieldSetUnderLine = TextDecoration.none;

  bool value = false;

  File image = File("");

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showMyDialog();
      },
      onTap: showCamera,
      child: Container(
        alignment: widget.fieldAlignM,
        child: Container(
          width: widget.fieldsize,
          height: MediaQuery.of(context).size.height * widget.customHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.blueAccent),
          ),
          padding: EdgeInsets.symmetric(horizontal: widget.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8.0,
              ),
              Text(
                disappearvalue == true
                    ? widget.textFieldName
                    : widget.textHidedName,
                style: TextStyle(
                    color: widget.fieldColor,
                    backgroundColor: widget.bgfieldColor,
                    fontSize: widget.fontSizeFieldName,
                    fontWeight: fieldBold,
                    fontStyle: fieldItalic,
                    decoration: fieldUnderLine),
              ),
              SizedBox(
                height: 8.0,
              ),
              value == false
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
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showMyDialog() async {
    TextEditingController fieldNameController = new TextEditingController();
    TextEditingController customWidthController = new TextEditingController();
    TextEditingController customHeightController = new TextEditingController();
    TextEditingController fontSizeFieldNameController =
        new TextEditingController();
    fieldNameController.text = widget.textFieldName;
    fontSizeFieldNameController.text = widget.fontSizeFieldName.toString();
    customWidthController.text = widget.customWidth.toString();
    customHeightController.text = widget.customHeight.toString();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(0, 24.0, 0, 24.0),
          title: Text('Camara Property Window'),
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
                          Expanded(
                            flex: 1,
                            child: Text("Filed Name"),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextField(
                              controller: fieldNameController,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "  Hide   ",
                                      style: TextStyle(
                                          color: Colors.deepOrangeAccent,
                                          fontSize: 10.0),
                                    ),
                                    Text(" Show",
                                        style: TextStyle(
                                            color: Colors.deepOrange,
                                            fontSize: 10.0)),
                                  ],
                                ),
                                Transform.scale(
                                  scale: 0.7,
                                  child: StatefulBuilder(
                                    builder: (context, _setState) {
                                      return CupertinoSwitch(
                                          thumbColor: Colors.amber,
                                          activeColor: Colors.blueGrey,
                                          value: disappearvalue,
                                          onChanged: (value) {
                                            _setState(() {
                                              this.disappearvalue = value;
                                              print(value);
                                            });
                                          });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
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
                      SizedBox(
                        height: selectedSize == "Custom" ? 10.0 : 0.0,
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
                      SizedBox(
                        height: selectedSize == "Custom" ? 16.0 : 0.0,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text("Font Size"),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: fontSizeFieldNameController,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 90.0),
                          Ink(
                            decoration: fieldBold == FontWeight.bold
                                ? const ShapeDecoration(
                                    color: Colors.grey, shape: CircleBorder())
                                : const ShapeDecoration(
                                    color: Colors.transparent,
                                    shape: CircleBorder()),
                            child: IconButton(
                              icon: const Icon(Icons.format_bold),
                              tooltip: 'Bold',
                              splashColor: Colors.grey,
                              highlightColor: Colors.grey,
                              onPressed: () {
                                _setState(() {
                                  if (fieldBold == FontWeight.normal) {
                                    fieldBold = FontWeight.bold;
                                  } else {
                                    fieldBold = FontWeight.normal;
                                  }
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Ink(
                            decoration: fieldItalic == FontStyle.italic
                                ? ShapeDecoration(
                                    color: Colors.grey, shape: CircleBorder())
                                : ShapeDecoration(
                                    shape: CircleBorder(),
                                    color: Colors.transparent),
                            child: IconButton(
                              icon: const Icon(Icons.format_italic),
                              tooltip: 'Italic',
                              splashColor: Colors.grey,
                              highlightColor: Colors.grey,
                              onPressed: () {
                                _setState(() {
                                  if (fieldItalic == FontStyle.normal) {
                                    fieldItalic = FontStyle.italic;
                                  } else {
                                    fieldItalic = FontStyle.normal;
                                  }
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Ink(
                            decoration:
                                fieldUnderLine == TextDecoration.underline
                                    ? ShapeDecoration(
                                        color: Colors.grey,
                                        shape: CircleBorder())
                                    : ShapeDecoration(
                                        color: Colors.transparent,
                                        shape: CircleBorder()),
                            child: IconButton(
                              icon: const Icon(Icons.format_underline),
                              tooltip: 'Underline',
                              splashColor: Colors.grey,
                              highlightColor: Colors.grey,
                              onPressed: () {
                                _setState(() {
                                  if (fieldUnderLine == TextDecoration.none) {
                                    fieldUnderLine = TextDecoration.underline;
                                  } else {
                                    fieldUnderLine = TextDecoration.none;
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text("Field Font Color"),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextButton(
                              child: Text(
                                "Pick Font Color",
                                style: TextStyle(
                                  color: widget.colorFieldName,
                                ),
                              ),
                              onPressed: () {
                                pickColor(context, "Pick Font Color", 1);
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text("Field Background Color"),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextButton(
                              child: Text(
                                "Pick Background Color",
                              ),
                              onPressed: () {
                                pickColor(context, "Pick Background Color", 2);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Divider(),
                      SizedBox(
                        height: 3.0,
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
                  widget.textFieldName = fieldNameController.text;
                  widget.fontSizeFieldName =
                      double.parse(fontSizeFieldNameController.text);

                  widget.customWidth = double.parse(customWidthController.text);
                  widget.customHeight =
                      double.parse(customHeightController.text);

                  fieldSetBold = fieldBold;
                  fieldSetItalic = fieldItalic;
                  fieldSetUnderLine = fieldUnderLine;

                  widget.fieldColor = widget.colorFieldName;
                  widget.bgfieldColor = widget.colorbgFieldName;

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
                      elementName: "Media",
                      element: FbCameraView(
                        color: widget.color,
                        radius: widget.radius,
                        strokeWidth: widget.strokeWidth,
                        padding: widget.padding,
                        iconSize: widget.iconSize,
                        height: widget.height,
                        textFieldName: widget.textFieldName,
                        fieldsize: widget.fieldsize,
                        fieldAlignM: widget.fieldAlignM,
                        customHeight: widget.customHeight,
                        customWidth: widget.customWidth,
                        fieldColor: widget.fieldColor,
                        colorbgFieldName: widget.colorbgFieldName,
                        bgfieldColor: widget.bgfieldColor,
                        colorFieldName: widget.colorFieldName,
                        fontSizeFieldName: widget.fontSizeFieldName,
                        textHidedName: widget.textHidedName,
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
                    widget.colorFieldName = widget.fieldColor;
                    widget.colorbgFieldName = widget.bgfieldColor;
                    fieldBold = fieldSetBold;
                    fieldItalic = fieldSetItalic;
                    fieldUnderLine = fieldSetUnderLine;
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

  void pickColor(BuildContext context, String title, int key) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Column(
            children: [
              buildPicker(key),
              TextButton(
                child: const Text('SELECT', style: TextStyle(fontSize: 20.0)),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      );

  Widget buildPicker(int key) {
    if (key == 1) {
      return ColorPicker(
          pickerColor: widget.colorFieldName!,
          onColorChanged: (color) =>
              setState(() => widget.colorFieldName = color));
    } else {
      return ColorPicker(
          pickerColor: widget.colorbgFieldName!,
          onColorChanged: (color) =>
              setState(() => widget.colorbgFieldName = color));
    }
  }
}
