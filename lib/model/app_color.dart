import 'package:hive_flutter/adapters.dart';
part 'app_color.g.dart';

@HiveType(typeId: 2)
class AppColor extends HiveObject{
  @HiveField(0)
  int box_color;
  @HiveField(1)
  int text_color;

  AppColor({required this.box_color, required this.text_color});
}

// flutter packages pub run build_runner build