// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inbox_schema.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InboxSchemaAdapter extends TypeAdapter<InboxSchema> {
  @override
  final int typeId = 1;

  @override
  InboxSchema read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InboxSchema(
      title: fields[0] as String,
      content: fields[1] as String,
      status: fields[2] as int,
      date: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, InboxSchema obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InboxSchemaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
