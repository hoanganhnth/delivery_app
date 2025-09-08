import 'package:hive/hive.dart';
import '../../../../core/adapter/hive_registry.dart';
import '../dtos/cart_dto.dart';
import '../dtos/cart_item_dto.dart';

/// Manual Hive TypeAdapter for CartDto
class CartDtoAdapter extends TypeAdapter<CartDto> {
  @override
  final int typeId = HiveTypeIds.cartDto;

  @override
  CartDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartDto(
      items: (fields[0] as List).cast<CartItemDto>(),
      currentRestaurantId: fields[1] as num?,
      currentRestaurantName: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CartDto obj) {
    writer
      ..writeByte(3) // number of fields
      ..writeByte(0)
      ..write(obj.items)
      ..writeByte(1)
      ..write(obj.currentRestaurantId)
      ..writeByte(2)
      ..write(obj.currentRestaurantName);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;

  @override
  int get hashCode => typeId.hashCode;
}
