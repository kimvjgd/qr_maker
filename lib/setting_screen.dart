import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:hive/hive.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

bool isDarkMode = false;

class _SettingScreenState extends State<SettingScreen> {
  late Box _darkMode;

  @override
  void initState() {
    _darkMode = Hive.box('darkModeBox');
    isDarkMode = _darkMode.get('darkMode', defaultValue: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('App Setting'),
      ),
      body: ListView(
        children: [
          Divider(),
          DropdownSearch(
            dropdownSearchDecoration: InputDecoration(
              labelText: "App Mode",
              contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
              border: OutlineInputBorder(),
            ),
            mode: Mode.MENU,
            showSelectedItems: true,
            items: ["Dark", "Light"],
            onChanged: clickedAppMode,
            // onChanged: print,
            selectedItem: isDarkMode==true?'Dark':'Light',
          ),
          Divider(
            height: _size.height / 15,
          ),
          DropdownSearch<String>(
            dropdownSearchDecoration: InputDecoration(
              labelText: "Box Color",
              contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
              border: OutlineInputBorder(),
            ),
            mode: Mode.MENU,
            showSelectedItems: true,
            items: ["Red", "Blue", "Green", "White"],
            onChanged: print,
            selectedItem: "Red",
          ),
          Divider(
            height: _size.height / 15,
          ),
          DropdownSearch(
            dropdownSearchDecoration: InputDecoration(
              labelText: "Text Color",
              contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
              border: OutlineInputBorder(),
            ),
            mode: Mode.MENU,
            showSelectedItems: true,
            items: ["Black", "White"],
            onChanged: print,
            selectedItem: "Red",
          ),
        ],
      ),
    );
  }

  void clickedAppMode(string) {
    setState(() {
      isDarkMode = string=='Dark'?true:false;
      if (string == 'Dark') {
        _darkMode.put('darkMode', true);
      }else{
        _darkMode.put('darkMode', false);
      }
    });
    print;
  }
}
