import 'package:hive/hive.dart';

part 'address_entity.g.dart';

@HiveType(typeId: 2)
class AddressEntity {
  @HiveField(0)
  String id;
  @HiveField(1)
  String address;
  @HiveField(2)
  String landmark;
  AddressEntity({
    required this.id,
    required this.address,
    required this.landmark,
  });
}
