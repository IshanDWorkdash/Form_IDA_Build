import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:form_ida_build/utils/app_constants.dart';

class FbDropDown extends StatefulWidget {
  List<String> items = <String>[];
  String itemString = "Sample 1, Sample 2, Sample 3, Sample 4";
  int selectedItem;
  Color dropDownColor;
  Color bgColor;
  double fontSize;
  Color textColor;
  List<String> sizeCheck = <String>["Small", "Medium", "Large", "Custom"];
  double? fieldsize;
  List<String> fieldalign = <String>["Left", "Center", "Right"];
  List<String> ddalign = <String>["Left", "Center", "Right"];
  Alignment fieldAlignM;
  num customWidth;
  num customHeight;
  String textFieldName;
  String textHidedName;
  CrossAxisAlignment ddAlign;

  FbDropDown({
    this.textFieldName = "Filed Name",
    this.textHidedName = "",
    this.selectedItem = 0,
    this.dropDownColor = Colors.white,
    this.bgColor = Colors.white,
    this.fontSize = 13.0,
    this.textColor = Colors.black87,
    this.itemString = "Sample 1, Sample 2, Sample 3, Sample 4",
    this.fieldsize = double.infinity,
    this.fieldAlignM = Alignment.centerLeft,
    this.customWidth = 0.9,
    this.customHeight = 0.11,
    this.ddAlign = CrossAxisAlignment.start,
  });

  @override
  _FbDropDownState createState() => _FbDropDownState();
}

class _FbDropDownState extends State<FbDropDown> {
  bool disappearvalue = false;
  bool disappearsetValue = false;

  bool mandotoryvalue = false;
  bool mandotorysetValue = false;

  String selectedSize = "Large";
  String selectedsetSize = "Large";

  String selectedfieldalign = "Left";
  String selectedsetfieldalign = "Left";

  String selectedddalign = "Left";
  String selectedsetddalign = "Left";

  @override
  void initState() {
    widget.items = widget.itemString.split(',');
    super.initState();
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
          width: widget.fieldsize,
          height: MediaQuery.of(context).size.height * widget.customHeight,
          decoration: BoxDecoration(
            color: widget.bgColor,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.blueAccent),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(crossAxisAlignment: widget.ddAlign, children: [
            Text(
              disappearvalue == true
                  ? widget.textFieldName
                  : widget.textHidedName,
            ),
            SizedBox(
              height: 12.0,
            ),
            DropdownButtonFormField<String>(
              value: widget.items[widget.selectedItem],
              dropdownColor: widget.dropDownColor,
              items: widget.items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: widget.fontSize,
                      color: widget.textColor,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (_) {},
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> showMyDialog() async {
    TextEditingController fieldNameController = new TextEditingController();
    TextEditingController items = new TextEditingController();
    TextEditingController fontSize = new TextEditingController();
    TextEditingController selectedElement = new TextEditingController();
    TextEditingController customWidthController = new TextEditingController();
    TextEditingController customHeightController = new TextEditingController();
    fieldNameController.text = widget.textFieldName;
    customWidthController.text = widget.customWidth.toString();
    customHeightController.text = widget.customHeight.toString();
    items.text = widget.itemString;
    selectedElement.text = widget.selectedItem.toString();
    fontSize.text = widget.fontSize.toString();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(0, 24.0, 0, 24.0),
            title: Text('DropDown Property Window'),
            content: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.all(8.0),
              child: StatefulBuilder(
                builder: (context, _setState) {
                  return SingleChildScrollView(
                    child: Column(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text("Items List"),
                            ),
                            Expanded(
                              flex: 2,
                              child: TextField(
                                controller: items,
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
                              child: Text("Dropdown Alignment"),
                            ),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                  value: selectedddalign,
                                  items: widget.ddalign.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    _setState(() {
                                      selectedddalign = newValue!;
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
                              child: Text("Selected Element"),
                            ),
                            Expanded(
                              flex: 2,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: selectedElement,
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
                                controller: fontSize,
                              ),
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
                              child: Text("Font Color"),
                            ),
                            Expanded(
                              flex: 2,
                              child: TextButton(
                                child: Text(
                                  "Pick Font Color",
                                  style: TextStyle(
                                    color: widget.textColor,
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
                              child: Text("DropDown Color"),
                            ),
                            Expanded(
                              flex: 2,
                              child: TextButton(
                                child: Text(
                                  "Pick Background Color",
                                ),
                                onPressed: () {
                                  pickColor(
                                      context, "Pick Background Color", 3);
                                },
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
                    widget.itemString = items.text;
                    widget.textFieldName = fieldNameController.text;
                    disappearsetValue = disappearvalue;
                    selectedsetddalign = selectedddalign;
                    if (widget.itemString == null || widget.itemString == "") {
                      widget.itemString =
                          "Sample 1, Sample 2, Sample 3, Sample 4";
                      widget.items = widget.itemString.split(',');
                    } else {
                      widget.items = widget.itemString.split(',');
                    }
                    widget.fontSize = double.parse(fontSize.text);
                    widget.selectedItem = int.parse(selectedElement.text);
                    if (widget.selectedItem < widget.items.length) {
                      ///Ok
                    } else {
                      widget.selectedItem = 0;
                    }
                    mandotorysetValue = mandotoryvalue;
                    selectedsetfieldalign = selectedfieldalign;
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
                    if (selectedddalign == "Left") {
                      widget.ddAlign = CrossAxisAlignment.start;
                    } else if (selectedddalign == "Center") {
                      widget.ddAlign = CrossAxisAlignment.center;
                    } else if (selectedddalign == "Right") {
                      widget.ddAlign = CrossAxisAlignment.end;
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
                          elementName: "Dropdown",
                          element: FbDropDown(
                            selectedItem: widget.selectedItem,
                            dropDownColor: widget.dropDownColor,
                            fontSize: widget.fontSize,
                            textColor: widget.textColor,
                            itemString: widget.itemString,
                            fieldsize: widget.fieldsize,
                            fieldAlignM: widget.fieldAlignM,
                            customHeight: widget.customHeight,
                            customWidth: widget.customWidth,
                            ddAlign: widget.ddAlign,
                            textFieldName: widget.textFieldName,
                            textHidedName: widget.textHidedName,
                            bgColor: widget.bgColor,
                          ),
                          elementId: "Drop Down${AppConstants.elementID}"));
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
                      if (selectedsetddalign != selectedddalign) {
                        selectedddalign = selectedsetddalign;
                      }
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
          pickerColor: widget.textColor,
          onColorChanged: (color) => setState(() => widget.textColor = color));
    } else if (key == 2) {
      return ColorPicker(
          pickerColor: widget.bgColor,
          onColorChanged: (color) => setState(() => widget.bgColor = color));
    } else {
      return ColorPicker(
          pickerColor: widget.dropDownColor,
          onColorChanged: (color) =>
              setState(() => widget.dropDownColor = color));
    }
  }
}
