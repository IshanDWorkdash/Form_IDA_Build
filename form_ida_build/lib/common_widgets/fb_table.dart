import 'package:editable/editable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:form_ida_build/utils/app_constants.dart';

class FbTable extends StatefulWidget {
  List<String> nameList = <String>[];
  String itemString;
  String textFieldName;
  String textHidedName;
  // double? fontSize;
  double? fontSizeFieldName;
  TextInputType? keyboardType;
  Color color;
  List<String> sizeCheck = <String>["Small", "Medium", "Large", "Custom"];
  double? fieldsize;
  List<String> fieldalign = <String>["Left", "Center", "Right"];
  Alignment fieldAlignM;
  num customWidth;
  num customHeight;

  FbTable({
    this.textFieldName = "Table",
    this.textHidedName = "",
    // this.fontSize = 12.0,
    this.fontSizeFieldName = 15.0,
    this.keyboardType = TextInputType.text,
    this.color = Colors.black54,
    this.itemString = "Sample 1, Sample 2, Sample 3",
    this.fieldsize = double.infinity,
    this.fieldAlignM = Alignment.centerLeft,
    this.customWidth = 0.9,
    this.customHeight = 0.4,
  });
  @override
  _FbTableState createState() => _FbTableState();
}

class _FbTableState extends State<FbTable> {
  final _editableKey = GlobalKey<EditableState>();

  bool mandotoryvalue = false;
  bool mandotorysetValue = false;

  bool disappearvalue = true;
  bool disappearsetValue = true;

  String selectedSize = "Large";
  String selectedsetSize = "Large";

  String selectedfieldalign = "Left";
  String selectedsetfieldalign = "Left";

  // List rows = [
  //   {
  //     "Sample 1": '',
  //     "Sample 2": '',
  //   },
  //   {
  //     "Sample 1": '',
  //     "Sample 2": '',
  //   },
  //   {
  //     "Sample 1": '',
  //     "Sample 2": '',
  //   },
  // ];

  void _addNewRow() {
    setState(() {
      _editableKey.currentState!.createRow();
    });
  }

  @override
  void initState() {
    widget.nameList = widget.itemString.split(',');
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
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                width: widget.fieldsize,
                height:
                    MediaQuery.of(context).size.height * widget.customHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          disappearvalue == true
                              ? "     " + widget.textFieldName
                              : widget.textHidedName,
                          style: TextStyle(
                            color: widget.color,
                            fontSize: widget.fontSizeFieldName,
                          ),
                        ),
                        // SizedBox(
                        //   width: 25.0,
                        // ),
                        // Text("ADD ROW =>"),
                        TextButton.icon(
                          onPressed: () => _addNewRow(),
                          icon: Icon(Icons.add),
                          label: Text(''),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 236,
                      child:
                          ListView(scrollDirection: Axis.horizontal, children: [
                        Editable(
                          key: _editableKey,
                          columns: [
                            // for (int i = 1; i <= widget.nColumn; i++)
                            //   {
                            //     "title": 'Sample ' + i.toString(),
                            //     'widthFactor': 0.26,
                            //     'key': 'Sample ' + i.toString(),
                            //   }

                            for (int i = 0; i < widget.nameList.length; i++)
                              {
                                "title": widget.nameList[i],
                                'widthFactor': 0.27,
                                'key': widget.nameList[i],
                              }
                          ],
                          // rows: rows,
                        ),
                      ]),
                    )
                  ],
                ))));
  }

  Future<void> showMyDialog() async {
    TextEditingController fieldNameController = new TextEditingController();
    TextEditingController items = new TextEditingController();
    TextEditingController customWidthController = new TextEditingController();
    TextEditingController customHeightController = new TextEditingController();
    TextEditingController fontSizeFieldNameController =
        new TextEditingController();
    customWidthController.text = widget.customWidth.toString();
    customHeightController.text = widget.customHeight.toString();
    fieldNameController.text = widget.textFieldName;
    fontSizeFieldNameController.text = widget.fontSizeFieldName.toString();
    items.text = widget.itemString;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(0, 24.0, 0, 24.0),
          title: Text('Table Property Window'),
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
                                pickColor(context, "Pick Font Color");
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
                  widget.fontSizeFieldName =
                      double.parse(fontSizeFieldNameController.text);
                  widget.textFieldName = fieldNameController.text;
                  mandotorysetValue = mandotoryvalue;
                  disappearsetValue = disappearvalue;
                  selectedsetSize = selectedSize;
                  selectedsetfieldalign = selectedfieldalign;

                  widget.itemString = items.text;
                  widget.textFieldName = fieldNameController.text;
                  disappearsetValue = disappearvalue;
                  if (widget.itemString == null || widget.itemString == "") {
                    widget.itemString = " Sample 1, Sample 2, Sample 3";
                    widget.nameList = widget.itemString.split(',');
                  } else {
                    widget.nameList = widget.itemString.split(',');
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
                });
              },
            ),
            TextButton(
              child: const Text('Duplicate', style: TextStyle(fontSize: 15.0)),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  AppConstants.elementsList.add(ElementTypes(
                      elementName: "Tables",
                      element: FbTable(
                        color: widget.color,
                        customHeight: widget.customHeight,
                        customWidth: widget.customWidth,
                        fieldAlignM: widget.fieldAlignM,
                        fieldsize: widget.fieldsize,
                        fontSizeFieldName: widget.fontSizeFieldName,
                        itemString: widget.itemString,
                        keyboardType: widget.keyboardType,
                        textFieldName: widget.textFieldName,
                        textHidedName: widget.textHidedName,
                      ),
                      elementId: "Tables${AppConstants.elementID}"));
                });
                // Restart.restartApp();
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
                    if (disappearsetValue != disappearvalue) {
                      disappearvalue = disappearsetValue;
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
              buildPicker(),
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

  Widget buildPicker() {
    return ColorPicker(
        pickerColor: widget.color,
        onColorChanged: (color) => setState(() => widget.color = color));
  }
}
