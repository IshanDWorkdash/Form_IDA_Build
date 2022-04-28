import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:form_ida_build/utils/app_constants.dart';

class FbCalculatedValue extends StatefulWidget {
  List<String> fieldTypeCheck = <String>["Number", "Currency", "Percentage"];
  List<String> sizeCheck = <String>["Small", "Medium", "Large", "Custom"];
  String fieldName;
  String hideName;
  String suffixtxt;
  String prefixtxt;
  double? fieldsize;
  int? maxDigits;
  // String txtCounter;
  double defaultVal;
  String min;
  String max;
  num customWidth;
  num customHeight;
  double fontSize;
  double? fontSizeFieldName;

  FbCalculatedValue({
    this.fieldName = "Calculated Value",
    this.hideName = "",
    this.suffixtxt = "",
    this.prefixtxt = "",
    this.fieldsize = double.infinity,
    this.maxDigits = 100,
    // this.txtCounter = "",
    this.defaultVal = 0,
    this.min = "0.0",
    this.max = "1000000000.0",
    this.customWidth = 0.9,
    this.customHeight = 0.11,
    this.fontSize = 13.0,
    this.fontSizeFieldName = 15.0,
  });

  @override
  _FbCalculatedValueState createState() => _FbCalculatedValueState();
}

class _FbCalculatedValueState extends State<FbCalculatedValue> {
  late TextEditingController _myController;

  double _currentValue = 0;

  bool disappearvalue = true;
  bool disappearsetvalue = true;

  String selectedFieldType = "Number";
  String selectedsetFieldType = "Number";

  String currencySymbol = " \$ ";
  String setcurrencySymbol = " \$ ";

  String currencyName = " United States Dollar ";
  String setcurrencyName = " United States Dollar ";

  String selectedSize = "Large";
  String selectedsetSize = "Large";

  bool suffixShow = false;
  bool suffixSetShow = false;

  bool mandotoryvalue = false;
  bool mandotorysetValue = false;

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

  int? _groupValue = 0;
  int? _groupSetValue = 0;

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _rulesController;
  static List rulesList = [null];

  @override
  void initState() {
    super.initState();
    _rulesController = TextEditingController();
    _myController =
        new TextEditingController(text: widget.defaultVal.toString());
  }

