import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:form_ida_build/utils/app_constants.dart';

class FbDatePicker extends StatefulWidget {
  List<String> textalignM = <String>["Left", "Center", "Right"];
  MainAxisAlignment textAlign;
  double fontSize;
  double? fontSizeFieldName;

  Color? txtColor1;
  Color? textbgColor1;
  Color? txtColor2;
  Color? textbgColor2;

  Color? fieldColor1;
  Color? fieldbgColor1;
  Color? fieldColor2;
  Color? fieldbgColor2;

  FbDatePicker({
    this.textAlign = MainAxisAlignment.start,
    this.fontSize = 18.0,
    this.fontSizeFieldName = 20.0,
    this.txtColor1 = Colors.black,
    this.textbgColor1 = Colors.white60,
    this.fieldColor1 = Colors.black,
    this.fieldbgColor1 = Colors.white,
    this.txtColor2 = Colors.black,
    this.textbgColor2 = Colors.white,
    this.fieldColor2 = Colors.black,
    this.fieldbgColor2 = Colors.white,
  });

  @override
  _FbDatePickerState createState() => _FbDatePickerState();
}

class _FbDatePickerState extends State<FbDatePicker> {
  DateTime? date;
  // DateTime? time;

  bool mandotoryvalue = false;
  bool mandotorysetValue = false;

  String selectedtext = "Left";
  String selectedsettext = "Left";

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
      onLongPress: () {
        showMyDialog();
      },
      child: TextButton(
        onPressed: () async {
          // setState(() {
          //   datepick();
          // });
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1990),
              lastDate: DateTime(2200));
          if (pickedDate != null) {
            setState(() {
              date = pickedDate;
            });
          } else {
            setState(() {
              date = DateTime.now();
            });
          }
        },
        child: Row(mainAxisAlignment: widget.textAlign, children: [
          Text(
            "Date:",
            style: TextStyle(
                color: widget.fieldColor2,
                backgroundColor: widget.fieldbgColor2,
                fontSize: widget.fontSizeFieldName,
                fontWeight: fieldBold,
                fontStyle: fieldItalic,
                decoration: fieldUnderLine),
          ),
          SizedBox(width: 10),
          Text(
            date != null
                ? date.toString().split(" ")[0]
                : DateTime.now().toString().split(" ")[0],
            style: TextStyle(
                fontSize: widget.fontSize,
                color: widget.txtColor2,
                backgroundColor: widget.textbgColor2,
                fontWeight: textBold,
                fontStyle: textItalic,
                decoration: textUnderLine),
          )
        ]),
      ),
    );
  }

  Future<void> showMyDialog() async {
    TextEditingController fontSize = new TextEditingController();
    TextEditingController fontSizeFieldNameController =
        new TextEditingController();
    fontSize.text = widget.fontSize.toString();
    fontSizeFieldNameController.text = widget.fontSizeFieldName.toString();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(0, 24.0, 0, 24.0),
            title: Text('Date Property Window'),
            content: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.all(8.0),
              child: StatefulBuilder(
                builder: (context, _setState) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(flex: 1, child: Text("Alignment")),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                  value: selectedtext,
                                  items: widget.textalignM.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    _setState(() {
                                      selectedtext = newValue!;
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
                              decoration:
                                  textUnderLine == TextDecoration.underline
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
                                  pickColor(
                                      context, "Pick Background Color", 2);
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
                    selectedsettext = selectedtext;
                    widget.fontSizeFieldName =
                        double.parse(fontSizeFieldNameController.text);

                    widget.txtColor2 = widget.txtColor1;
                    widget.textbgColor2 = widget.textbgColor1;

                    widget.fieldColor2 = widget.fieldColor1;
                    widget.fieldbgColor2 = widget.fieldbgColor1;

                    textSetBold = textBold;
                    textSetItalic = textItalic;
                    textSetUnderLine = textUnderLine;

                    fieldSetBold = fieldBold;
                    fieldSetItalic = fieldItalic;
                    fieldSetUnderLine = fieldUnderLine;

                    widget.fontSize = double.parse(fontSize.text);

                    if (selectedtext == "Left") {
                      widget.textAlign = MainAxisAlignment.start;
                    } else if (selectedtext == "Center") {
                      widget.textAlign = MainAxisAlignment.center;
                    } else if (selectedtext == "Right") {
                      widget.textAlign = MainAxisAlignment.end;
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
                          elementName: "Date",
                          element: FbDatePicker(
                            fieldColor1: widget.fieldColor1,
                            fieldColor2: widget.fieldColor2,
                            fieldbgColor1: widget.fieldbgColor1,
                            fieldbgColor2: widget.fieldbgColor2,
                            fontSize: widget.fontSize,
                            fontSizeFieldName: widget.fontSizeFieldName,
                            textAlign: widget.textAlign,
                            textbgColor1: widget.textbgColor1,
                            textbgColor2: widget.textbgColor2,
                            txtColor1: widget.txtColor1,
                            txtColor2: widget.txtColor2,
                          ),
                          elementId: "Date${AppConstants.elementID}"));
                    });
                  }),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      if (selectedsettext != selectedtext) {
                        selectedtext = selectedsettext;
                      }
                      if (mandotorysetValue != mandotoryvalue) {
                        mandotoryvalue = mandotorysetValue;
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
    } else {
      return ColorPicker(
          pickerColor: widget.fieldbgColor1!,
          onColorChanged: (color) =>
              setState(() => widget.fieldbgColor1 = color));
    }
  }

  // Future<void> datepick() async {
  //   date = await showDatePicker(
  //       context: context,
  //       initialDate: date ?? DateTime.now(),
  //       firstDate: DateTime(1995),
  //       lastDate: DateTime(2500));
  // }
}
