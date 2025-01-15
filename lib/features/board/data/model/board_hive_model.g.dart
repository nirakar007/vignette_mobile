// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BoardHiveModelAdapter extends TypeAdapter<BoardHiveModel> {
  @override
  final int typeId = 0;

  @override
  BoardHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BoardHiveModel(
      boardId: fields[0] as String?,
      boardName: fields[1] as String,
      description: fields[2] as String?,
      items: (fields[3] as List).cast<BoardItemHiveModel>(),
      userId: fields[4] as String?,
      createdAt: fields[5] as DateTime,
      updatedAt: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, BoardHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.boardId)
      ..writeByte(1)
      ..write(obj.boardName)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.items)
      ..writeByte(4)
      ..write(obj.userId)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BoardHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