  @override
  void dispose() {
    _rulesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var calc = SimpleCalculator(
      value: _currentValue,
      hideExpression: false,
      hideSurroundingBorder: true,
      onChanged: (key, value, expression) {
        setState(() {
          _currentValue = value ?? widget.defaultVal;
          _currentValue == 0
              ? _myController.text = widget.defaultVal.toString()
              : _myController.text = _currentValue.toString();
        });
        print("$key\t$value\t$expression");
      },
      onTappedDisplay: (value, details) {
        print("$value\t${details.globalPosition}");
      },
      theme: const CalculatorThemeData(
        borderColor: Colors.black12,
        borderWidth: 2,
        displayColor: Colors.black,
        displayStyle: const TextStyle(fontSize: 80, color: Colors.yellow),
        expressionColor: Colors.blue,
        expressionStyle: const TextStyle(fontSize: 20, color: Colors.white),
        operatorColor: Colors.white70,
        operatorStyle: const TextStyle(fontSize: 30, color: Colors.black),
        commandColor: Colors.white70,
        commandStyle: const TextStyle(fontSize: 30, color: Colors.black),
        numColor: Colors.white70,
        numStyle: const TextStyle(fontSize: 50, color: Colors.black),
      ),
    );

    return GestureDetector(
      onLongPress: () {
        showMyDialog();
      },
      child: StatefulBuilder(builder: (context, _setState) {
        return SingleChildScrollView(
          child: Container(
            width: widget.fieldsize,
            height: MediaQuery.of(context).size.height * widget.customHeight,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.blueAccent)),
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  disappearvalue == true ? widget.fieldName : widget.hideName,
                  style: TextStyle(
                      fontSize: widget.fontSizeFieldName,
                      fontWeight: fieldBold,
                      fontStyle: fieldItalic,
                      decoration: fieldUnderLine),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      suffixShow == true
                          ? _groupValue == 0
                              ? Text(widget.prefixtxt)
                              : Text(widget.suffixtxt,
                                  style: TextStyle(color: Colors.black26))
                          : _groupValue == 0
                              ? Text(widget.prefixtxt)
                              : Text(""),
                      Container(
                        width: selectedSize == "Small"
                            ? suffixShow == true
                                ? MediaQuery.of(context).size.width * 0.1303
                                : MediaQuery.of(context).size.width * 0.1388
                            : selectedSize == "Medium"
                                ? suffixShow == true
                                    ? MediaQuery.of(context).size.width * 0.1
                                    : MediaQuery.of(context).size.width * 0.4
                                : suffixShow == true
                                    ? MediaQuery.of(context).size.width * 0.17
                                    : MediaQuery.of(context).size.width * 0.6,
                        child: normalTextField(_currentValue == 0
                            ? widget.defaultVal
                            : _currentValue),
                      ),
                      suffixShow == true
                          ? _groupValue == 0
                              ? Text(widget.suffixtxt,
                                  style: TextStyle(color: Colors.black26))
                              : Text(widget.prefixtxt)
                          : _groupValue == 0
                              ? Text("")
                              : Text(widget.prefixtxt),
                    ]),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.1473,
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  // width: 5.0,
                                  color: Colors.transparent)),
                          child: Row(
                            children: [
                              // Text(_currentValue.toString() < widget.maxDigits.toString()?? "0"),
                              Text("Cal"),
                            ],
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.75,
                                      child: calc);
                                });
                          }),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Future<void> showMyDialog() async {
    TextEditingController fieldNameController = new TextEditingController();
    TextEditingController maxDigitController = new TextEditingController();
    TextEditingController defaultValController = new TextEditingController();
    TextEditingController customWidthController = new TextEditingController();
    TextEditingController customHeightController = new TextEditingController();
    TextEditingController fontSize = new TextEditingController();
    TextEditingController fontSizeController = new TextEditingController();
    TextEditingController fontSizeFieldNameController =
        new TextEditingController();

    fontSize.text = widget.fontSize.toString();
    defaultValController.text = widget.defaultVal.toString();
    fieldNameController.text = widget.fieldName;
    customWidthController.text = widget.customWidth.toString();
    customHeightController.text = widget.customHeight.toString();
    maxDigitController.text = widget.maxDigits.toString();
    fontSizeController.text = widget.fontSize.toString();
    fontSizeFieldNameController.text = widget.fontSizeFieldName.toString();
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.fromLTRB(0, 24.0, 0, 24.0),
              title: Text(
                'Property window',
                textAlign: TextAlign.center,
              ),
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
                                    value: selectedFieldType,
                                    items: widget.fieldTypeCheck
                                        .map((String value) {
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
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: selectedFieldType == "Currency"
                                      ? Text("List of Currency")
                                      : Text("")),
                              Expanded(
                                flex: 2,
                                child: selectedFieldType == "Currency"
                                    ? ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.cyan)),
                                        onPressed: () {
                                          showCurrencyPicker(
                                              context: context,
                                              showFlag: true,
                                              showCurrencyName: true,
                                              showCurrencyCode: true,
                                              onSelect: (Currency currency) {
                                                currencySymbol =
                                                    "${currency.symbol} ";
                                                currencyName =
                                                    "       ( ${currency.name} )";
                                              });
                                          widget.prefixtxt = currencySymbol;
                                          widget.suffixtxt = currencyName;
                                        },
                                        child: Text("Currency"),
                                      )
                                    : Text(""),
                              )
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
                                flex: 2,
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
                                        color: Colors.grey,
                                        shape: CircleBorder())
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
                                        color: Colors.grey,
                                        shape: CircleBorder())
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
                                      if (fieldUnderLine ==
                                          TextDecoration.none) {
                                        fieldUnderLine =
                                            TextDecoration.underline;
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
                                        color: Colors.grey,
                                        shape: CircleBorder())
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
                                        color: Colors.grey,
                                        shape: CircleBorder())
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
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text("Default Value"),
                              ),
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  controller: defaultValController,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text("Maximum Digits "),
                              ),
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: maxDigitController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Can't be empty";
                                    }
                                    if (value.length > 1000000000) {
                                      return "Can't Assign";
                                    }
                                    return null;
                                  },
                                ),
                              ),
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
                                child: Text("Sufficx Symbol"),
                              ),
                              Expanded(
                                child: Transform.scale(
                                  scale: 0.7,
                                  child: StatefulBuilder(
                                    builder: (context, _setState) {
                                      return CupertinoSwitch(
                                          thumbColor: Colors.amber,
                                          activeColor: Colors.blueGrey,
                                          value: suffixShow,
                                          onChanged: (value) {
                                            _setState(() {
                                              this.suffixShow = value;
                                            });
                                          });
                                    },
                                  ),
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
                                child: Text("Symbol "),
                              ),
                              Expanded(
                                  child: Column(
                                children: [
                                  RadioListTile(
                                    title: Text("Left"),
                                    value: 0,
                                    groupValue: _groupValue,
                                    onChanged: (int? newValue) =>
                                        _setState(() => _groupValue = newValue),
                                  ),
                                  RadioListTile(
                                    title: Text("Right"),
                                    value: 1,
                                    groupValue: _groupValue,
                                    onChanged: (int? newValue) =>
                                        _setState(() => _groupValue = newValue),
                                  )
                                ],
                              )),
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
                      widget.fieldName = fieldNameController.text;
                      disappearsetvalue = disappearvalue;
                      selectedsetFieldType = selectedFieldType;
                      selectedsetSize = selectedSize;
                      widget.defaultVal =
                          double.parse(defaultValController.text);
                      widget.maxDigits = int.parse(maxDigitController.text);
                      suffixSetShow = suffixShow;
                      widget.fontSizeFieldName =
                          double.parse(fontSizeFieldNameController.text);
                      widget.fontSize = double.parse(fontSize.text);
                      mandotorysetValue = mandotoryvalue;
                      setcurrencyName = currencyName;
                      setcurrencySymbol = currencySymbol;
                      _groupSetValue = _groupValue;

                      if (selectedFieldType == "Number") {
                        widget.prefixtxt = "";
                        widget.suffixtxt = "";
                      } else if (selectedFieldType == "Currency") {
                        widget.prefixtxt = currencySymbol;
                        widget.suffixtxt = " $currencyName";
                      } else if (selectedFieldType == "Percentage") {
                        widget.prefixtxt = "";
                        widget.suffixtxt = " % ";
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
                            MediaQuery.of(context).size.width * 0.70;
                      } else if (selectedSize == "Large") {
                        widget.fieldsize = MediaQuery.of(context).size.width;
                      } else if (selectedSize == "Custom") {
                        widget.fieldsize = MediaQuery.of(context).size.width *
                            widget.customWidth;
                      }

                      textSetBold = textBold;
                      textSetItalic = textItalic;
                      textSetUnderLine = textUnderLine;

                      fieldSetBold = fieldBold;
                      fieldSetItalic = fieldItalic;
                      fieldSetUnderLine = fieldUnderLine;
                    });
                  },
                ),
                TextButton(
                    child: const Text('Duplicate',
                        style: TextStyle(fontSize: 15.0)),
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        // _HomePage
                        AppConstants.elementsList.add(ElementTypes(
                            elementName: "Calculated Value",
                            element: FbCalculatedValue(
                              customHeight: widget.customHeight,
                              customWidth: widget.customWidth,
                              defaultVal: widget.defaultVal,
                              fieldName: widget.fieldName,
                              fieldsize: widget.fieldsize,
                              fontSize: widget.fontSize,
                              fontSizeFieldName: widget.fontSizeFieldName,
                              hideName: widget.hideName,
                              max: widget.max,
                              maxDigits: widget.maxDigits,
                              min: widget.min,
                              prefixtxt: widget.prefixtxt,
                              suffixtxt: widget.suffixtxt,
                            ),
                            elementId:
                                "CalculatedValue${AppConstants.elementID}"));
                      });
                    }),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        if (disappearsetvalue != disappearvalue) {
                          disappearvalue = disappearsetvalue;
                        }
                        if (selectedsetFieldType != selectedFieldType) {
                          selectedFieldType = selectedsetFieldType;
                        }
                        if (selectedsetSize != selectedSize) {
                          selectedSize = selectedsetSize;
                        }
                        if (suffixSetShow != suffixShow) {
                          suffixShow = suffixSetShow;
                        }
                        if (mandotorysetValue != mandotoryvalue) {
                          mandotoryvalue = mandotorysetValue;
                        }
                        if (setcurrencyName != currencyName) {
                          currencyName = setcurrencyName;
                        }
                        if (setcurrencySymbol != currencySymbol) {
                          currencySymbol = setcurrencySymbol;
                        }
                        if (_groupSetValue != _groupValue) {
                          _groupValue = _groupSetValue;
                        }

                        if (selectedsetFieldType == "Number") {
                          widget.prefixtxt = "";
                          widget.suffixtxt = "";
                        } else if (selectedsetFieldType == "Currency") {
                          widget.prefixtxt = setcurrencySymbol;
                          widget.suffixtxt = " $setcurrencyName";
                        } else if (selectedsetFieldType == "Percentage") {
                          widget.prefixtxt = "";
                          widget.suffixtxt = " % ";
                        }

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
        });
  }

  Widget normalTextField(double value) {
    return TextFormField(
      // inputFormatters: [
      //   // WhitelistingTextInputFormatter.digitsOnly,
      //   CustomRangeTextInputFormatter(),
      // ],
      readOnly: true,
      controller: _myController,
      decoration: InputDecoration(
        hintText: widget.defaultVal.toString(),
      ),
      style: TextStyle(
          fontSize: widget.fontSize,
          fontWeight: textBold,
          fontStyle: textItalic,
          decoration: textUnderLine),
    );
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
      _rulesController.text =
          _FbCalculatedValueState.rulesList[widget.index] ?? '';
    });

    return Column(children: [
      TextFormField(
        controller: _rulesController,
        onChanged: (v) => _FbCalculatedValueState.rulesList[widget.index] = v,
        decoration: InputDecoration(hintText: 'Enter Rule'),
        validator: (v) {
          if (v!.trim().isEmpty) return 'Please enter something';
          return null;
        },
      ),
    ]);
  }
}


// class CustomRangeTextInputFormatter extends TextInputFormatter {

//   @override
//   TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
//     if(newValue.text == '')
//       return TextEditingValue();

//     else if(double.parse(newValue.text) < 1)
//       return TextEditingValue().copyWith(text: '1' );

//     return double.parse(newValue.text) > 20 ? TextEditingValue().copyWith(text: '20') : newValue;
//   }
// }

