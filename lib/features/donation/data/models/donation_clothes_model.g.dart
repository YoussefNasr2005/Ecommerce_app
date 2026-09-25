// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donation_clothes_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DonationClothesModelAdapter extends TypeAdapter<DonationClothesModel> {
  @override
  final int typeId = 1;

  @override
  DonationClothesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DonationClothesModel(
      tShirts: fields[0] as int,
      pants: fields[1] as int,
      jackets: fields[2] as int,
      dresses: fields[3] as int,
      shoes: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DonationClothesModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.tShirts)
      ..writeByte(1)
      ..write(obj.pants)
      ..writeByte(2)
      ..write(obj.jackets)
      ..writeByte(3)
      ..write(obj.dresses)
      ..writeByte(4)
      ..write(obj.shoes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DonationClothesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
