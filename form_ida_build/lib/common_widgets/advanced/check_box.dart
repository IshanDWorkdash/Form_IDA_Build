import 'package:flutter/material.dart';

class CheckBox extends StatefulWidget {
  List<CheckBoxEntity> items = <CheckBoxEntity>[];
  List<String> nameList = <String>[];
  String itemString = " Sample 1, Sample 2, Sample 3, Sample 4";
  double fontSize;
  Color fontColor;
  Color backGRColor;
  FontWeight txtBold;
  FontStyle txtItalic;
  TextDecoration txtUnderLine;
  String getFont;

  CheckBox({
    required this.fontSize,
    required this.itemString,
    required this.items,
    required this.nameList,
    required this.fontColor,
    required this.backGRColor,
    required this.txtBold,
    required this.txtItalic,
    required this.txtUnderLine,
    required this.getFont,
  });

  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  @override
  void initState() {
    widget.nameList = widget.itemString.split(',');
    widget.items.clear();
    for (int i = 0; i < widget.nameList.length; i++) {
      widget.items.add(CheckBoxEntity(id: i, name: widget.nameList[i]));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.items
          .map((e) => Column(
        children: [
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 10.0),
              SizedBox(
                height: 13,
                width: 13,
                child: Checkbox(
                  activeColor: Colors.blueAccent,
                  value: e.value,
                  onChanged: (bool? val) {
                    setState(() {
                      e.value = val!;
                    });
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  e.name,
                  style: TextStyle(
                    fontFamily: widget.getFont,
                    decoration: widget.txtUnderLine,
                    fontWeight: widget.txtBold,
                    fontStyle: widget.txtItalic,
                    fontSize: widget.fontSize,
                    color: widget.fontColor,
                    backgroundColor: widget.backGRColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
        ],
      ))
          .toList(),
    );
  }
}

class CheckBoxEntity {
  int id;
  String name;
  bool value;

  CheckBoxEntity({
    required this.id,
    required this.name,
    this.value = false,
  });
}
