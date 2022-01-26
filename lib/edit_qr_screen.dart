import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:qrcode_maker/constants/auth_input_decor.dart';
import 'package:qrcode_maker/model/qr.dart';
import 'package:qrcode_maker/qr_screen.dart';
import 'package:qrcode_maker/qr_storage_screen.dart';
import 'package:qrcode_maker/widgets/background.dart';

class EditQrScreen extends StatefulWidget {

  final Qr qr;
  final qr_key;
  EditQrScreen({Key? key, required this.qr, required this.qr_key}) : super(key: key);

  @override
  _EditQrScreenState createState() => _EditQrScreenState();
}

class _EditQrScreenState extends State<EditQrScreen> {
  late Box<Qr> _qrFormBox;

  String userKey = '';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //칸 form의 상태를 저장해준다.
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _urlEditingController = TextEditingController();


  @override
  void initState() {
    _nameEditingController.text = widget.qr.name;
    _urlEditingController.text = widget.qr.url;
    _qrFormBox = Hive.box<Qr>('qrFormBox');


    super.initState();
  }

  @override
  void dispose() {
    _nameEditingController.dispose();
    _urlEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Add QrCode',
          style: TextStyle(fontFamily: 'DonghyunKo'),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: Background(file_name: 'homebackground')),
          Form(
            key: _formKey,
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  '   Name',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                _nameTextField('Write the name of page...'),
                SizedBox(
                  height: 30,
                ),
                Text(
                  '   Url',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                _urlTextField(
                    'Write the url address\nEx) https://www.@@@@@@.com'),
                SizedBox(
                  height: 30,
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _addButton(context),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding _nameTextField(String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 7),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        style: TextStyle(color: Colors.white70),
        cursorColor: Colors.deepOrangeAccent,
        controller: _nameEditingController,
        decoration: textInputDecor(hint),
        validator: (text) {
          if (text!.isNotEmpty && text.length > 1) {
            return null;
          } else {
            return '2자 이상을 입력해주세요.';
          }
        },
      ),
    );
  }

  Padding _urlTextField(String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 7),
      child: TextFormField(
        textInputAction: TextInputAction.done,
        style: TextStyle(color: Colors.white70),
        cursorColor: Colors.deepOrangeAccent,
        controller: _urlEditingController,
        decoration: textInputDecor(hint),
        validator: (text) {
          if (text!.isNotEmpty && text.contains('.')) {
            return null;
          } else {
            return '올바른 url 주소가 아닙니다.';
          }
        },
      ),
    );
  }

  Widget _addButton(BuildContext context) {
    String url = '';

    return Expanded(
      child: TextButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            if (_urlEditingController.text.contains('://')) {
              url = _urlEditingController.text.trim();
            } else {
              url = 'https://${_urlEditingController.text.trim()}';
            }
          }
          widget.qr.name = _nameEditingController.text;
          widget.qr.url = url;
          await _qrFormBox.delete(widget.qr_key);
          await _qrFormBox.add(widget.qr);

          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => QrStorageScreen()));
        },
        child: Text(
          'Add',
          style: TextStyle(color: Colors.white, fontSize: 50),
        ),
      ),
    );
  }
}
