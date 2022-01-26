import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode_maker/qr_storage_screen.dart';

class QrScreen extends StatelessWidget {
  final String name;
  final String url;


  const QrScreen({Key? key,required this.name, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child: Text("저장", style: TextStyle(color: Colors.white),),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>QrStorageScreen()));
            },
          )

        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name,style: TextStyle(fontFamily: 'DonghyunKo', fontSize: 50),),
            SizedBox(height: 50,),
            Container(
              child: QrImage(
                data: url,
                version: QrVersions.auto,
                size: 200.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
