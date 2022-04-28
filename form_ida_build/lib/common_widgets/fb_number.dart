import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:form_ida_build/utils/app_constants.dart';

class FbNumber extends StatefulWidget {
  int value;
  double fontSize;
  List<String> sizeCheck = <String>["Small", "Medium", "Large", "Custom"];
  double? fieldsize;
  List<String> fieldalign = <String>["Left", "Center", "Right"];
  Alignment fieldAlignM;
  List<String> fNameAlign = <String>["Left", "Center", "Right"];
  CrossAxisAlignment fNAlign;
  num customWidth;
  num customHeight;
  String textFieldName;
  String textHidedName;
  double? fontSizeFieldName;

  Color? txtColor1;
  Color? textbgColor1;
  Color? txtColor2;
  Color? textbgColor2;

  Color? fieldColor1;
  Color? fieldbgColor1;
  Color? fieldColor2;
  Color? fieldbgColor2;

  Color? bgColorAll1;
  Color? bgColorAll2;

  FbNumber({
    this.value = 0,
    this.textFieldName = "Filed Name",
    this.textHidedName = "",
    this.fontSize = 30.0,
    this.fontSizeFieldName = 15.0,
    this.fieldsize = double.infinity,
    this.fieldAlignM = Alignment.centerLeft,
    this.customWidth = 0.9,
    this.customHeight = 0.125,
    this.fNAlign = CrossAxisAlignment.start,
    this.txtColor1 = Colors.black,
    this.textbgColor1 = Colors.white60,
    this.fieldColor1 = Colors.black,
    this.fieldbgColor1 = Colors.white,
    this.bgColorAll1 = Colors.white,
    this.txtColor2 = Colors.black,
    this.textbgColor2 = Colors.white,
    this.fieldColor2 = Colors.black,
    this.fieldbgColor2 = Colors.white,
    this.bgColorAll2 = Colors.white,
  });

  @override
  _FbNumberState createState() => _FbNumberState();
}

class _FbNumberState extends State<FbNumber> {
  bool disappearvalue = true;
  bool disappearsetValue = true;

  bool mandotoryvalue = false;
  bool mandotorysetValue = false;

  String selectedSize = "Large";
  String selectedsetSize = "Large";

  String selectedfieldalign = "Left";
  String selectedsetfieldalign = "Left";

  String selectedFNameAlign = "Left";
  String selectedsetFNameAlign = "Left";

  FontWeight textBold = FontWeight.normal;
  FontWeight textSetBold = FontWeight.normal;

  FontStyle textItalic = FontStyle.normal;
  FontStyle textSetItalic = FontStyle.normal;

  TextDecoration textUnderLine = TextDecoration.none;
  TextDecoration textSetUnderLine = TextDecoration.none;

  FontWeight fieldBold = FontWeight.normal;
  FontWeight fieldSetBold = FontWeight.normal;

  FontStyle fieldItalic = FontStyle.normal;
  FontStyle fieldSetItalic = FontStyle.normal;

