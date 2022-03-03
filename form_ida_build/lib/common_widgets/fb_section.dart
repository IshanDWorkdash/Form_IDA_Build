import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_font_picker/flutter_font_picker.dart';
import 'package:form_ida_build/common_widgets/advanced/check_box.dart';
import 'package:form_ida_build/common_widgets/advanced/drop_down.dart';
import 'package:form_ida_build/common_widgets/advanced/font_import.dart';
import 'package:form_ida_build/common_widgets/advanced/radio_button.dart';

class FbSection extends StatefulWidget {
  List<String> sizeCheck = <String>["Small", "Medium", "Large", "Custom"];
  List<String> fieldTypeCheck = <String>[
    "Checkbox",
    "Radio Button",
    "Drop Down",
    "Multi Select"
  ];
  // List<String> textalign = <String>["Left", "Center", "Right"];
  List<String> fieldalign = <String>["Left", "Center", "Right"];

  List<String> itemst = <String>[];
  String itemSet = "Sample 1, Sample 2, Sample 3, Sample 4";

  List<CheckBoxEntity> itemsChBox = <CheckBoxEntity>[];
  List<String> nameListChBox = <String>[];
  String itemStringChBox = " Sample 1, Sample 2, Sample 3, Sample 4";

  List<RadioEntity> itemsRB = <RadioEntity>[];
  List<String> nameListRB = <String>[];
  String itemStringRB = " Sample 1, Sample 2, Sample 3, Sample 4";

  // CrossAxisAlignment txtAlign;
  Alignment fieldAlignM;
  String textFieldName;
  String textHidedName;
  double? fieldsize;
  num customWidth;
  num customHeight;
  double fontSize;

  FbSection({
    this.textFieldName = "Filed Name",
    this.textHidedName = "",
    // this.txtAlign = CrossAxisAlignment.start,
    this.fieldAlignM = Alignment.centerLeft,
    this.fieldsize = double.infinity,
    this.customWidth = 0.9,
    this.customHeight = 0.25,
    this.fontSize = 15.0,
  });

  @override
  _FbSectionState createState() => _FbSectionState();
}

class _FbSectionState extends State<FbSection> {
  bool disappearvalue = true;
  bool disappearsetvalue = true;

  String selectedFieldType = "Checkbox";
  String selectedsetFieldType = "Checkbox";

  String selectedSize = "Large";
  String selectedsetSize = "Large";

  String selectedfieldalign = "Left";
  String selectedsetfieldalign = "Left";

  Color selectedtxtColor = Colors.black87;
  Color selectedsettxtColor = Colors.black87;

  Color selectedDDbgColor = Colors.white;
  Color selectedsetDDbgColor = Colors.white;

  Color selectedFbgColor = Colors.white;
  Color selectedsetFbgColor = Colors.white;

  int selectedDDItem = 0;

  late RadioEntity defaultItem;

  FontWeight textBold = FontWeight.normal;
  FontWeight textSetBold = FontWeight.normal;

  FontStyle textItalic = FontStyle.normal;
  FontStyle textSetItalic = FontStyle.normal;

  TextDecoration textUnderLine = TextDecoration.none;
  TextDecoration textSetUnderLine = TextDecoration.none;

  String impFont = "Roboto";
  String impSetFont = "Roboto";

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _rulesController;
  static List rulesList = [null];

