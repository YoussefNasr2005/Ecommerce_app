// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DonationModelAdapter extends TypeAdapter<DonationModel> {
  @override
  final int typeId = 0;

  @override
  DonationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DonationModel(
      id: fields[0] as String,
      clothes: fields[1] as DonationClothesModel,
      organizationName: fields[2] as String,
      contactMethod: fields[3] as String,
      pickupTime: fields[4] as String,
      status: fields[5] as DonationStatus,
      createdAt: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, DonationModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.clothes)
      ..writeByte(2)
      ..write(obj.organizationName)
      ..writeByte(3)
      ..write(obj.contactMethod)
      ..writeByte(4)
      ..write(obj.pickupTime)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DonationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DonationStatusAdapter extends TypeAdapter<DonationStatus> {
  @override
  final int typeId = 4;

  @override
  DonationStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DonationStatus.pending;
      case 1:
        return DonationStatus.accepted;
      case 2:
        return DonationStatus.inProgress;
      case 3:
        return DonationStatus.completed;
      case 4:
        return DonationStatus.rejected;
      default:
        return DonationStatus.pending;
    }
  }

  @override
  void write(BinaryWriter writer, DonationStatus obj) {
    switch (obj) {
      case DonationStatus.pending:
        writer.writeByte(0);
        break;
      case DonationStatus.accepted:
        writer.writeByte(1);
        break;
      case DonationStatus.inProgress:
        writer.writeByte(2);
        break;
      case DonationStatus.completed:
        writer.writeByte(3);
        break;
      case DonationStatus.rejected:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DonationStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
