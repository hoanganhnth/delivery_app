import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/features/iap/presentation/screens/consumable_screen.dart';
import 'package:delivery_app/features/iap/presentation/screens/non_consumable_screen.dart';
import 'package:delivery_app/features/iap/presentation/screens/subscription_screen.dart';
import 'package:flutter/material.dart';

/// Main store screen with tabs for all IAP types
class IapStoreScreen extends StatelessWidget {
  const IapStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Premium Store'),
          backgroundColor: context.colors.primary,
          foregroundColor: context.colors.onPrimary,
          elevation: 0,
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: const [
              Tab(
                icon: Icon(Icons.card_membership),
                text: 'Subscribe',
              ),
              Tab(
                icon: Icon(Icons.monetization_on),
                text: 'Credits',
              ),
              Tab(
                icon: Icon(Icons.lock_open),
                text: 'Features',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _SubscriptionTab(),
            _ConsumableTab(),
            _NonConsumableTab(),
          ],
        ),
      ),
    );
  }
}

class _SubscriptionTab extends StatelessWidget {
  const _SubscriptionTab();

  @override
  Widget build(BuildContext context) {
    return const SubscriptionScreen();
  }
}

class _ConsumableTab extends StatelessWidget {
  const _ConsumableTab();

  @override
  Widget build(BuildContext context) {
    return const ConsumableScreen();
  }
}

class _NonConsumableTab extends StatelessWidget {
  const _NonConsumableTab();

  @override
  Widget build(BuildContext context) {
    return const NonConsumableScreen();
  }
}

/// Simple grid card to navigate to specific IAP screens
class IapMenuScreen extends StatelessWidget {
  const IapMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium Store'),
        backgroundColor: context.colors.primary,
        foregroundColor: context.colors.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose a category',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuCard(
                    context,
                    title: 'Subscriptions',
                    subtitle: 'Premium plans',
                    icon: Icons.card_membership,
                    color: Colors.blue,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SubscriptionScreen(),
                      ),
                    ),
                  ),
                  _buildMenuCard(
                    context,
                    title: 'Credits',
                    subtitle: 'Buy delivery credits',
                    icon: Icons.monetization_on,
                    color: Colors.green,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ConsumableScreen(),
                      ),
                    ),
                  ),
                  _buildMenuCard(
                    context,
                    title: 'Features',
                    subtitle: 'Unlock forever',
                    icon: Icons.lock_open,
                    color: Colors.purple,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NonConsumableScreen(),
                      ),
                    ),
                  ),
                  _buildMenuCard(
                    context,
                    title: 'All Store',
                    subtitle: 'Browse everything',
                    icon: Icons.store,
                    color: Colors.orange,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const IapStoreScreen(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
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
