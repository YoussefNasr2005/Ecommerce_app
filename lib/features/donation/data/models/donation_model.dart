import 'package:ecommerce_app/features/donation/data/models/donation_clothes_model.dart';
import 'package:hive/hive.dart';
part 'donation_model.g.dart';

@HiveType(typeId: 0)
class DonationModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DonationClothesModel clothes;

  @HiveField(2)
  final String organizationName;

  @HiveField(3)
  final String contactMethod;

  @HiveField(4)
  final String pickupTime;

  @HiveField(5)
  final DonationStatus status;

  @HiveField(6)
  final DateTime createdAt;

  const DonationModel({
    required this.id,
    required this.clothes,
    required this.organizationName,
    required this.contactMethod,
    required this.pickupTime,
    required this.status,
    required this.createdAt,
  });
}

@HiveType(typeId: 4)
enum DonationStatus {
  @HiveField(0)
  pending,

  @HiveField(1)
  accepted,

  @HiveField(2)
  inProgress,

  @HiveField(3)
  completed,

  @HiveField(4)
  rejected,
}
