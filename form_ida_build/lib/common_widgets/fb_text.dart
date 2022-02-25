import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:form_ida_build/utils/app_constants.dart';

// enum TextAlignmentsEnum {
//   LEFT,
//   CENTER,
//   RIGHT,
// }

class FbText extends StatefulWidget {
  List<String> alignCheck = <String>["Left", "Center", "Right"];
  String text;
  Color? color;
  Color? backgroundColor;
  double? fontSize;
  TextAlign textAlign;
  TextDirection? textDirection;
  int? maxLines;
  static bool mandatory = false;

  FbText({
    this.text = "Sample Text",
    this.fontSize = 15.0,
    this.color = Colors.black,
    this.backgroundColor = Colors.white,
    this.textAlign = TextAlign.left,
    this.textDirection,
    this.maxLines,
  });

  @override
  _FbTextState createState() => _FbTextState();
}

class _FbTextState extends State<FbText> {
  // TextAlignmentsEnum alignmentsEnum = TextAlignmentsEnum.LEFT;

  String selectedAlign = "Left";
  String selectedSetAlign = "Left";

  bool checkBoxValue = false;

  bool mandotoryvalue = false;
  bool mandotorysetValue = false;

  FontWeight textBold = FontWeight.normal;
  FontWeight textSetBold = FontWeight.normal;

  FontStyle textItalic = FontStyle.normal;
  FontStyle textSetItalic = FontStyle.normal;

  TextDecoration textUnderLine = TextDecoration.none;
  TextDecoration textSetUnderLine = TextDecoration.none;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showMyDialog();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.0),
        child: Text(
          widget.text,
          style: TextStyle(
          color: widget.color,
          backgroundColor: widget.backgroundColor,
          fontSize: widget.fontSize,
          ),
          textAlign: widget.textAlign,
          textDirection: widget.textDirection,
          maxLines: widget.maxLines,
        )
      ),
    );
  }

  Future<void> showMyDialog() async {
    TextEditingController textController = new TextEditingController();
    TextEditingController fontSizeController = new TextEditingController();
    textController.text = widget.text;
    fontSizeController.text = widget.fontSize.toString();
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
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
                          Expanded(
                            flex: 1,
                            child: Text("Text"),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextField(
                              controller: textController,
                            ),
                          ),
                        ],
                      ),
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
                              controller: fontSizeController,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(flex: 1, child: Text("Text Alignment")),
                          Expanded(
                            flex: 2,
                            child: DropdownButtonFormField<String>(
                                value: selectedAlign,
                                // value: selectedSize == "Small" ? widget.sizeCheck[0] : selectedSize == "Medium" ? widget.sizeCheck[1] : widget.sizeCheck[2],
                                items: widget.alignCheck.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  _setState(() {
                                    print(newValue);
                                    selectedAlign = newValue!;
                                  });
                                }),
                          ),
                        ],
                      ),
                      // Text("Text Alignment"),
                      // Column(
                      //   children: <Widget>[
                      //     ListTile(
                      //       title: Text('Left'),
                      //       leading: Radio<TextAlignmentsEnum>(
                      //         value: TextAlignmentsEnum.LEFT,
                      //         groupValue: alignmentsEnum,
                      //         onChanged: (val) {
                      //           _setState(() {
                      //             alignmentsEnum = val!;
                      //             widget.textAlign = TextAlign.left;
                      //             selectedAlign = "Left";
                      //           });
                      //         },
                      //       ),
                      //     ),
                      //     ListTile(
                      //       title: Text('Center'),
                      //       leading: Radio<TextAlignmentsEnum>(
                      //         value: TextAlignmentsEnum.CENTER,
                      //         groupValue: alignmentsEnum,
                      //         onChanged: (val) {
                      //           _setState(() {
                      //             alignmentsEnum = val!;
                      //             widget.textAlign = TextAlign.center;
                      //             selectedAlign = "Center";
                      //           });
                      //         },
                      //       ),
                      //     ),
                      //     ListTile(
                      //       title: Text('Right'),
                      //       leading: Radio<TextAlignmentsEnum>(
                      //         value: TextAlignmentsEnum.RIGHT,
                      //         groupValue: alignmentsEnum,
                      //         onChanged: (val) {
                      //           _setState(() {
                      //             alignmentsEnum = val!;
                      //             widget.textAlign = TextAlign.right;
                      //             selectedAlign = "Right";
                      //           });
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text("Font Color"),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextButton(
                              child: Text(
                                "Pick Font Color",
                                style: TextStyle(
                                  color: widget.color,
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
                            child: Text("background Color"),
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
                  widget.text = textController.text;
                  widget.fontSize = double.parse(fontSizeController.text);
                  selectedSetAlign = selectedAlign;
                  if (selectedAlign == "Left") {
                    widget.textAlign = TextAlign.left;
                  } else if (selectedAlign == "Center") {
                    widget.textAlign = TextAlign.center;
                  } else if (selectedAlign == "Right") {
                    widget.textAlign = TextAlign.right;
                  }
                  mandotorysetValue = mandotoryvalue;
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
                      element: FbText(
                        text: widget.text,
                        fontSize: widget.fontSize,
                        color: widget.color,
                        backgroundColor: widget.backgroundColor,
                      ),
                      elementId: "Text${AppConstants.elementID}"));
                });
              },
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    if (selectedSetAlign != selectedAlign) {
                      selectedAlign = selectedSetAlign;
                    }
                    if (mandotorysetValue != mandotoryvalue) {
                      mandotoryvalue = mandotorysetValue;
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
          pickerColor: widget.color!,
          onColorChanged: (color) => setState(() => widget.color = color));
    } else {
      return ColorPicker(
          pickerColor: widget.backgroundColor!,
          onColorChanged: (color) =>
              setState(() => widget.backgroundColor = color));
    }
  }
}
