import 'package:flutter/material.dart';

class FbDatePicker extends StatefulWidget {
  const FbDatePicker({ Key? key }) : super(key: key);

  @override
  _FbDatePickerState createState() => _FbDatePickerState();
}

class _FbDatePickerState extends State<FbDatePicker> {

  DateTime? date;
  DateTime? time;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // margin: EdgeInsets.symmetric(horizontal: 15.0),
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.blueAccent),
      ),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () async{
              date = await showDatePicker(
                  context: context,
                  initialDate: date?? DateTime.now(),
                  firstDate: DateTime(1995),
                  lastDate: DateTime(2500)
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              // onPrimary: Colors.white
            ),
            child: Text("Date"),
          ),
        ],
      ),
    );
  }
}