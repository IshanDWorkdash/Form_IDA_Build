import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:form_ida_build/common_widgets/advanced/fb_camera_image.dart';
import 'package:form_ida_build/utils/app_constants.dart';

class FbInformation extends StatefulWidget {
  List<String> sizeCheck = <String>["Small", "Medium", "Large", "Custom"];
  List<String> fieldTypeCheck = <String>["Text", "Media", "Web Link"];
  List<String> textalign = <String>["Left", "Center", "Right"];
  List<String> fieldalign = <String>["Left", "Center", "Right"];
  List<String> setborderwidth = <String>["0", "1", "2", "3"];
  List<String> setshadow = <String>["0", "1", "2", "3", "4", "5"];
  String text;
  String webLink;
  CrossAxisAlignment txtAlign;
  Alignment fieldAlignM;
  String textFieldName;
  String textHidedName;
  double? fieldsize;
  num customWidth;
  num customHeight;
  double? fontSize;
  num mediaWidth;
  num mediaHeight;
  double borderwidth;
  double shadow;
  double mediaBorderWidth;

  FbInformation({
    this.textFieldName = "Filed Name",
    this.textHidedName = "",
    this.text = "Sample Text",
    this.webLink = "sampleText@xyz.com",
    this.txtAlign = CrossAxisAlignment.start,
    this.fieldAlignM = Alignment.centerLeft,
    this.fieldsize = double.infinity,
    this.customWidth = 0.9,
    this.customHeight = 0.15,
    this.fontSize = 15.0,
    this.mediaWidth = 0.9,
    this.mediaHeight = 0.15,
    this.borderwidth = 1.0,
    this.shadow = 0.0,
    this.mediaBorderWidth = 0.0,
  });

  @override
  _FbInformationState createState() => _FbInformationState();
}

class _FbInformationState extends State<FbInformation> {
  bool disappearvalue = false;
  bool disappearsetValue = false;

  String selectedSize = "Large";
  String selectedsetSize = "Large";

  String selectedFieldType = "Text";
  String selectedsetFieldType = "Text";

  String selectedtextalign = "Left";
  String selectedsettextalign = "Left";

  String selectedfieldalign = "Left";
  String selectedsetfieldalign = "Left";

  Color selectedfontColor = Colors.black;
  Color selectedsetfontColor = Colors.black;

  String selectedborderwidth = "1";
  String selectedsetborderwidth = "1";

  String selectedshadow = "0";
  String selectedsetshadow = "0";

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _rulesController;
  static List rulesList = [null];

  @override
  void initState() {
    super.initState();
    _rulesController = TextEditingController();
  }

