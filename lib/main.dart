import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/services.dart';
import 'package:qrcode_maker/model/app_color.dart';
import 'package:qrcode_maker/model/qr.dart';
import 'package:qrcode_maker/qr_storage_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initHive();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
  );
  runApp(MyApp());
}

  Future<void> _initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(QrAdapter());
  Hive.registerAdapter(AppColorAdapter());
  await Hive.openBox('darkModeBox');
  await Hive.openBox<Qr>('qrFormBox');
  await Hive.openBox<AppColor>('appColorBox');
  }

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {



    return ValueListenableBuilder(
      builder: (context, Box box, widget) {
        final darkMode = box.get('darkMode', defaultValue: true);
        return MaterialApp(
          themeMode: ThemeMode.dark,
          darkTheme: darkMode ? ThemeData.dark(): ThemeData.light(),
          debugShowCheckedModeBanner: false,
          home: QrStorageScreen(),
        );
      }, valueListenable: Hive.box('darkModeBox').listenable(),
    );
    return QrStorageScreen();
  }
}
