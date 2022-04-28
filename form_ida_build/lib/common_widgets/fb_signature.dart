import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:form_ida_build/utils/app_constants.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class FbSignaturePad extends StatefulWidget {
  double? fieldsize;
  Alignment fieldAlignM;
  num customWidth;
  num customHeight;
  String textFieldName;
  String textHidedName;
  double imgHeight;
  double imgWidth;
  double imgContHight;
  double imgContWidth;
  List<String> sizeCheck = <String>["Small", "Medium", "Large", "Custom"];
  List<String> fieldalign = <String>["Left", "Center", "Right"];
  List<String> fNameAlign = <String>["Left", "Center", "Right"];
  double fontSizeFieldName;
  TextInputType keyboardType;
  CrossAxisAlignment fNAlign;

  Color? fieldColor1;
  Color? fieldbgColor1;
  Color? fieldColor2;
  Color? fieldbgColor2;

  Color? bgColorAll1;
  Color? bgColorAll2;

  FbSignaturePad({
    this.textFieldName = "Filed Name",
    this.textHidedName = "",
    this.fieldsize = double.infinity,
    this.fieldAlignM = Alignment.centerLeft,
    this.customWidth = 0.8,
    this.customHeight = 0.26,
    this.imgHeight = 400,
    this.imgWidth = 400,
    this.imgContHight = 130,
    this.imgContWidth = 130,
    this.fontSizeFieldName = 18.0,
    this.keyboardType = TextInputType.number,
    this.fNAlign = CrossAxisAlignment.center,
    this.fieldColor1 = Colors.black,
    this.fieldbgColor1 = Colors.white,
    this.bgColorAll1 = Colors.white,
    this.fieldColor2 = Colors.black,
    this.fieldbgColor2 = Colors.white,
    this.bgColorAll2 = Colors.white,
  });

  @override
  _FbSignaturePadState createState() => _FbSignaturePadState();
}

class _FbSignaturePadState extends State<FbSignaturePad> {
  bool disappearvalue = true;
  bool disappearsetValue = true;

  bool mandotoryvalue = false;
  bool mandotorysetValue = false;

  String selectedSize = "Large";
  String selectedsetSize = "Large";

  String selectedfieldalign = "Left";
  String selectedsetfieldalign = "Left";

  Color selectedfontColor = Colors.black;
  Color selectedsetfontColor = Colors.black;

  String selectedFNameAlign = "Left";
  String selectedsetFNameAlign = "Left";

  FontWeight fieldBold = FontWeight.normal;
  FontWeight fieldSetBold = FontWeight.normal;

  FontStyle fieldItalic = FontStyle.normal;
  FontStyle fieldSetItalic = FontStyle.normal;

  TextDecoration fieldUnderLine = TextDecoration.none;
  TextDecoration fieldSetUnderLine = TextDecoration.none;

  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  dynamic _pickImageError;

  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    await _displayPickImageDialog(context!,
        (double? maxWidth, double? maxHeight, int? quality) async {
      try {
        final XFile? pickedFile = await _picker.pickImage(
          source: source,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          imageQuality: quality,
        );
        setState(() {
          _imageFile = pickedFile;
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    });
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    maxWidthController.dispose();
    maxHeightController.dispose();
    qualityController.dispose();
    super.dispose();
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return Semantics(
          child: ListView.builder(
            key: UniqueKey(),
            itemBuilder: (BuildContext context, int index) {
              return Semantics(
                label: 'image_picker_example_picked_image',
                child: kIsWeb
                    ? Image.network(_imageFileList![index].path)
                    : Image.file(File(_imageFileList![index].path)),
              );
            },
            itemCount: _imageFileList!.length,
          ),
          label: 'image_picker_example_picked_images');
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.image) {
        setState(() {
          _imageFile = response.file;
          _imageFileList = response.files;
        });
      }
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    final info = statuses[Permission.storage].toString();
    print(info);
    // _toastInfo(info);
  }

  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }

  void _handleSaveButtonPressed() async {
    RenderSignaturePad boundary = signatureGlobalKey.currentContext!
        .findRenderObject() as RenderSignaturePad;
    ui.Image image = await boundary.toImage();
    ByteData byteData = await (image.toByteData(format: ui.ImageByteFormat.png)
        as FutureOr<ByteData>);
    if (byteData != null) {
      final time = DateTime.now().millisecond;
      final name = "signature_$time.png";
      final result = await ImageGallerySaver.saveImage(
          byteData.buffer.asUint8List(),
          quality: 100,
          name: name);
      print(result);
      // _toastInfo(result.toString());

      final isSuccess = result['isSuccess'];
      signatureGlobalKey.currentState!.clear();
    }
  }

  // _toastInfo(String info) {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text(info),
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showMyDialog();
      },
      child: Container(
        alignment: widget.fieldAlignM,
        child: Container(
          width: widget.fieldsize,
          height: MediaQuery.of(context).size.height * widget.customHeight,
          decoration: BoxDecoration(
            color: widget.bgColorAll2,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.blueAccent),
          ),
          padding: EdgeInsets.fromLTRB(10, 12, 10, 0),
          child: Column(crossAxisAlignment: widget.fNAlign, children: [
            SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  disappearvalue == true
                      ? widget.textFieldName
                      : widget.textHidedName,
                  style: TextStyle(
                    color: widget.fieldColor2,
                    backgroundColor: widget.fieldbgColor2,
                    fontSize: widget.fontSizeFieldName,
                    fontWeight: fieldBold,
                    fontStyle: fieldItalic,
                    decoration: fieldUnderLine,
                  ),
                ),
                Container(
                  height: 30,
                  width: 30,
                  child: Semantics(
                    label: 'image_picker_example_from_gallery',
                    child: FloatingActionButton(
                      onPressed: () {
                        _onImageButtonPressed(ImageSource.gallery,
                            context: context);
                      },
                      heroTag: 'image0',
                      tooltip: 'Pick Image from gallery',
                      child: const Icon(Icons.photo),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: widget.imgContHight,
              width: widget.imgContWidth,
              child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
                  ? FutureBuilder<void>(
                      future: retrieveLostData(),
                      builder:
                          (BuildContext context, AsyncSnapshot<void> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return const Text(
                              'You have not yet picked an image.',
                              textAlign: TextAlign.center,
                            );
                          case ConnectionState.done:
                            return _previewImages();
                          default:
                            if (snapshot.hasError) {
                              return Text(
                                'Pick image/video error: ${snapshot.error}}',
                                textAlign: TextAlign.center,
                              );
                            } else {
                              return const Text(
                                'You have not yet picked an image.',
                                textAlign: TextAlign.center,
                              );
                            }
                        }
                      },
                    )
                  : _previewImages(),
            )
          ]),
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
    TextEditingController customimgHeight = new TextEditingController();
    customimgHeight.text = widget.imgContHight.toString();
    TextEditingController customimgWidth = new TextEditingController();
    customimgWidth.text = widget.imgContWidth.toString();
    fieldNameController.text = widget.textFieldName;
    customWidthController.text = widget.customWidth.toString();
    customHeightController.text = widget.customHeight.toString();
    fontSizeFieldNameController.text = widget.fontSizeFieldName.toString();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(0, 24.0, 0, 24.0),
            title: Text('Signature Property Window'),
            content: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.all(8.0),
              child: StatefulBuilder(
                builder: (context, _setState) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Text("   Signature",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                                child: SfSignaturePad(
                                    key: signatureGlobalKey,
                                    backgroundColor: Colors.white,
                                    strokeColor: Colors.black,
                                    minimumStrokeWidth: 3.0,
                                    maximumStrokeWidth: 6.0),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)))),
                        Row(children: <Widget>[
                          TextButton(
                            child: Text(
                              'Save As Image',
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: _handleSaveButtonPressed,
                          ),
                          TextButton(
                            child:
                                Text('Clear', style: TextStyle(fontSize: 20)),
                            onPressed: _handleClearButtonPressed,
                          )
                        ], mainAxisAlignment: MainAxisAlignment.spaceEvenly),
                        SizedBox(
                          height: 10,
                        ),
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
                            Expanded(
                              flex: 1,
                              child: Text("signature Image Alignment"),
                            ),
                            Expanded(
                              flex: 2,
                              child: DropdownButtonFormField<String>(
                                  value: selectedFNameAlign,
                                  items: widget.fNameAlign.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          textAlign: TextAlign.center),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    _setState(() {
                                      selectedFNameAlign = newValue!;
                                    });
                                  }),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0),
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
                              flex: 2,
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
                              child: Text("Field Font Size"),
                            ),
                            Expanded(
                              flex: 2,
                              child: TextField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                controller: fontSizeFieldNameController,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0),
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
                        SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text("Field Name Color"),
                            ),
                            Expanded(
                              flex: 2,
                              child: TextButton(
                                child: Text(
                                  "Pick Font Color",
                                  style: TextStyle(
                                    color: widget.fieldColor1,
                                  ),
                                ),
                                onPressed: () {
                                  pickColor(context, "Pick Font Color", 3);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text("Field Name BG Color"),
                            ),
                            Expanded(
                              flex: 2,
                              child: TextButton(
                                child: Text(
                                  "Pick Background Color",
                                ),
                                onPressed: () {
                                  pickColor(
                                      context, "Pick Background Color", 4);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Divider(),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text("Field BG Color"),
                            ),
                            Expanded(
                              flex: 2,
                              child: TextButton(
                                child: Text(
                                  "Pick Background Color",
                                ),
                                onPressed: () {
                                  pickColor(
                                      context, "Pick Background Color", 6);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 1, child: Text("Custom Image Height")),
                            Expanded(
                                flex: 2,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  keyboardType: widget.keyboardType,
                                  controller: customimgHeight,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 1, child: Text("Custom Image Width")),
                            Expanded(
                                flex: 2,
                                child: TextField(
                                    textAlign: TextAlign.center,
                                    keyboardType: widget.keyboardType,
                                    controller: customimgWidth)),
                          ],
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
                    widget.textFieldName = fieldNameController.text;
                    disappearsetValue = disappearvalue;
                    widget.fontSizeFieldName =
                        double.parse(fontSizeFieldNameController.text);
                    mandotorysetValue = mandotoryvalue;
                    selectedsetfieldalign = selectedfieldalign;
                    widget.imgContHight = double.parse(customimgHeight.text);
                    widget.imgContWidth = double.parse(customimgWidth.text);
                    selectedsetfontColor = selectedfontColor;
                    selectedsetSize = selectedSize;
                    selectedsetFNameAlign = selectedFNameAlign;

                    widget.fieldColor2 = widget.fieldColor1;
                    widget.fieldbgColor2 = widget.fieldbgColor1;

                    widget.bgColorAll2 = widget.bgColorAll1;

                    fieldSetBold = fieldBold;
                    fieldSetItalic = fieldItalic;
                    fieldSetUnderLine = fieldUnderLine;

                    if (selectedfieldalign == "Left") {
                      widget.fieldAlignM = Alignment.centerLeft;
                    } else if (selectedfieldalign == "Center") {
                      widget.fieldAlignM = Alignment.center;
                    } else if (selectedfieldalign == "Right") {
                      widget.fieldAlignM = Alignment.centerRight;
                    }
                    widget.customWidth =
                        double.parse(customWidthController.text);
                    widget.customHeight =
                        double.parse(customHeightController.text);
                    if (selectedSize == "Small") {
                      widget.fieldsize =
                          MediaQuery.of(context).size.width * 0.40;
                    } else if (selectedSize == "Medium") {
                      widget.fieldsize =
                          MediaQuery.of(context).size.width * 0.60;
                    } else if (selectedSize == "Large") {
                      widget.fieldsize = MediaQuery.of(context).size.width;
                    } else if (selectedSize == "Custom") {
                      widget.fieldsize = MediaQuery.of(context).size.width *
                          widget.customWidth;
                    }
                    if (selectedFNameAlign == "Left") {
                      widget.fNAlign = CrossAxisAlignment.start;
                    } else if (selectedFNameAlign == "Center") {
                      widget.fNAlign = CrossAxisAlignment.center;
                    } else if (selectedFNameAlign == "Right") {
                      widget.fNAlign = CrossAxisAlignment.end;
                    }
                  });
                },
              ),
              TextButton(
                  child:
                      const Text('Duplicate', style: TextStyle(fontSize: 15.0)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      // _HomePage
                      AppConstants.elementsList.add(ElementTypes(
                          elementName: "Signature",
                          element: FbSignaturePad(
                            fieldsize: widget.fieldsize,
                            fieldAlignM: widget.fieldAlignM,
                            customHeight: widget.customHeight,
                            customWidth: widget.customWidth,
                            textFieldName: widget.textFieldName,
                            textHidedName: widget.textHidedName,
                            bgColorAll1: widget.bgColorAll1,
                            bgColorAll2: widget.bgColorAll2,
                            fNAlign: widget.fNAlign,
                            fieldColor1: widget.fieldColor1,
                            fieldColor2: widget.fieldColor2,
                            fieldbgColor1: widget.fieldbgColor1,
                            fieldbgColor2: widget.fieldbgColor2,
                            fontSizeFieldName: widget.fontSizeFieldName,
                            imgContHight: widget.imgContHight,
                            imgContWidth: widget.imgContWidth,
                            imgHeight: widget.imgHeight,
                            imgWidth: widget.imgWidth,
                            keyboardType: widget.keyboardType,
                          ),
                          elementId: "Signature${AppConstants.elementID}"));
                    });
                  }),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      if (disappearsetValue != disappearvalue) {
                        disappearvalue = disappearsetValue;
                      }
                      if (selectedsetfieldalign != selectedfieldalign) {
                        selectedfieldalign = selectedsetfieldalign;
                      }
                      if (mandotorysetValue != mandotoryvalue) {
                        mandotoryvalue = mandotorysetValue;
                      }
                      if (selectedsetSize != selectedSize) {
                        selectedSize = selectedsetSize;
                      }
                      if (selectedsetfontColor != selectedfontColor) {
                        selectedfontColor = selectedsetfontColor;
                      }
                      if (selectedsetFNameAlign != selectedFNameAlign) {
                        selectedFNameAlign = selectedsetFNameAlign;
                      }
                      widget.fieldColor1 = widget.fieldColor2;
                      widget.fieldbgColor1 = widget.fieldbgColor2;

                      fieldBold = fieldSetBold;
                      fieldItalic = fieldSetItalic;
                      fieldUnderLine = fieldSetUnderLine;
                    });
                  },
                  child: const Text(
                    'Close',
                    style: TextStyle(fontSize: 15.0),
                  )),
            ]);
      },
    );
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
    if (key == 3) {
      return ColorPicker(
          pickerColor: widget.fieldColor1!,
          onColorChanged: (color) =>
              setState(() => widget.fieldColor1 = color));
    } else if (key == 4) {
      return ColorPicker(
          pickerColor: widget.fieldbgColor1!,
          onColorChanged: (color) =>
              setState(() => widget.fieldbgColor1 = color));
    } else {
      return ColorPicker(
          pickerColor: widget.bgColorAll1!,
          onColorChanged: (color) =>
              setState(() => widget.bgColorAll1 = color));
    }
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add optional parameters'),
            content: Column(
              children: <Widget>[
                TextField(
                  controller: maxWidthController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      hintText: 'Enter maxWidth if desired'),
                ),
                TextField(
                  controller: maxHeightController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      hintText: 'Enter maxHeight if desired'),
                ),
                TextField(
                  controller: qualityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Enter quality if desired'),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: const Text('PICK'),
                  onPressed: () {
                    final double? width = maxWidthController.text.isNotEmpty
                        ? double.parse(maxWidthController.text)
                        : widget.imgWidth;
                    final double? height = maxHeightController.text.isNotEmpty
                        ? double.parse(maxHeightController.text)
                        : widget.imgHeight;
                    final int? quality = qualityController.text.isNotEmpty
                        ? int.parse(qualityController.text)
                        : 100;
                    onPick(width, height, quality);
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);
