import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qrcode_maker/add_qr_screen.dart';
import 'package:qrcode_maker/edit_qr_screen.dart';
import 'package:qrcode_maker/model/app_color.dart';
import 'package:qrcode_maker/model/qr.dart';
import 'package:qrcode_maker/qr_screen.dart';
import 'package:qrcode_maker/setting_screen.dart';

class QrStorageScreen extends StatefulWidget {
  const QrStorageScreen({Key? key}) : super(key: key);

  @override
  State<QrStorageScreen> createState() => _QrStorageScreenState();
}

class _QrStorageScreenState extends State<QrStorageScreen> {
  List<Qr> qr_list = [];

  late Box<Qr> _qrFormBox;
  late Box<AppColor> _appColorBox;

  @override
  void initState() {
    _qrFormBox = Hive.box<Qr>('qrFormBox');
    _appColorBox = Hive.box<AppColor>('appColorBox');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('@@build');
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SettingScreen()));
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => AddQrScreen(
                    qr: Qr(name: '', url: ''),
                  )));
        },
      ),
      body: ListView.builder(
        itemBuilder: (ctx, idx) {
          if (idx == 0) {
            return ValueListenableBuilder(
              builder: (context, Box<Qr> qrFormBox, widget) {
                final qrs = qrFormBox.values.toList();
                return ValueListenableBuilder(
                  builder: (context, Box<AppColor> appColorBox, widget) {
                    return Container(
                      child: Column(
                        children: List.generate(qrs.length, (index) {
                          Qr _qr = qrs[index];

                          return InkWell(
                            onTap: () {
                              print(_qr.url);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) =>
                                      QrScreen(name: _qr.name, url: _qr.url)));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                tileColor: Color(_appColorBox.get('appColor',defaultValue: AppColor(box_color: 0xFF80d3f4, text_color: 0xFF80d3f4))!.box_color),
                                // red[300], blue[300], black26, white70
                                // Color(0xFF80d3f4),
                                // Color(0xFFa794fa),
                                // Color(0xFFfb91d1),
                                // Color(0xFFfb8a94),
                                // Color(0xFFfebd9a),
                                // Color(0xFF51e29d),
                                // Color(0xFFFFFFFF),
                                title: Text(
                                  ('${_qr.name}'),
                                  style: TextStyle(fontSize: 20,color: Color(_appColorBox.get('appColor',defaultValue: AppColor(box_color: 0xFF80d3f4, text_color: 0xFF80d3f4))!.text_color)),
                                ),
                                trailing: Container(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      IconButton(
                                          iconSize: 25,
                                          onPressed: () {
                                            Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (_) => EditQrScreen(
                                                        qr: Qr(
                                                            name: _qr.name,
                                                            url: _qr.url),
                                                        qr_key: _qr.key)));
                                          },
                                          icon: Icon(Icons.edit)),
                                      IconButton(
                                          iconSize: 25,
                                          onPressed: () {
                                            qrFormBox.delete(_qr.key);
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  },
                  valueListenable: Hive.box<AppColor>('appColorBox').listenable(),
                );
              },
              valueListenable: Hive.box<Qr>('qrFormBox').listenable(),
            );
          }
          return Container();
        },
        itemCount: 1,
      ),
      // body: Container(),
    );
  }
}
