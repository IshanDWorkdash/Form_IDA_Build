import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:form_ida_build/utils/app_constants.dart';

class FbTextField extends StatefulWidget {
  List<String> sizeCheck = <String>["Small", "Medium", "Large"];
  // int selectedSize;
  List<String> fieldTypeCheck = <String>[
    "Text",
    "Number",
    "Currency",
    "Percentage"
  ];
  TextInputType? keyboardType;
  // TextCapitalization textCapitalization;
  Color? color;
  Color? backgroundColor;
  double? fontSize;
  String hintText;
  double? fieldsize;
  TextEditingController? getcontroller;
  String suffixtxt;
  int? maxDigits;
  String txtCounter;

  String textFieldName;
  String textHidedName;
  Color? colorFieldName;
  double? fontSizeFieldName;

  FbTextField({
    this.hintText = "Hint Text Apply Here",
    this.textFieldName = "TextFiled Name",
    this.textHidedName = "",
    this.color = Colors.black54,
    this.backgroundColor = Colors.white60,
    this.fontSize = 12.0,
    this.colorFieldName = Colors.black,
    this.fontSizeFieldName = 15.0,
    this.fieldsize = double.infinity,
    this.keyboardType = TextInputType.text,
    this.suffixtxt = "",
    this.maxDigits = 100,
    this.txtCounter = "",
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

  String selectedFieldType = "Text";
  String selectedsetFieldType = "Text";

  String currencySymbol = "\$ ";
  String currencyName = "      United States Dollar";

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
        width: widget.fieldsize,
        decoration: BoxDecoration(
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
                color: widget.colorFieldName,
                fontSize: widget.fontSizeFieldName,
              ),
            ),
            mandotoryvalue == false ? normalTextField() : validateTextField(),
          ],
        ),
      ),
    );
  }

  Future<void> showMyDialog() async {
    TextEditingController hintTextController = new TextEditingController();
    TextEditingController fieldNameController = new TextEditingController();
    TextEditingController fontSizeController = new TextEditingController();
    TextEditingController fontSizeFieldNameController =
    new TextEditingController();
    TextEditingController maxDigitController = new TextEditingController();
    hintTextController.text = widget.hintText;
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
                            controller: hintTextController,
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
                    SizedBox(
                      height: 8.0,
                    ),
                    Divider(),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text("Text Filed Name Properties"),
                    SizedBox(
                      height: 5.0,
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
                      height: 16.0,
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
                      height: 16.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(flex: 1, child: Text("List of Currency")),
                        Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              onPressed: () {
                                showCurrencyPicker(
                                    context: context,
                                    showFlag: true,
                                    showCurrencyName: true,
                                    showCurrencyCode: true,
                                    onSelect: (Currency currency) {
                                      currencySymbol = "${currency.symbol} ";
                                      currencyName =
                                      "       ( ${currency.name} )";
                                    });
                              },
                              child: Text("Currency"),
                            )),
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
                              // value: selectedSize == "Small" ? widget.sizeCheck[0] : selectedSize == "Medium" ? widget.sizeCheck[1] : widget.sizeCheck[2],
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
                              pickColor(context, "Pick Font Color", 3);
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
                  widget.fontSize = double.parse(fontSizeController.text);
                  widget.fontSizeFieldName =
                      double.parse(fontSizeFieldNameController.text);
                  widget.textFieldName = fieldNameController.text;
                  widget.maxDigits = int.parse(maxDigitController.text);
                  mandotorysetValue = mandotoryvalue;
                  disappearsetValue = disappearvalue;
                  selectedsetSize = selectedSize;
                  selectedsetFieldType = selectedFieldType;
                  if (selectedSize == "Small") {
                    widget.fieldsize = MediaQuery.of(context).size.width * 0.40;
                  } else if (selectedSize == "Medium") {
                    widget.fieldsize = MediaQuery.of(context).size.width * 0.60;
                  } else if (selectedSize == "Large") {
                    widget.fieldsize = MediaQuery.of(context).size.width;
                  }
                  if (selectedFieldType == "Text") {
                    widget.getcontroller = new TextEditingController();
                    widget.keyboardType = TextInputType.text;
                    widget.hintText = "Hint Text Apply Here";
                    widget.suffixtxt = "";
                  } else if (selectedFieldType == "Number") {
                    widget.getcontroller = new TextEditingController();
                    widget.keyboardType = TextInputType.number;
                    widget.hintText = "0";
                    widget.suffixtxt = "";
                  } else if (selectedFieldType == "Currency") {
                    widget.getcontroller = new MoneyMaskedTextController(
                        leftSymbol: currencySymbol,
                        decimalSeparator: '.',
                        thousandSeparator: ',',
                        rightSymbol: currencyName);
                    widget.keyboardType = TextInputType.number;
                    widget.hintText = "\$ 0.00       United States Dollar";
                    widget.suffixtxt = "";
                  } else if (selectedFieldType == "Percentage") {
                    widget.getcontroller = new MaskedTextController(mask: '00');
                    widget.keyboardType = TextInputType.number;
                    widget.hintText = "00";
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
                        fontSize: widget.fontSize,
                        fontSizeFieldName: widget.fontSizeFieldName,
                        textFieldName: widget.textFieldName,
                        color: widget.color!,
                        colorFieldName: widget.colorFieldName!,
                        backgroundColor: widget.backgroundColor!,
                        maxDigits: widget.maxDigits,
                      ),
                      elementId: "TextField${AppConstants.elementID}"));
                });
              },
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    if (mandotorysetValue != mandotoryvalue) {
                      mandotoryvalue = mandotorysetValue;
                    }
                    if (disappearsetValue != disappearvalue) {
                      disappearvalue = disappearsetValue;
                    }
                    if (selectedsetSize != selectedSize) {
                      selectedSize = selectedsetSize;
                    }
                    if (selectedsetFieldType != selectedFieldType) {
                      selectedFieldType = selectedsetFieldType;
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
    } else if (key == 3) {
      return ColorPicker(
          pickerColor: widget.colorFieldName!,
          onColorChanged: (color) =>
              setState(() => widget.colorFieldName = color));
    } else {
      return ColorPicker(
          pickerColor: widget.backgroundColor!,
          onColorChanged: (color) =>
              setState(() => widget.backgroundColor = color));
    }
  }

  Widget validateTextField() {
    return TextFormField(
      validator: (text) {
        //Enter the validation Part
      },
      decoration: InputDecoration(
        suffixText: widget.suffixtxt,
        hintText: widget.hintText,
        counterText: widget.txtCounter,
      ),
      maxLength: widget.maxDigits,
      style: TextStyle(
        color: widget.color,
        fontSize: widget.fontSize,
        backgroundColor: widget.backgroundColor,
      ),
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
        hintText: widget.hintText,
        suffixText: widget.suffixtxt,
        counterText: widget.txtCounter,
        // suffixIcon: IconButton(
        //   icon: Icon(Icons.clear),
        //   onPressed: txtclearController.clear,)
      ),
      maxLength: widget.maxDigits,
      style: TextStyle(
        color: widget.color,
        fontSize: widget.fontSize,
        backgroundColor: widget.backgroundColor,
      ),
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