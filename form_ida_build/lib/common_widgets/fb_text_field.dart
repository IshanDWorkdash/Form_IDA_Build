import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:form_ida_build/home_page.dart';
import 'package:form_ida_build/utils/app_constants.dart';

class FbTextField extends StatefulWidget {
  List<String> sizeCheck = <String>["Small", "Medium", "Large", "Custom"];
  double? fieldsize;
  List<String> fieldalign = <String>["Left", "Center", "Right"];
  Alignment fieldAlignM;
  num customWidth;
  num customHeight;
  // int selectedSize;
  List<String> fieldTypeCheck = <String>[
    "Text",
    "Number",
    "Currency",
    "Percentage"
  ];
  TextInputType? keyboardType;
  // TextCapitalization textCapitalization;

  double? fontSize;
  String hintText;
  String hintNumber;
  String hintCurrency;
  String hintPercentage;
  TextEditingController? getcontroller;
  String suffixtxt;
  int? maxDigits;
  String txtCounter;
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

  FbTextField({
    this.hintText = "Hint Text Apply Here",
    this.hintNumber = "0",
    this.hintCurrency = "\$      United States Dollar",
    this.hintPercentage = "00",
    this.textFieldName = "TextFiled Name",
    this.textHidedName = "",
    this.fontSize = 12.0,
    this.fontSizeFieldName = 15.0,
    this.keyboardType = TextInputType.text,
    this.suffixtxt = "",
    this.maxDigits = 100,
    this.txtCounter = "",
    this.fieldsize = double.infinity,
    this.fieldAlignM = Alignment.centerLeft,
    this.customWidth = 0.9,
    this.customHeight = 0.11,
    this.txtColor1 = Colors.black54,
    this.textbgColor1 = Colors.white60,
    this.fieldColor1 = Colors.black,
    this.fieldbgColor1 = Colors.white60,
    this.bgColorAll1 = Colors.white,
    this.txtColor2 = Colors.black,
    this.textbgColor2 = Colors.white,
    this.fieldColor2 = Colors.black,
    this.fieldbgColor2 = Colors.white,
    this.bgColorAll2 = Colors.white,
  });

  @override
  _FbTextFieldState createState() => _FbTextFieldState();
}

class _FbTextFieldState extends State<FbTextField> {
  bool mandotoryvalue = false;
  bool mandotorysetValue = false;

  bool disappearvalue = true;
  bool disappearsetValue = true;

  String selectedSize = "Large";
  String selectedsetSize = "Large";

  String selectedfieldalign = "Left";
  String selectedsetfieldalign = "Left";

  String selectedFieldType = "Text";
  String selectedsetFieldType = "Text";

  String currencySymbol = "\$ ";
  String currencyName = "      United States Dollar";

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

  // var getcontroller = new TextEditingController();

  // TextEditingController textController = new TextEditingController();

  // var percentcontroller = new MaskedTextController(mask: '00');
  // var currencycontroller = new MoneyMaskedTextController(leftSymbol: 'R\$ ',decimalSeparator: '.', thousandSeparator: ',');

