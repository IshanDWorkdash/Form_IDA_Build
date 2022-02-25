import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  List<String> items = <String>[];
  String itemString = "Sample 1, Sample 2, Sample 3, Sample 4";
  int selectedItem;
  double fontSize;
  Color textColor;
  Color backGRColor;
  FontWeight txtBold;
  FontStyle txtItalic;
  TextDecoration txtUnderLine;

  DropDown({
    required this.selectedItem,
    required this.fontSize,
    required this.itemString,
    required this.items,
    required this.textColor,
    required this.backGRColor,
    required this.txtBold,
    required this.txtItalic,
    required this.txtUnderLine,
  });

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  void initState() {
    widget.items = widget.itemString.split(',');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: widget.items[widget.selectedItem],
      dropdownColor: widget.backGRColor,
      items: widget.items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(
              decoration: widget.txtUnderLine,
              fontWeight: widget.txtBold,
              fontStyle: widget.txtItalic,
              fontSize: widget.fontSize,
              color: widget.textColor,
            ),
          ),
        );
      }).toList(),
      onChanged: (_) {},
    );
  }
}
