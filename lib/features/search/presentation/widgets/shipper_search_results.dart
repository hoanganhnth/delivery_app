import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/features/search/presentation/providers/search_providers.dart';

class ShipperSearchResults extends ConsumerWidget {
  const ShipperSearchResults({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchAsync = ref.watch(searchShippersResultsProvider);
    final query = ref.watch(searchQueryProvider);

    if (query.isEmpty) {
      return const Center(child: Text('Type to search shippers...'));
    }

    return searchAsync.when(
      data: (shippers) {
        if (shippers.isEmpty) {
          return const Center(child: Text('No shippers found.'));
        }
        return ListView.builder(
          itemCount: shippers.length,
          itemBuilder: (context, index) {
            final shipper = shippers[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: (shipper.isOnline ?? false) ? Colors.green : Colors.grey,
                child: const Icon(Icons.delivery_dining, color: Colors.white),
              ),
              title: Text(shipper.name),
              subtitle: Text('${shipper.vehicleType ?? 'Unknown'} • ${shipper.licensePlate ?? 'N/A'}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: Colors.orange, size: 16),
                  const SizedBox(width: 4),
                  Text('${shipper.rating ?? 0.0}'),
                ],
              ),
              onTap: () {
                // Navigate to shipper details
              },
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
