import 'package:hive_flutter/adapters.dart';
part 'qr.g.dart';

@HiveType(typeId: 1)
class Qr extends HiveObject{
  @HiveField(0)
  String name;
  @HiveField(1)
  String url;

  Qr({required this.name, required this.url});
}

// flutter packages pub run build_runner build