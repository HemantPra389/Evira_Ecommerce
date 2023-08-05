// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      type: json['type'] as String,
      title: json['title'] as String,
      price: json['price'] as String,
      url: (json['url'] as List<dynamic>).map((e) => e as String).toList(),
      category: json['category'] as String,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'price': instance.price,
      'url': instance.url,
      'category': instance.category,
    };
