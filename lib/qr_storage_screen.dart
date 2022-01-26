import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qrcode_maker/add_qr_screen.dart';
import 'package:qrcode_maker/edit_qr_screen.dart';
import 'package:qrcode_maker/model/qr.dart';
import 'package:qrcode_maker/qr_screen.dart';

class QrStorageScreen extends StatefulWidget {
  const QrStorageScreen({Key? key}) : super(key: key);

  @override
  State<QrStorageScreen> createState() => _QrStorageScreenState();
}

class _QrStorageScreenState extends State<QrStorageScreen> {
  List<Qr> qr_list = [];

  late Box<Qr> _qrFormBox;

  @override
  void initState() {
    _qrFormBox = Hive.box<Qr>('qrFormBox');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('@@build');
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(),
        preferredSize: Size.fromHeight(0),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddQrScreen(
                    qr: Qr(name: '', url: ''),
                  )));
        },
      ),
      body: ListView.builder(
        itemBuilder: (ctx, idx) {
          if (idx == 0) {
            return Container(
              child: Text(
                'Qr 제목',
                style: TextStyle(fontSize: 50),
              ),
            );
          } else if (idx == 1) {
            // WidgetsBinding.instance!.addPostFrameCallback((_) {
            //   getAllQr();
            //   print('@@실행!!!');
            // });
            return ValueListenableBuilder(
              builder: (context, Box<Qr> qrFormBox, widget) {
                final qrs = qrFormBox.values.toList();
                return Container(
                  child: Column(
                    children: List.generate(qrs.length, (index) {
                      Qr _qr = qrs[index];
                      // print(_qr.key);
                      // Qr qrForm = qrs[idx];

                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) =>
                                  QrScreen(name: _qr.name, url: _qr.url)));
                          // print('@@inkwell');
                          // print("${_qr.name} ${_qr.url} ${_qr.id}");
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            tileColor: Colors.blue,
                            title: Text(
                              _qr.url,
                              style: TextStyle(fontSize: 20),
                            ),
                            trailing: Container(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                      iconSize: 25,
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (_) => EditQrScreen(
                                                      qr: Qr(
                                                          name: _qr.name,
                                                          url: _qr.url),
                                                      qr_key: _qr.key

                                                    )));
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
              valueListenable: Hive.box<Qr>('qrFormBox').listenable(),
            );
          }
          return Container();
        },
        itemCount: 2,
      ),
      // body: Container(),
    );
  }
}
