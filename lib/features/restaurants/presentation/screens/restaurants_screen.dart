import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Restaurants Screen
class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          final restaurantId = 'rest_$index';
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.restaurant, size: 40),
              title: Text('Restaurant ${index + 1}'),
              subtitle: Text('${(index + 1) * 0.5} km away • \$\$ • 4.${5 + index % 5} ⭐'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => context.pushNamed(
                'restaurant-details',
                pathParameters: {'restaurantId': restaurantId},
              ),
            ),
          );
        },
      ),
    );
  }
}
