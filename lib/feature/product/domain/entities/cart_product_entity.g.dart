// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_product_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartProductEntityAdapter extends TypeAdapter<CartProductEntity> {
  @override
  final int typeId = 0;

  @override
  CartProductEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartProductEntity(
      id: fields[0] as String,
      title: fields[1] as String,
      price: fields[2] as double,
      imageUrl: fields[3] as String,
      rating: fields[4] as String,
      sold: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CartProductEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.rating)
      ..writeByte(5)
      ..write(obj.sold);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartProductEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
