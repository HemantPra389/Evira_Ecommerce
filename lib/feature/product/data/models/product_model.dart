import 'package:evira_shop/feature/product/domain/entities/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends ProductEntity {
  String type;
  String title;
  String price;
  List<String> url;
  String category;
  ProductModel({
    required this.type,
    required this.title,
    required this.price,
    required this.url,
    required this.category
  }) : super(
            type: type,
            title: title,
            price: price,
            url: url,
            category: category);
  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
