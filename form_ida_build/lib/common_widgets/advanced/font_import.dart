import 'package:flutter/material.dart';
import 'package:flutter_font_picker/flutter_font_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class FontImport extends StatefulWidget {
  final Function(String) callback;
  String passfont;

  FontImport({required this.callback, required this.passfont});
  @override
  _FontImportState createState() => _FontImportState();
}

class _FontImportState extends State<FontImport> {
  String _selectedFont = "Roboto";
  TextStyle? _selectedFontTextStyle;
  List<String> _myGoogleFonts = [
    "Abril Fatface",
    "Aclonica",
    "Alegreya Sans",
    "Architects Daughter",
    "Archivo",
    "Archivo Narrow",
    "Bebas Neue",
    "Bitter",
    "Bree Serif",
    "Bungee",
    "Cabin",
    "Cairo",
    "Coda",
    "Comfortaa",
    "Comic Neue",
    // "Cousine",
    // "Croissant One",
    "Faster One",
    // "Forum",
    // "Great Vibes",
    // "Heebo",
    // "Inconsolata",
    // "Josefin Slab",
    // "Lato",
    // "Libre Baskerville",
    // "Lobster",
    // "Lora",
    // "Merriweather",
    // "Montserrat",
    // "Mukta",
    // "Nunito",
    // "Offside",
    // "Open Sans",
    // "Oswald",
    // "Overlock",
    // "Pacifico",
    // "Playfair Display",
    // "Poppins",
    // "Raleway",
    // "Roboto",
    // "Roboto Mono",
    // "Source Sans Pro",
    // "Space Mono",
    // "Spicy Rice",
    // "Squada One",
    // "Sue Ellen Francisco",
    // "Trade Winds",
    // "Ubuntu",
    // "Varela",
    // "Vollkorn",
    // "Work Sans",
    // "Zilla Slab",
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextField(
                    readOnly: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.arrow_drop_down_sharp),
                        hintText: widget.passfont,
                        border: InputBorder.none),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              content: SingleChildScrollView(
                                child: Container(
                                  width: double.maxFinite,
                                  child: FontPicker(
                                      showInDialog: true,
                                      initialFontFamily: 'Ubuntu',
                                      onFontChanged: (font) {
                                        setState(() {
                                          _selectedFont = font.fontFamily;
                                          widget.callback(_selectedFont);
                                          _selectedFontTextStyle =
                                              font.toTextStyle();
                                        });
                                      },
                                      googleFonts: _myGoogleFonts),
                                ),
                              ));
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
