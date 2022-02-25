import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';

class FbCalculatedValue extends StatefulWidget {
  List<String> fieldTypeCheck = <String>["Number", "Currency", "Percentage"];
  List<String> sizeCheck = <String>["Small", "Medium", "Large"];
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
  String currencyName = " United States Dollar ";

  String selectedSize = "Large";
  String selectedsetSize = "Large";

  int? _groupValue = 0;

  @override
  void initState() {
    super.initState();
    _myController =
    new TextEditingController(text: widget.defaultVal.toString());
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
                ),
                Row(children: [
                  _groupValue == 0
                      ? Text(widget.prefixtxt)
                      : Text(widget.suffixtxt,
                      style: TextStyle(color: Colors.black26)),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.21,
                    child: normalTextField(_currentValue),
                  ),
                  _groupValue == 0
                      ? Text(widget.suffixtxt,
                      style: TextStyle(color: Colors.black26))
                      : Text(widget.prefixtxt),
                  OutlinedButton(
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
                                  MediaQuery.of(context).size.height * 0.75,
                                  child: calc);
                            });
                      }),
                ])
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
    defaultValController.text = widget.defaultVal.toString();
    fieldNameController.text = widget.fieldName;
    maxDigitController.text = widget.maxDigits.toString();
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
                                  flex: 1, child: Text("List of Currency")),
                              Expanded(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(Colors.cyan)),
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
                                      widget.prefixtxt = currencySymbol;
                                      widget.suffixtxt = currencyName;
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
                                child: Text("Default Value"),
                              ),
                              Expanded(
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
                                child: Text("Maximum Digits "),
                              ),
                              Expanded(
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

                      if (selectedSize == "Small") {
                        widget.fieldsize =
                            MediaQuery.of(context).size.width * 0.40;
                      } else if (selectedSize == "Medium") {
                        widget.fieldsize =
                            MediaQuery.of(context).size.width * 0.60;
                      } else if (selectedSize == "Large") {
                        widget.fieldsize = MediaQuery.of(context).size.width;
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
                        if (selectedsetFieldType != selectedFieldType) {
                          selectedFieldType = selectedsetFieldType;
                        }
                        if (selectedsetSize != selectedSize) {
                          selectedSize = selectedsetSize;
                        }
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
      // initialValue: value.toString(),
      decoration: InputDecoration(
        hintText: widget.defaultVal.toString(),
      ),
    );
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

