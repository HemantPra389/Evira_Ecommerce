import 'package:hive/hive.dart';

part 'cart_product_entity.g.dart';

@HiveType(typeId: 0)
class CartProductEntity {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  double price;
  @HiveField(3)
  String imageUrl;
  @HiveField(4)
  String rating;
  @HiveField(5)
  String sold;
  CartProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.sold,
  });
}
