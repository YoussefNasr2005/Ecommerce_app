// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_and_packup_screen.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactMethodAdapter extends TypeAdapter<ContactMethod> {
  @override
  final int typeId = 2;

  @override
  ContactMethod read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ContactMethod.phoneCall;
      case 1:
        return ContactMethod.whatsApp;
      default:
        return ContactMethod.phoneCall;
    }
  }

  @override
  void write(BinaryWriter writer, ContactMethod obj) {
    switch (obj) {
      case ContactMethod.phoneCall:
        writer.writeByte(0);
        break;
      case ContactMethod.whatsApp:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactMethodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PickupTimeAdapter extends TypeAdapter<PickupTime> {
  @override
  final int typeId = 3;

  @override
  PickupTime read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PickupTime.morning;
      case 1:
        return PickupTime.afternoon;
      case 2:
        return PickupTime.evening;
      default:
        return PickupTime.morning;
    }
  }

  @override
  void write(BinaryWriter writer, PickupTime obj) {
    switch (obj) {
      case PickupTime.morning:
        writer.writeByte(0);
        break;
      case PickupTime.afternoon:
        writer.writeByte(1);
        break;
      case PickupTime.evening:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PickupTimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
