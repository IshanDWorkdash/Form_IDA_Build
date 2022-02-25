import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  List<RadioEntity> items = <RadioEntity>[];
  List<String> nameList = <String>[];
  String itemString = " Sample 1, Sample 2, Sample 3, Sample 4";
  int defaultSelect;
  double fontSize;
  Color fontColor;
  Color backGRColor;
  FontWeight txtBold;
  FontStyle txtItalic;
  TextDecoration txtUnderLine;

  RadioButton({
    this.defaultSelect = 0,
    required this.fontSize,
    required this.itemString,
    required this.nameList,
    required this.items,
    required this.fontColor,
    required this.backGRColor,
    required this.txtBold,
    required this.txtItalic,
    required this.txtUnderLine,
  });

  @override
  _RadioButtonState createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  late RadioEntity defaultItem;

  @override
  void initState() {
    widget.nameList = widget.itemString.split(',');
    widget.items.clear();
    for (int i = 0; i < widget.nameList.length; i++) {
      widget.items.add(RadioEntity(id: i, name: widget.nameList[i]));
    }
    defaultItem = widget.items[widget.defaultSelect];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.items
          .map((e) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 13.0,
              ),
              Container(
                height: 16,
                width: 16,
                child: Transform.scale(
                  scale: 0.9,
                  child: Radio<RadioEntity>(
                    value: e,
                    groupValue: defaultItem,
                    onChanged: (val) {
                      setState(() {
                        defaultItem = val!;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                e.name,
                style: TextStyle(
                    decoration: widget.txtUnderLine,
                    fontWeight: widget.txtBold,
                    fontStyle: widget.txtItalic,
                    fontSize: widget.fontSize,
                    color: widget.fontColor,
                    backgroundColor: widget.backGRColor),
              ),
              SizedBox(width: 8),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
        ],
      ))
          .toList(),
    );
  }
}

class RadioEntity {
  int id;
  String name;

  RadioEntity({
    required this.id,
    required this.name,
  });
}