  void selectedFontFamily(String fontFamily) {
    setState(() {
      impFont = fontFamily;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showMyDialog();
      },
      child: Container(
        alignment: widget.fieldAlignM,
        decoration: BoxDecoration(
          color: selectedFbgColor,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.blueAccent),
        ),
        width: widget.fieldsize,
        height: MediaQuery.of(context).size.height * widget.customHeight,
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, //widget.txtAlign,
          children: [
            Text(
              disappearvalue == true
                  ? widget.textFieldName
                  : widget.textHidedName,
              style: TextStyle(fontFamily: impSetFont),
            ),
            SizedBox(
              height: 12.0,
            ),
            selectedFieldType == "Checkbox"
                ? CheckBox(
                    itemString: widget.itemStringChBox,
                    items: widget.itemsChBox,
                    nameList: widget.nameListChBox,
                    getFont: impSetFont,
                    fontSize: widget.fontSize,
                    fontColor: selectedtxtColor,
                    backGRColor: selectedDDbgColor,
                    txtBold: textBold,
                    txtItalic: textItalic,
                    txtUnderLine: textUnderLine,
                  )
                : selectedFieldType == "Drop Down"
                    ? DropDown(
                        items: widget.itemst,
                        itemString: widget.itemSet,
                        selectedItem: selectedDDItem,
                        fontSize: widget.fontSize,
                        textColor: selectedtxtColor,
                        backGRColor: selectedDDbgColor,
                        txtBold: textBold,
                        txtItalic: textItalic,
                        txtUnderLine: textUnderLine,
                      )
                    : selectedFieldType == "Radio Button"
                        ? RadioButton(
                            items: widget.itemsRB,
                            itemString: widget.itemStringRB,
                            nameList: widget.nameListRB,
                            fontSize: widget.fontSize,
                            fontColor: selectedtxtColor,
                            backGRColor: selectedDDbgColor,
                            txtBold: textBold,
                            txtItalic: textItalic,
                            txtUnderLine: textUnderLine,
                          )
                        : Text("")
          ],
        ),
      ),
    );
  }

  Future<void> showMyDialog() async {
    TextEditingController fieldNameController = new TextEditingController();
    TextEditingController customWidthController = new TextEditingController();
    TextEditingController customHeightController = new TextEditingController();
    TextEditingController itemController = new TextEditingController();
    TextEditingController itemChBoxController = new TextEditingController();
    TextEditingController itemsRBContraller = new TextEditingController();
    TextEditingController fontSizeContraller = new TextEditingController();
    fontSizeContraller.text = widget.fontSize.toString();
    itemsRBContraller.text = widget.itemStringRB;
    itemChBoxController.text = widget.itemStringChBox;
    itemController.text = widget.itemSet;
    fieldNameController.text = widget.textFieldName;
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
                            flex: 2,
                            child: DropdownButtonFormField<String>(
                                alignment: Alignment.topRight,
                                value: selectedFieldType,
                                items:
                                    widget.fieldTypeCheck.map((String value) {
                                  return DropdownMenuItem<String>(
                                      value: value, child: Text(value));
                                }).toList(),
                                onChanged: (newValue) {
                                  _setState(() {
                                    selectedFieldType = newValue!;
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
                            child: Text("Items List"),
                          ),
                          Expanded(
                            flex: 2,
                            child: selectedFieldType == "Drop Down"
                                ? TextField(controller: itemController)
                                : selectedFieldType == "Checkbox"
                                    ? TextField(controller: itemChBoxController)
                                    : TextField(
                                        controller: itemsRBContraller,
                                      ),
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
                        children: [
                          Expanded(flex: 1, child: Text("Field Alignment")),
                          Expanded(
                            flex: 2,
                            child: DropdownButtonFormField<String>(
                                alignment: Alignment.topRight,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(flex: 1, child: Text("Font")),
                          Expanded(
                              flex: 2,
                              child: FontImport(
                                callback: selectedFontFamily,
                                passfont: impSetFont,
                              ))
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
                              controller: fontSizeContraller,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.0),
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
                            child: Text("Font Color"),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextButton(
                              child: Text(
                                "Pick Font Color",
                                style: TextStyle(
                                  color: selectedtxtColor,
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
                            child: Text("Field background Color"),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextButton(
                              child: Text(
                                "Pick Background Color",
                              ),
                              onPressed: () {
                                pickColor(
                                    context, "Pick Field Background Color", 2);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text("DropDown background Color"),
                          ),
                          Expanded(
                            flex: 2,
                            child: TextButton(
                              child: Text(
                                "Pick Background Color",
                              ),
                              onPressed: () {
                                pickColor(context,
                                    "Pick DropDown Background Color", 3);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.0),
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
                  widget.textFieldName = fieldNameController.text;
                  disappearsetvalue = disappearvalue;
                  selectedsetSize = selectedSize;
                  selectedsetFieldType = selectedFieldType;
                  selectedsetfieldalign = selectedfieldalign;
                  selectedsettxtColor = selectedtxtColor;
                  selectedsetDDbgColor = selectedDDbgColor;
                  selectedsetFbgColor = selectedFbgColor;
                  textSetBold = textBold;
                  textSetItalic = textItalic;
                  textSetUnderLine = textUnderLine;
                  widget.itemSet = itemController.text;
                  widget.customWidth = double.parse(customWidthController.text);
                  widget.customHeight =
                      double.parse(customHeightController.text);
                  widget.fontSize = double.parse(fontSizeContraller.text);

                  if (widget.itemSet == null || widget.itemSet == "") {
                    widget.itemSet =
                        "Sample 1 , Sample 2 , Sample 3 , Sample 4 ";
                    widget.itemst = widget.itemSet.split(',');
                  } else {
                    widget.itemst = widget.itemSet.split(',');
                  }

                  widget.itemStringChBox = itemChBoxController.text;
                  if (widget.itemStringChBox == null ||
                      widget.itemStringChBox == "") {
                    widget.itemStringChBox =
                        " Sample 1, Sample 2, Sample 3, Sample 4";
                    widget.nameListChBox = widget.itemStringChBox.split(',');
                    widget.itemsChBox.clear();
                    for (int i = 0; i < widget.nameListChBox.length; i++) {
                      widget.itemsChBox.add(
                          CheckBoxEntity(id: i, name: widget.nameListChBox[i]));
                    }
                  } else {
                    widget.nameListChBox = widget.itemStringChBox.split(',');
                    widget.itemsChBox.clear();
                    for (int i = 0; i < widget.nameListChBox.length; i++) {
                      widget.itemsChBox.add(
                          CheckBoxEntity(id: i, name: widget.nameListChBox[i]));
                    }
                  }

                  widget.itemStringRB = itemsRBContraller.text;
                  if (widget.itemStringRB == null ||
                      widget.itemStringRB == "") {
                    widget.itemStringRB =
                        " Sample 1, Sample 2, Sample 3, Sample 4";
                    widget.nameListRB = widget.itemStringRB.split(',');
                    widget.itemsRB.clear();
                    for (int i = 0; i < widget.nameListRB.length; i++) {
                      widget.itemsRB
                          .add(RadioEntity(id: i, name: widget.nameListRB[i]));
                    }
                  } else {
                    widget.nameListRB = widget.itemStringRB.split(',');
                    widget.itemsRB.clear();
                    for (int i = 0; i < widget.nameListRB.length; i++) {
                      widget.itemsRB
                          .add(RadioEntity(id: i, name: widget.nameListRB[i]));
                    }
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
                  if (selectedfieldalign == "Left") {
                    widget.fieldAlignM = Alignment.centerLeft;
                  } else if (selectedfieldalign == "Center") {
                    widget.fieldAlignM = Alignment.center;
                  } else if (selectedfieldalign == "Right") {
                    widget.fieldAlignM = Alignment.centerRight;
                  }

                  if (impFont != impSetFont) {
                    impSetFont = impFont;
                  }
                });
              },
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    if (disappearsetvalue != disappearvalue) {
                      disappearvalue = disappearsetvalue;
                    }
                    if (selectedsetSize != selectedSize) {
                      selectedSize = selectedsetSize;
                    }
                    if (selectedsetfieldalign != selectedfieldalign) {
                      selectedfieldalign = selectedsetfieldalign;
                    }
                    if (selectedsetFieldType != selectedFieldType) {
                      selectedFieldType = selectedsetFieldType;
                    }
                    if (selectedsettxtColor != selectedtxtColor) {
                      selectedtxtColor = selectedsettxtColor;
                    }
                    if (selectedsetDDbgColor != selectedDDbgColor) {
                      selectedDDbgColor = selectedsetDDbgColor;
                    }
                    if (selectedsetFbgColor != selectedFbgColor) {
                      selectedFbgColor = selectedsetFbgColor;
                    }
                    if (textSetBold != textBold) {
                      textBold = textSetBold;
                    }
                    if (textSetItalic != textItalic) {
                      textItalic = textSetItalic;
                    }
                    if (textSetUnderLine != textUnderLine) {
                      textUnderLine = textSetUnderLine;
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
          pickerColor: selectedtxtColor,
          onColorChanged: (color) => setState(() => selectedtxtColor = color));
    } else if (key == 2) {
      return ColorPicker(
          pickerColor: selectedFbgColor,
          onColorChanged: (color) => setState(() => selectedFbgColor = color));
    } else {
      return ColorPicker(
          pickerColor: selectedDDbgColor,
          onColorChanged: (color) => setState(() => selectedDDbgColor = color));
    }
  }

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
      _rulesController.text = _FbSectionState.rulesList[widget.index] ?? '';
    });

    return Column(children: [
      TextFormField(
        controller: _rulesController,
        onChanged: (v) => _FbSectionState.rulesList[widget.index] = v,
        decoration: InputDecoration(hintText: 'Enter Rule'),
        validator: (v) {
          if (v!.trim().isEmpty) return 'Please enter something';
          return null;
        },
      ),
    ]);
  }
}
