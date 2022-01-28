// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_color.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppColorAdapter extends TypeAdapter<AppColor> {
  @override
  final int typeId = 2;

  @override
  AppColor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppColor(
      box_color: fields[0] as int,
      text_color: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AppColor obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.box_color)
      ..writeByte(1)
      ..write(obj.text_color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppColorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