  @override
  void dispose() {
    _rulesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showMyDialog();
      },
      child: Container(
        alignment: widget.fieldAlignM,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: selectedborderwidth == "0"
                    ? Colors.transparent
                    : Colors.blueAccent,
                width: widget.borderwidth,
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: selectedshadow == "0"
                        ? Colors.transparent
                        : Colors.grey.withOpacity(0.5),
                    spreadRadius: widget.shadow,
                    blurRadius: 7,
                    offset: Offset(5, 10))
              ]),
          width: widget.fieldsize,
          height: MediaQuery.of(context).size.height * widget.customHeight,
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: widget.txtAlign,
            children: [
              Text(
                disappearvalue == true
                    ? widget.textFieldName
                    : widget.textHidedName,
              ),
              SizedBox(
                height: 12.0,
              ),
              selectedFieldType == "Text"
                  ? Text(
                      widget.text,
                      // textAlign: widget.textAlign,
                      style: TextStyle(
                        fontSize: widget.fontSize,
                        color: selectedfontColor,
                      ),
                    )
                  : selectedFieldType == "Web Link"
                      ? Text(widget.webLink)
                      : Container(
                          child: FbCameraView(
                              custWidth: widget.mediaWidth,
                              custHeight: widget.mediaHeight,
                              mBorderWidth: widget.mediaBorderWidth))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showMyDialog() async {
    TextEditingController textController = new TextEditingController();
    TextEditingController fieldNameController = new TextEditingController();
    TextEditingController customWidthController = new TextEditingController();
    TextEditingController customHeightController = new TextEditingController();
    TextEditingController webLinkController = new TextEditingController();
    TextEditingController fontSizeController = new TextEditingController();
    TextEditingController mediaWidthController = new TextEditingController();
    TextEditingController mediaHeightController = new TextEditingController();
    TextEditingController mediaBorderWidthController =
        new TextEditingController();
    webLinkController.text = widget.webLink;
    fieldNameController.text = widget.textFieldName;
    customWidthController.text = widget.customWidth.toString();
    customHeightController.text = widget.customHeight.toString();
    textController.text = widget.text;
    fontSizeController.text = widget.fontSize.toString();
    mediaWidthController.text = widget.mediaWidth.toString();
    mediaHeightController.text = widget.mediaHeight.toString();
    mediaBorderWidthController.text = widget.mediaBorderWidth.toString();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(0, 24.0, 0, 24.0),
          title: Text('Information Property Window'),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.all(8.0),
            child: StatefulBuilder(
              builder: (context, _setState) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("   Field Name",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: fieldNameController,
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Hide  ",
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
                      SizedBox(height: 20.0),
                      Divider(),
                      Text("   Appearance",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(flex: 1, child: Text("Field Type")),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                                value: selectedFieldType,
                                items:
                                    widget.fieldTypeCheck.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  _setState(() {
                                    selectedFieldType = newValue!;
                                  });
                                }),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(flex: 1, child: Text("Field Size")),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                                value: selectedSize,
                                items: widget.sizeCheck.map((String value) {
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
                            child: selectedSize == "Custom"
                                ? Text("Custom Width")
                                : Text(""),
                          ),
                          Expanded(
                            child: selectedSize == "Custom"
                                ? TextField(
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
                            child: selectedSize == "Custom"
                                ? Text("Custom Height")
                                : Text(""),
                          ),
                          Expanded(
                            child: selectedSize == "Custom"
                                ? TextField(
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
                          Expanded(
                            child: selectedFieldType == "Text"
                                ? Text("Text")
                                : selectedFieldType == "Media"
                                    ? Text("")
                                    : Text("Web Link"),
                          ),
                          Expanded(
                              child: selectedFieldType == "Text"
                                  ? TextField(
                                      controller: textController,
                                    )
                                  : selectedFieldType == "Media"
                                      ? Text("")
                                      : TextField(
                                          controller: webLinkController,
                                        )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(flex: 1, child: Text("Border")),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                                value: selectedborderwidth,
                                items:
                                    widget.setborderwidth.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  _setState(() {
                                    selectedborderwidth = newValue!;
                                  });
                                }),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(flex: 1, child: Text("Shadding")),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                                value: selectedshadow,
                                items: widget.setshadow.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  _setState(() {
                                    selectedshadow = newValue!;
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
                            child: selectedFieldType == "Text"
                                ? Text("Text Alignment")
                                : selectedFieldType == "Media"
                                    ? Text("Media Alignment")
                                    : Text("Web Link Alignment"),
                          ),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                                value: selectedtextalign,
                                items: widget.textalign.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  _setState(() {
                                    selectedtextalign = newValue!;
                                  });
                                }),
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
                        height: 16.0,
                      ),
                      Text("   Formatting",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: selectedFieldType == "Text"
                                ? Text("Font")
                                : selectedFieldType == "Media"
                                    ? Text("Width")
                                    : Text(""),
                          ),
                          Expanded(
                            child: selectedFieldType == "Text"
                                ? TextField(
                                    controller: fontSizeController,
                                    keyboardType: TextInputType.number)
                                : selectedFieldType == "Media"
                                    ? TextField(
                                        controller: mediaWidthController,
                                        keyboardType: TextInputType.number,
                                      )
                                    : Text(""),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: selectedFieldType == "Text"
                                ? Text("Colour")
                                : selectedFieldType == "Media"
                                    ? Text("Height")
                                    : Text(""),
                          ),
                          Expanded(
                            child: selectedFieldType == "Text"
                                ? TextButton(
                                    child: Text(
                                      "Pick Font Color",
                                      style:
                                          TextStyle(color: selectedfontColor),
                                    ),
                                    onPressed: () {
                                      pickColor(context, "Pick Font Color");
                                    })
                                : selectedFieldType == "Media"
                                    ? TextField(
                                        controller: mediaHeightController,
                                        keyboardType: TextInputType.number)
                                    : Text(""),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: selectedFieldType == "Text"
                                ? Text("")
                                : selectedFieldType == "Media"
                                    ? Text("Border")
                                    : Text(""),
                          ),
                          Expanded(
                            child: selectedFieldType == "Text"
                                ? Text("")
                                : selectedFieldType == "Media"
                                    ? TextField(
                                        controller: mediaBorderWidthController,
                                        keyboardType: TextInputType.number,
                                      )
                                    : Text(""),
                          ),
                        ],
                      ),
                      Text("   Rules",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ..._getRules(),
                            ],
                          ),
                        ),
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
                  widget.webLink = webLinkController.text;
                  widget.textFieldName = fieldNameController.text;
                  disappearsetValue = disappearvalue;
                  selectedsetSize = selectedSize;
                  selectedsetFieldType = selectedFieldType;
                  selectedsettextalign = selectedtextalign;
                  selectedsetfieldalign = selectedfieldalign;
                  selectedsetborderwidth = selectedborderwidth;
                  selectedsetshadow = selectedshadow;
                  widget.customWidth = double.parse(customWidthController.text);
                  widget.customHeight =
                      double.parse(customHeightController.text);
                  widget.fontSize = double.parse(fontSizeController.text);
                  widget.mediaHeight = double.parse(mediaHeightController.text);
                  widget.mediaWidth = double.parse(mediaWidthController.text);
                  widget.mediaBorderWidth =
                      double.parse(mediaBorderWidthController.text);
                  selectedsetfontColor = selectedfontColor;
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
                  if (selectedtextalign == "Left") {
                    widget.txtAlign = CrossAxisAlignment.start;
                  } else if (selectedtextalign == "Center") {
                    widget.txtAlign = CrossAxisAlignment.center;
                  } else if (selectedtextalign == "Right") {
                    widget.txtAlign = CrossAxisAlignment.end;
                  }
                  if (selectedfieldalign == "Left") {
                    widget.fieldAlignM = Alignment.centerLeft;
                  } else if (selectedfieldalign == "Center") {
                    widget.fieldAlignM = Alignment.center;
                  } else if (selectedfieldalign == "Right") {
                    widget.fieldAlignM = Alignment.centerRight;
                  }
                  if (selectedborderwidth == "0") {
                    widget.borderwidth = 0.0;
                  } else if (selectedborderwidth == "1") {
                    widget.borderwidth = 1.0;
                  } else if (selectedborderwidth == "2") {
                    widget.borderwidth = 2.0;
                  } else if (selectedborderwidth == "3") {
                    widget.borderwidth = 3.0;
                  }
                  if (selectedshadow == "0") {
                    widget.shadow = 0.0;
                  } else if (selectedshadow == "1") {
                    widget.shadow = 1.0;
                  } else if (selectedshadow == "2") {
                    widget.shadow = 2.0;
                  } else if (selectedshadow == "3") {
                    widget.shadow = 3.0;
                  } else if (selectedshadow == "4") {
                    widget.shadow = 4.0;
                  } else if (selectedshadow == "5") {
                    widget.shadow = 5.0;
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
                      elementName: "Information",
                      element: FbInformation(
                        borderwidth: widget.borderwidth,
                        customHeight: widget.customHeight,
                        customWidth: widget.customWidth,
                        fieldAlignM: widget.fieldAlignM,
                        fieldsize: widget.fieldsize,
                        fontSize: widget.fontSize,
                        mediaBorderWidth: widget.mediaBorderWidth,
                        mediaHeight: widget.mediaHeight,
                        mediaWidth: widget.mediaWidth,
                        shadow: widget.shadow,
                        text: widget.text,
                        textFieldName: widget.textFieldName,
                        textHidedName: widget.textHidedName,
                        txtAlign: widget.txtAlign,
                        webLink: widget.webLink,
                      ),
                      elementId: "Information${AppConstants.elementID}"));
                });
              },
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    if (disappearsetValue != disappearvalue) {
                      disappearvalue = disappearsetValue;
                    }
                    if (selectedsetSize != selectedSize) {
                      selectedSize = selectedsetSize;
                    }
                    if (selectedsetFieldType != selectedFieldType) {
                      selectedFieldType = selectedsetFieldType;
                    }
                    if (selectedsetfontColor != selectedfontColor) {
                      selectedfontColor = selectedsetfontColor;
                    }
                    if (selectedsetborderwidth != selectedborderwidth) {
                      selectedborderwidth = selectedsetborderwidth;
                    }
                    if (selectedsetshadow != selectedshadow) {
                      selectedshadow = selectedsetshadow;
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

  void pickColor(BuildContext context, String title) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Column(
            children: [
              ColorPicker(
                  pickerColor: selectedfontColor,
                  onColorChanged: (color) =>
                      setState(() => selectedfontColor = color)),
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

  List<Widget> _getRules() {
    List<Widget> rulesTextFields = [];
    for (int i = 0; i < rulesList.length; i++) {
      rulesTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(child: RulesTextFields(i)),
            SizedBox(
              width: 16,
            ),
            _addRemoveButton(i == rulesList.length - 1, i),
          ],
        ),
      ));
    }
    return rulesTextFields;
  }

  /// add / remove button
  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          if (add) {
            rulesList.insert(0, null);
          } else
            rulesList.removeAt(index);
        });
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}

class RulesTextFields extends StatefulWidget {
  final int index;
  RulesTextFields(this.index);
  @override
  _RulesTextFieldsState createState() => _RulesTextFieldsState();
}

class _RulesTextFieldsState extends State<RulesTextFields> {
  late TextEditingController _rulesController;

  @override
  void initState() {
    super.initState();
    _rulesController = TextEditingController();
  }

  @override
  void dispose() {
    _rulesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _rulesController.text = _FbInformationState.rulesList[widget.index] ?? '';
    });

    return Column(children: [
      TextFormField(
        controller: _rulesController,
        onChanged: (v) => _FbInformationState.rulesList[widget.index] = v,
        decoration: InputDecoration(hintText: 'Enter Rule'),
        validator: (v) {
          if (v!.trim().isEmpty) return 'Please enter something';
          return null;
        },
      ),
    ]);
  }
}