  var txtclearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // var controller = mandotoryvalue== true? new MoneyMaskedTextController(leftSymbol: 'R\$ ',decimalSeparator: '.', thousandSeparator: ','): new TextEditingController() ;
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
          padding: EdgeInsets.symmetric(horizontal: 12.0),
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
                    color: widget.fieldColor2,
                    backgroundColor: widget.fieldbgColor2,
                    fontSize: widget.fontSizeFieldName,
                    fontWeight: fieldBold,
                    fontStyle: fieldItalic,
                    decoration: fieldUnderLine),
              ),
              mandotoryvalue == false ? normalTextField() : validateTextField(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showMyDialog() async {
    TextEditingController hintTextController = new TextEditingController();
    TextEditingController hintNumberController = new TextEditingController();
    TextEditingController hintCurrencyController = new TextEditingController();
    TextEditingController hintPercentageController =
        new TextEditingController();
    TextEditingController fieldNameController = new TextEditingController();
    TextEditingController fontSizeController = new TextEditingController();
    TextEditingController fontSizeFieldNameController =
        new TextEditingController();
    TextEditingController maxDigitController = new TextEditingController();
    TextEditingController customWidthController = new TextEditingController();
    TextEditingController customHeightController = new TextEditingController();
    customWidthController.text = widget.customWidth.toString();
    customHeightController.text = widget.customHeight.toString();
    hintTextController.text = widget.hintText;
    hintNumberController.text = widget.hintNumber;
    hintCurrencyController.text = widget.hintCurrency;
    hintPercentageController.text = widget.hintPercentage;
    fieldNameController.text = widget.textFieldName;
    fontSizeController.text = widget.fontSize.toString();
    fontSizeFieldNameController.text = widget.fontSizeFieldName.toString();
    maxDigitController.text = widget.maxDigits.toString();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(0, 24.0, 0, 24.0),
          title: Text('TextField Property Window'),
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
                          child: Text("Default Value"),
                        ),
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: (selectedFieldType == "Text")
                                ? hintTextController
                                : (selectedFieldType == "Number")
                                    ? hintNumberController
                                    : (selectedFieldType == "Currency")
                                        ? hintCurrencyController
                                        : hintPercentageController,
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
                              if (value.length > 1000000000000000000) {
                                return "Can't Assign";
                              }
                              return null;
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
                    SizedBox(
                      height: 1.0,
                    ),
                    Divider(),
                    SizedBox(
                      height: 25.0,
                    ),
                    Text(
                      "Text Filed Name Properties",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(
                      height: 16.0,
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
                        Expanded(flex: 1, child: Text("Field Type")),
                        Expanded(
                          flex: 2,
                          child: DropdownButtonFormField<String>(
                              value: selectedFieldType,
                              items: widget.fieldTypeCheck.map((String value) {
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
                      height: selectedFieldType == "Currency" ? 16.0 : 0.0,
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
                                  },
                                  child: Text("Currency"),
                                )
                              : Text(""),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: selectedFieldType == "Currency" ? 16.0 : 0.0,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text("Field Name Font Color"),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text("Field Name Background Color"),
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
                          child: Text("Background Color"),
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
            }),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ADD', style: TextStyle(fontSize: 15.0)),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  widget.hintText = hintTextController.text;
                  widget.hintNumber = hintNumberController.text;
                  widget.hintCurrency = hintCurrencyController.text;
                  widget.hintPercentage = hintPercentageController.text;
                  widget.fontSize = double.parse(fontSizeController.text);
                  widget.fontSizeFieldName =
                      double.parse(fontSizeFieldNameController.text);
                  widget.textFieldName = fieldNameController.text;
                  widget.maxDigits = int.parse(maxDigitController.text);
                  mandotorysetValue = mandotoryvalue;
                  disappearsetValue = disappearvalue;
                  selectedsetSize = selectedSize;
                  selectedsetFieldType = selectedFieldType;
                  selectedsetfieldalign = selectedfieldalign;

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

                  widget.customWidth = double.parse(customWidthController.text);
                  widget.customHeight =
                      double.parse(customHeightController.text);

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
                  if (selectedFieldType == "Text") {
                    widget.getcontroller = new TextEditingController();
                    widget.keyboardType = TextInputType.text;
                    widget.suffixtxt = "";
                  } else if (selectedFieldType == "Number") {
                    widget.getcontroller = new TextEditingController();
                    widget.keyboardType = TextInputType.number;
                    widget.suffixtxt = "";
                  } else if (selectedFieldType == "Currency") {
                    widget.getcontroller = new MoneyMaskedTextController(
                        leftSymbol: currencySymbol,
                        decimalSeparator: '.',
                        thousandSeparator: ',',
                        rightSymbol: currencyName);
                    widget.keyboardType = TextInputType.number;
                    widget.suffixtxt = "";
                  } else if (selectedFieldType == "Percentage") {
                    widget.getcontroller = new MaskedTextController(mask: '00');
                    widget.keyboardType = TextInputType.number;
                    widget.suffixtxt = " %";
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
                      elementName: "Text Field",
                      element: FbTextField(
                        hintText: widget.hintText,
                        hintNumber: widget.hintNumber,
                        hintCurrency: widget.hintCurrency,
                        hintPercentage: widget.hintPercentage,
                        fontSize: widget.fontSize,
                        fontSizeFieldName: widget.fontSizeFieldName,
                        textFieldName: widget.textFieldName,
                        txtColor1: widget.txtColor1!,
                        fieldColor1: widget.fieldColor1!,
                        textbgColor1: widget.textbgColor1!,
                        maxDigits: widget.maxDigits,
                        fieldsize: widget.fieldsize,
                        fieldAlignM: widget.fieldAlignM,
                        customHeight: widget.customHeight,
                        customWidth: widget.customWidth,
                        keyboardType: widget.keyboardType,
                        suffixtxt: widget.suffixtxt,
                        textHidedName: widget.textHidedName,
                        txtColor2: widget.txtColor2,
                        textbgColor2: widget.textbgColor2,
                        fieldbgColor2: widget.fieldbgColor2,
                        fieldbgColor1: widget.fieldbgColor1,
                        fieldColor2: widget.fieldColor2,
                        txtCounter: widget.txtCounter,
                        bgColorAll1: widget.bgColorAll1,
                        bgColorAll2: widget.bgColorAll2,
                      ),
                      elementId: "TextField${AppConstants.elementID}"));
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
                    if (disappearsetValue != disappearvalue) {
                      disappearvalue = disappearsetValue;
                    }
                    if (selectedsetFieldType != selectedFieldType) {
                      selectedFieldType = selectedsetFieldType;
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

  Widget validateTextField() {
    return TextFormField(
      validator: (text) {
        //Enter the validation Part
      },
      decoration: InputDecoration(
        suffixText: widget.suffixtxt,
        hintText: (selectedFieldType == "Text")
            ? widget.hintText
            : (selectedFieldType == "Number")
                ? widget.hintNumber
                : (selectedFieldType == "Currency")
                    ? widget.hintCurrency
                    : widget.hintPercentage,
        counterText: widget.txtCounter,
      ),
      maxLength: widget.maxDigits,
      style: TextStyle(
          fontSize: widget.fontSize,
          color: widget.txtColor2,
          backgroundColor: widget.textbgColor2,
          fontWeight: textBold,
          fontStyle: textItalic,
          decoration: textUnderLine),
      keyboardType: widget.keyboardType,
      controller: widget.getcontroller,
    );
  }

  Widget normalTextField() {
    return TextField(
      // inputFormatters: [
      //   // WhitelistingTextInputFormatter.digitsOnly,
      //   CustomRangeTextInputFormatter(),
      // ],
      // readOnly: true,
      decoration: InputDecoration(
        hintText: (selectedFieldType == "Text")
            ? widget.hintText
            : (selectedFieldType == "Number")
                ? widget.hintNumber
                : (selectedFieldType == "Currency")
                    ? widget.hintCurrency
                    : widget.hintPercentage,
        suffixText: widget.suffixtxt,
        counterText: widget.txtCounter,
        // suffixIcon: IconButton(
        //   icon: Icon(Icons.clear),
        //   onPressed: txtclearController.clear,)
      ),
      maxLength: widget.maxDigits,
      style: TextStyle(
          fontSize: widget.fontSize,
          color: widget.txtColor2,
          backgroundColor: widget.textbgColor2,
          fontWeight: textBold,
          fontStyle: textItalic,
          decoration: textUnderLine),
      // controller: txtclearController,
      controller: widget.getcontroller,
      keyboardType: widget.keyboardType,
    );
  }
}

// class CustomRangeTextInputFormatter extends TextInputFormatter {

//   @override
//   TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
//     if(newValue.text == '')
//       return TextEditingValue();

//     else if(int.parse(newValue.text) < 1)
//       return TextEditingValue().copyWith(text: '1' );

//     return int.parse(newValue.text) > 20 ? TextEditingValue().copyWith(text: '20') : newValue;
//   }
// }
