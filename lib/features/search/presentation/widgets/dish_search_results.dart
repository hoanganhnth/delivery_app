import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/features/search/presentation/providers/search_providers.dart';

class DishSearchResults extends ConsumerWidget {
  const DishSearchResults({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchAsync = ref.watch(searchDishesResultsProvider);
    final query = ref.watch(searchQueryProvider);

    if (query.isEmpty) {
      return const Center(child: Text('Nhập tên món ăn để tìm kiếm'));
    }

    return searchAsync.when(
      data: (dishes) {
        if (dishes.isEmpty) {
          return const Center(child: Text('Không tìm thấy món ăn'));
        }
        return ListView.builder(
          itemCount: dishes.length,
          itemBuilder: (context, index) {
            final dish = dishes[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: dish.imageUrl != null
                    ? NetworkImage(dish.imageUrl!)
                    : null,
                child: dish.imageUrl == null
                    ? const Icon(Icons.fastfood)
                    : null,
              ),
              title: Text(dish.name),
              subtitle: dish.description?.trim().isNotEmpty == true
                  ? Text(dish.description!.trim())
                  : null,
              trailing: dish.price == null
                  ? null
                  : Text(
                      '${NumberFormat('#,###', 'vi_VN').format(dish.price)}đ',
                    ),
              onTap: dish.restaurantId?.trim().isNotEmpty == true
                  ? () => context.pushToRestaurantDetails(
                      dish.restaurantId!.trim(),
                    )
                  : null,
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) =>
          const Center(child: Text('Không thể tải kết quả món ăn')),
    );
  }
}
