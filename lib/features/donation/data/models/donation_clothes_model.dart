import 'package:hive/hive.dart';
part 'donation_clothes_model.g.dart';

@HiveType(typeId: 1)
class DonationClothesModel {
  @HiveField(0)
  final int tShirts;

  @HiveField(1)
  final int pants;

  @HiveField(2)
  final int jackets;

  @HiveField(3)
  final int dresses;

  @HiveField(4)
  final int shoes;

  DonationClothesModel(
      {required this.tShirts,
      required this.pants,
      required this.jackets,
      required this.dresses,
      required this.shoes});

  String get formattedSummary {
    final List<String> items = [
      if (tShirts > 0) 'T-Shirts x $tShirts',
      if (pants > 0) 'Pants x $pants',
      if (jackets > 0) 'Jackets x $jackets',
      if (dresses > 0) 'Dresses x $dresses',
      if (shoes > 0) 'Shoes x $shoes',
    ];
    return items.isNotEmpty ? items.join('\n') : 'No items selected';
  }
}
