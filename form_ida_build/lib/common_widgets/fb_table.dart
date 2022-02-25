import 'package:editable/editable.dart';
import 'package:flutter/material.dart';

class FbTable extends StatefulWidget {
  @override
  _FbTableState createState() => _FbTableState();
}

class _FbTableState extends State<FbTable> {
  final _editableKey = GlobalKey<EditableState>();

  List rows = [
    {
      "Sample 1": '',
      "Sample 2": '',
    },
    {
      "Sample 1": '',
      "Sample 2": '',
    },
    {
      "Sample 1": '',
      "Sample 2": '',
    },
  ];
  List cols = [
    {
      "title": 'Sample 1',
      'widthFactor': 0.28,
      'key': 'Sample 1',
    },
    {"title": 'Sample 2', 'widthFactor': 0.28, 'key': 'Sample 2'},
  ];

  void _addNewRow() {
    setState(() {
      _editableKey.currentState!.createRow();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showMyDialog();
      },
      child: Container(
          margin: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.blueAccent),
          ),
          padding: EdgeInsets.all(8.0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextButton.icon(
                onPressed: () => _addNewRow(),
                icon: Icon(Icons.add),
                label: Text(
                  '',
                  // style: TextStyle(fontWeight: FontWeight.bold),
                )),
            Editable(
              key: _editableKey,
              columns: cols,
              rows: rows,
            ),
          ])),
    );
  }

  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(0, 24.0, 0, 24.0),
          title: Text('Text Property Window'),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.all(8.0),
            child: StatefulBuilder(
              builder: (context, _setState) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [],
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
                setState(() {});
              },
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {});
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
}
