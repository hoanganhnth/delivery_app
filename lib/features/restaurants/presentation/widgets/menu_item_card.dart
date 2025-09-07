import 'package:delivery_app/features/restaurants/domain/entities/menu_item_entity.dart';
import 'package:flutter/material.dart';

class MenuItemCard extends StatelessWidget {
  final MenuItemEntity menuItem;

  const MenuItemCard({super.key, required this.menuItem});

  @override
  Widget build(BuildContext context) {
    final isUnavailable = menuItem.status != MenuItemStatus.available;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Opacity(
          opacity: isUnavailable ? 0.6 : 1.0,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Menu item image
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: menuItem.image != null
                        ? DecorationImage(
                            image: NetworkImage(menuItem.image!),
                            fit: BoxFit.cover,
                            onError: (error, stackTrace) {},
                          )
                        : null,
                    color: menuItem.image == null ? Colors.grey[300] : null,
                  ),
                  child: menuItem.image == null
                      ? const Icon(Icons.fastfood, color: Colors.grey)
                      : null,
                ),

                const SizedBox(width: 12),

                // Menu item info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        menuItem.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        menuItem.description,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '${menuItem.price.toStringAsFixed(0)}đ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.orange,
                            ),
                          ),
                          const Spacer(),
                          if (isUnavailable)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                menuItem.status == MenuItemStatus.soldOut
                                    ? 'Hết hàng'
                                    : 'Không có sẵn',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          else
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.orange),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.remove, size: 16),
                                    constraints: const BoxConstraints(
                                      minWidth: 32,
                                      minHeight: 32,
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                  const Text(
                                    '0',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.add,
                                      size: 16,
                                      color: Colors.orange,
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 32,
                                      minHeight: 32,
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