  TextDecoration fieldUnderLine = TextDecoration.none;
  TextDecoration fieldSetUnderLine = TextDecoration.none;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: showMyDialog,
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
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: widget.fNAlign,
            children: [
              SizedBox(
                height: 8.0,
              ),
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
                    decoration: fieldUnderLine),
              ),
              SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: decrease,
                    child: Container(
                      decoration: BoxDecoration(
                        color: widget.bgColorAll2,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: Colors.blueAccent),
                      ),
                      padding: EdgeInsets.all(4.0),
                      width: 50,
                      height: 50,
                      child: Text(
                        "-",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      "${widget.value}",
                      style: TextStyle(
                        fontSize: widget.fontSize,
                        color: widget.txtColor2,
                        backgroundColor: widget.textbgColor2,
                        fontWeight: textBold,
                        fontStyle: textItalic,
                        decoration: textUnderLine,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: increase,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: Colors.blueAccent),
                      ),
                      padding: EdgeInsets.all(4.0),
                      width: 50,
                      height: 50,
                      child: Text(
                        "+",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void increase() {
    setState(() {
      widget.value = widget.value + 1;
    });
  }

  void decrease() {
    setState(() {
      widget.value = widget.value - 1;
    });
  }

  Future<void> showMyDialog() async {
    TextEditingController numberValue = new TextEditingController();
    TextEditingController fontSize = new TextEditingController();
    TextEditingController fieldNameController = new TextEditingController();
    TextEditingController customWidthController = new TextEditingController();
    TextEditingController customHeightController = new TextEditingController();
    TextEditingController fontSizeController = new TextEditingController();
    TextEditingController fontSizeFieldNameController =
        new TextEditingController();
    numberValue.text = "${widget.value}";
    fontSize.text = widget.fontSize.toString();
    fieldNameController.text = widget.textFieldName;
    customWidthController.text = widget.customWidth.toString();
    customHeightController.text = widget.customHeight.toString();
    fontSizeController.text = widget.fontSize.toString();
    fontSizeFieldNameController.text = widget.fontSizeFieldName.toString();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(0, 24.0, 0, 24.0),
          title: Text('Number Property Window'),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.all(8.0),
            child: StatefulBuilder(builder: (context, _setState) {
              return SingleChildScrollView(
                child: Column(
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
                        Expanded(
                          flex: 1,
                          child: Text("Field Name Alignment"),
                        ),
                        Expanded(
                          flex: 2,
                          child: DropdownButtonFormField<String>(
                              value: selectedFNameAlign,
                              items: widget.fNameAlign.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
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
                          decoration: fieldUnderLine == TextDecoration.underline
                              ? ShapeDecoration(
                                  color: Colors.grey, shape: CircleBorder())
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
                              pickColor(context, "Pick Background Color", 4);
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
                          child: Text("Text Font Size"),
                        ),
                        Expanded(
                          flex: 2,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: fontSize,
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
                          decoration: textBold == FontWeight.bold
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
                                if (textBold == FontWeight.normal) {
                                  textBold = FontWeight.bold;
                                } else {
                                  textBold = FontWeight.normal;
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Ink(
                          decoration: textItalic == FontStyle.italic
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
                                if (textItalic == FontStyle.normal) {
                                  textItalic = FontStyle.italic;
                                } else {
                                  textItalic = FontStyle.normal;
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Ink(
                          decoration: textUnderLine == TextDecoration.underline
                              ? ShapeDecoration(
                                  color: Colors.grey, shape: CircleBorder())
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
                                if (textUnderLine == TextDecoration.none) {
                                  textUnderLine = TextDecoration.underline;
                                } else {
                                  textUnderLine = TextDecoration.none;
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
                          child: Text("Text Color"),
                        ),
                        Expanded(
                          flex: 2,
                          child: TextButton(
                            child: Text(
                              "Pick Font Color",
                              style: TextStyle(
                                color: widget.txtColor1,
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
                          child: Text("Text BG Color"),
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
                              pickColor(context, "Pick Background Color", 5);
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text("Initial Value"),
                        ),
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: numberValue,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ADD', style: TextStyle(fontSize: 15.0)),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  widget.value = int.parse(numberValue.text);
                  widget.textFieldName = fieldNameController.text;
                  disappearsetValue = disappearvalue;
                  selectedsetFNameAlign = selectedFNameAlign;
                  widget.fontSizeFieldName =
                      double.parse(fontSizeFieldNameController.text);
                  selectedsetSize = selectedSize;

                  widget.txtColor2 = widget.txtColor1;
                  widget.textbgColor2 = widget.textbgColor1;

                  widget.fieldColor2 = widget.fieldColor1;
                  widget.fieldbgColor2 = widget.fieldbgColor1;

                  widget.bgColorAll2 = widget.bgColorAll1;

                  textSetBold = textBold;
                  textSetItalic = textItalic;
                  textSetUnderLine = textUnderLine;

                  fieldSetBold = fieldBold;
                  fieldSetItalic = fieldItalic;
                  fieldSetUnderLine = fieldUnderLine;

                  widget.fontSize = double.parse(fontSize.text);
                  mandotorysetValue = mandotoryvalue;
                  selectedsetfieldalign = selectedfieldalign;
                  if (selectedfieldalign == "Left") {
                    widget.fieldAlignM = Alignment.centerLeft;
                  } else if (selectedfieldalign == "Center") {
                    widget.fieldAlignM = Alignment.center;
                  } else if (selectedfieldalign == "Right") {
                    widget.fieldAlignM = Alignment.centerRight;
                  }
                  widget.customWidth = double.parse(customWidthController.text);
                  widget.customHeight =
                      double.parse(customHeightController.text);
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
                        elementName: "Number",
                        element: FbNumber(
                          value: widget.value,
                          textFieldName: widget.textFieldName,
                          textHidedName: widget.textHidedName,
                          bgColorAll1: widget.bgColorAll1,
                          bgColorAll2: widget.bgColorAll2,
                          customHeight: widget.customHeight,
                          customWidth: widget.customWidth,
                          fNAlign: widget.fNAlign,
                          fieldAlignM: widget.fieldAlignM,
                          fieldColor1: widget.fieldColor1,
                          fieldColor2: widget.fieldColor2,
                          fieldbgColor1: widget.fieldbgColor1,
                          fieldbgColor2: widget.fieldbgColor2,
                          fieldsize: widget.fieldsize,
                          fontSize: widget.fontSize,
                          fontSizeFieldName: widget.fontSizeFieldName,
                          textbgColor1: widget.textbgColor1,
                          textbgColor2: widget.textbgColor2,
                          txtColor1: widget.txtColor1,
                          txtColor2: widget.txtColor2,
                        ),
                        elementId: "Number${AppConstants.elementID}"));
                  });
                }),
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
                    if (disappearsetValue != disappearvalue) {
                      disappearvalue = disappearsetValue;
                    }
                    if (selectedsetFNameAlign != selectedFNameAlign) {
                      selectedFNameAlign = selectedsetFNameAlign;
                    }

                    widget.txtColor1 = widget.txtColor2;
                    widget.textbgColor1 = widget.textbgColor2;
                    widget.fieldColor1 = widget.fieldColor2;
                    widget.fieldbgColor1 = widget.fieldbgColor2;

                    textBold = textSetBold;
                    textItalic = textSetItalic;
                    textUnderLine = textSetUnderLine;

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
          pickerColor: widget.txtColor1!,
          onColorChanged: (color) => setState(() => widget.txtColor1 = color));
    } else if (key == 2) {
      return ColorPicker(
          pickerColor: widget.textbgColor1!,
          onColorChanged: (color) =>
              setState(() => widget.textbgColor1 = color));
    } else if (key == 3) {
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
}
