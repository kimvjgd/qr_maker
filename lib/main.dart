import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qrcode_maker/constants/auth_input_decor.dart';
import 'package:qrcode_maker/add_qr_screen.dart';
import 'package:flutter/services.dart';
import 'package:qrcode_maker/model/qr.dart';
import 'package:qrcode_maker/qr_storage_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initHive();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
  );
  runApp(MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: QrStorageScreen()));}

  Future<void> _initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(QrAdapter());
  await Hive.openBox<Qr>('qrFormBox');
  }

// class MyApp extends StatefulWidget {
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     // return MaterialApp(
//     //   themeMode: ThemeMode.dark,
//     //   darkTheme: ThemeData.dark(),
//     //   debugShowCheckedModeBanner: false,
//     //   home: QrStorageScreen(),
//     // );
//     return QrStorageScreen();
//   }
// }
