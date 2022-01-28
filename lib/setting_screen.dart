import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:hive/hive.dart';
import 'package:qrcode_maker/model/app_color.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

bool isDarkMode = false;
AppColor isAppColor = AppColor(box_color: 0xFF80d3f4, text_color: 0xFF80d3f4);

class _SettingScreenState extends State<SettingScreen> {
  late Box _darkMode;
  late Box<AppColor> _appColorBox;


  @override
  void initState() {
    _darkMode = Hive.box('darkModeBox');
    _appColorBox = Hive.box<AppColor>('appColorBox');
    isDarkMode = _darkMode.get('darkMode', defaultValue: true);
    isAppColor = _appColorBox.get('appColor',defaultValue: AppColor(box_color: 0xFF80d3f4, text_color: 0xFF80d3f4))!;
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
            onChanged: changeAppMode,
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
            onChanged: changeBoxColor,
            selectedItem: boxColor(),
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
            onChanged: changeTextColor,
            selectedItem: textColor(),
          ),
        ],
      ),
    );
  }

  void changeAppMode(string) {
    setState(() {
      if (string == 'Dark') {
        isDarkMode = true;
        _darkMode.put('darkMode', true);
      }else{
        isDarkMode = false;
        _darkMode.put('darkMode', false);
      }
    });
    print;
  }
  void changeBoxColor(string) {
    setState(() {
      if(string == 'Red'){
        isAppColor.box_color = 0xFF80d3f4;
        _appColorBox.put('appColor', AppColor(box_color: 0xFF80d3f4, text_color: isAppColor.text_color));
        // isAppColor.box_color =
      }else if(string=='Blue'){
        _appColorBox.put('appColor', AppColor(box_color: 0xFFa794fa, text_color: isAppColor.text_color));
        isAppColor.box_color = 0xFFa794fa;
      }else if(string=='Green'){
        _appColorBox.put('appColor', AppColor(box_color: 0xFFfb91d1, text_color: isAppColor.text_color));
        isAppColor.box_color = 0xFFfb91d1;
      }else{
        _appColorBox.put('appColor', AppColor(box_color: 0xFFfb8a94, text_color: isAppColor.text_color));
        isAppColor.box_color = 0xFFfb8a94;
      }
    });
    print;
  }
  void changeTextColor(string) {
    setState(() {
      if(string == 'Black'){
        isAppColor.text_color = 0xFF000000;
        _appColorBox.put('appColor', AppColor(box_color: isAppColor.box_color, text_color: 0xFF000000));
        // isAppColor.box_color =
      }else{
        _appColorBox.put('appColor', AppColor(box_color: isAppColor.box_color, text_color: 0xFFFFFFFF));
        isAppColor.text_color = 0xFFFFFFFF;
      }
    });
    print;
  }

  String boxColor(){
    if(isAppColor.box_color == 0xFF80d3f4){
      return 'Red';
    }else if (isAppColor.box_color == 0xFFa794fa){
      return 'Blue';
    }else if (isAppColor.box_color == 0xFFfb91d1){
      return 'Green';
    }else {
      return 'White';
    }
  }
  String textColor(){
    if(isAppColor.text_color == 0xFF000000){
      return 'Black';
    }else {
      return 'White';
    }
  }
}
