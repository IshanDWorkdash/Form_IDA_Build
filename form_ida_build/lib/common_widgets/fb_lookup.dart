import 'package:flutter/material.dart';

class FbLookup extends StatefulWidget {
  const FbLookup({Key? key}) : super(key: key);

  @override
  _FbLookupState createState() => _FbLookupState();
}

class _FbLookupState extends State<FbLookup> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => showMyDialog(),

      child: Container(
        alignment: Alignment.topLeft,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(0, 24.0, 0, 24.0),
          title: Text('Number Property Window'),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [],
              ),
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
          ],
        );
      },
    );
  }
}
