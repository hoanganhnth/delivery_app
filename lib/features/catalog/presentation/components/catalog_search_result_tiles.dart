import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../application/catalog_search_state.dart';

class CatalogDishSearchResultTile extends StatelessWidget {
  const CatalogDishSearchResultTile({
    super.key,
    required this.item,
    required this.onTap,
  });

  final CatalogDishSearchViewData item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: item.imageUrl == null
            ? null
            : NetworkImage(item.imageUrl!),
        child: item.imageUrl == null ? const Icon(Icons.fastfood) : null,
      ),
      title: Text(item.name),
      subtitle: item.description?.trim().isNotEmpty == true
          ? Text(item.description!.trim())
          : null,
      trailing: item.price == null
          ? null
          : Text('${NumberFormat('#,###', 'vi_VN').format(item.price)}đ'),
      onTap: onTap,
    );
  }
}

class CatalogRestaurantSearchResultTile extends StatelessWidget {
  const CatalogRestaurantSearchResultTile({
    super.key,
    required this.item,
    required this.onTap,
  });

  final CatalogRestaurantSearchViewData item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: item.imageUrl == null
              ? null
              : DecorationImage(
                  image: NetworkImage(item.imageUrl!),
                  fit: BoxFit.cover,
                ),
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
        ),
        child: item.imageUrl == null ? const Icon(Icons.store) : null,
      ),
      title: Text(item.name),
      subtitle: item.cuisine?.trim().isNotEmpty == true
          ? Text(item.cuisine!.trim())
          : null,
      trailing: item.rating == null
          ? null
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 16),
                const SizedBox(width: 4),
                Text(item.rating!.toStringAsFixed(1)),
              ],
            ),
      onTap: onTap,
    );
  }
}
