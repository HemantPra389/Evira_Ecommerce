// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carousel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarouselModel _$CarouselModelFromJson(Map<String, dynamic> json) =>
    CarouselModel(
      type: json['type'] as String,
      discount: json['discount'] as String,
      heading: json['heading'] as String,
      subtitle: json['subtitle'] as String,
      image_url: json['image_url'] as String,
    );

Map<String, dynamic> _$CarouselModelToJson(CarouselModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'discount': instance.discount,
      'heading': instance.heading,
      'subtitle': instance.subtitle,
      'image_url': instance.image_url,
    };
