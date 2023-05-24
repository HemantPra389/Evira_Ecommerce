import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/carousel_entity.dart';

part 'carousel_model.g.dart';

@JsonSerializable()
class CarouselModel extends CarouselEntity {
  String type;
  String discount;
  String heading;
  String subtitle;
  String image_url;
  CarouselModel({
    required this.type,
    required this.discount,
    required this.heading,
    required this.subtitle,
    required this.image_url,
  }) : super(
            type: type,
            discount: discount,
            heading: heading,
            subtitle: subtitle,
            image_url: image_url);

  factory CarouselModel.fromJson(Map<String, dynamic> json) =>
      _$CarouselModelFromJson(json);

  Map<String, dynamic> toJson() => _$CarouselModelToJson(this);
}
