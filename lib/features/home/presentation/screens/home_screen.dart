import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../../core/presentation/widgets/guard_demo_widget.dart';

/// Home Screen
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.pushNamed('profile'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.pushNamed('settings'),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final authNotifier = ref.read(authStateProvider.notifier);
              await authNotifier.logout();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (authState.hasUser) ...[
              Text(
                'Welcome, ${authState.user!.email}!',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
            ],
            
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildFeatureCard(
                    context,
                    'Restaurants',
                    Icons.restaurant,
                    () => context.pushNamed('restaurants'),
                  ),
                  _buildFeatureCard(
                    context,
                    'Orders',
                    Icons.receipt_long,
                    () => context.pushNamed('orders'),
                  ),
                  _buildFeatureCard(
                    context,
                    'Cart',
                    Icons.shopping_cart,
                    () => context.pushNamed('cart'),
                  ),
                  _buildFeatureCard(
                    context,
                    'Profile',
                    Icons.person,
                    () => context.pushNamed('profile'),
                  ),
                  // Show admin panel for admin users
                  if (authState.hasUser && authState.user!.email.contains('admin'))
                    _buildFeatureCard(
                      context,
                      'Admin Panel',
                      Icons.admin_panel_settings,
                      () => context.pushNamed('admin'),
                      color: Colors.red,
                    ),
                ],
              ),
            ),

            // GuardManager Demo (for development/testing)
            const GuardDemoWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap, {
    Color? color,
  }) {
    final cardColor = color ?? Theme.of(context).primaryColor;

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: cardColor),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: color != null ? cardColor : null,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
