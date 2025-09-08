import 'package:hive/hive.dart';
import '../../../../core/adapter/hive_registry.dart';
import '../dtos/cart_item_dto.dart';

/// Manual Hive TypeAdapter for CartItemDto
class CartItemDtoAdapter extends TypeAdapter<CartItemDto> {
  @override
  final int typeId = HiveTypeIds.cartItemDto;

  @override
  CartItemDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartItemDto(
      menuItemId: fields[0] as num,
      menuItemName: fields[1] as String,
      price: fields[2] as double,
      quantity: fields[3] as int,
      restaurantId: fields[4] as num,
      restaurantName: fields[5] as String,
      imageUrl: fields[6] as String?,
      notes: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CartItemDto obj) {
    writer
      ..writeByte(8) // number of fields
      ..writeByte(0)
      ..write(obj.menuItemId)
      ..writeByte(1)
      ..write(obj.menuItemName)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.restaurantId)
      ..writeByte(5)
      ..write(obj.restaurantName)
      ..writeByte(6)
      ..write(obj.imageUrl)
      ..writeByte(7)
      ..write(obj.notes);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;

  @override
  int get hashCode => typeId.hashCode;
}
