// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_item_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BoardItemHiveModelAdapter extends TypeAdapter<BoardItemHiveModel> {
  @override
  final int typeId = 1;

  @override
  BoardItemHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BoardItemHiveModel(
      content: fields[1] as String,
      positionX: fields[2] as double,
      positionY: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, BoardItemHiveModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.positionX)
      ..writeByte(3)
      ..write(obj.positionY);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoardItemHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
