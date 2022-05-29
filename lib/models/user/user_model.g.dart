// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 30;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel()
      ..balance = fields[0] as int?
      ..availableSkins = (fields[1] as List?)?.cast<String>()
      ..activeSkin = fields[2] as String?
      ..availableBg = (fields[3] as List).cast<String>()
      ..activeBg = fields[4] as String?;
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.balance)
      ..writeByte(1)
      ..write(obj.availableSkins)
      ..writeByte(2)
      ..write(obj.activeSkin)
      ..writeByte(3)
      ..write(obj.availableBg)
      ..writeByte(4)
      ..write(obj.activeBg);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
