import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/share_service.dart';
import '../../services/deep_link_service.dart';
import '../../routing/router_config.dart';

/// Demo widget for testing deep links
class DeepLinkDemoWidget extends ConsumerWidget {
  const DeepLinkDemoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shareService = ref.watch(shareServiceProvider);
    final config = ref.watch(routerConfigProvider);

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deep Link Demo',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Base URL: ${config.baseUrl ?? "Not configured"}',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),

            // Restaurant Deep Links
            _buildSection(context, 'Restaurant Links', [
              _buildLinkButton(
                context,
                'Restaurant #1',
                () => _copyLink(
                  context,
                  DeepLinkService.generateRestaurantLink(
                    config.baseUrl ?? 'https://deliveryapp.com',
                    'rest_1',
                  ),
                ),
              ),
              _buildLinkButton(
                context,
                'Share Restaurant',
                () => shareService.shareRestaurant(
                  'rest_1',
                  'Amazing Restaurant',
                ),
              ),
            ]),

            const SizedBox(height: 16),

            // Order Deep Links
            _buildSection(context, 'Order Links', [
              _buildLinkButton(
                context,
                'Order #ORD1001',
                () => _copyLink(
                  context,
                  DeepLinkService.generateOrderLink(
                    config.baseUrl ?? 'https://deliveryapp.com',
                    'ORD1001',
                  ),
                ),
              ),
              _buildLinkButton(
                context,
                'Track Order',
                () => _copyLink(
                  context,
                  DeepLinkService.generateTrackingLink(
                    config.baseUrl ?? 'https://deliveryapp.com',
                    'ORD1001',
                  ),
                ),
              ),
            ]),

            const SizedBox(height: 16),

            // Promo Deep Links
            _buildSection(context, 'Promo Links', [
              _buildLinkButton(
                context,
                'SAVE20 Promo',
                () => _copyLink(
                  context,
                  DeepLinkService.generatePromoLink(
                    config.baseUrl ?? 'https://deliveryapp.com',
                    'SAVE20',
                  ),
                ),
              ),
              _buildLinkButton(
                context,
                'Share Promo',
                () => shareService.sharePromo('SAVE20', '20% off your order'),
              ),
            ]),

            const SizedBox(height: 16),

            // Custom Deep Links
            _buildSection(context, 'Custom Links', [
              _buildLinkButton(
                context,
                'Menu Link',
                () => _copyLink(
                  context,
                  DeepLinkService.generateDeepLink(
                    baseUrl: config.baseUrl ?? 'https://deliveryapp.com',
                    path: '/menu',
                    params: {'restaurant_id': 'rest_1'},
                  ),
                ),
              ),
              _buildLinkButton(
                context,
                'Reset Password',
                () => _copyLink(
                  context,
                  DeepLinkService.generateDeepLink(
                    baseUrl: config.baseUrl ?? 'https://deliveryapp.com',
                    path: '/reset-password',
                    params: {'token': 'abc123'},
                  ),
                ),
              ),
            ]),

            const SizedBox(height: 16),

            // Test Links Section
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: Colors.blue, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        'How to Test Deep Links',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '1. Copy a link above\n'
                    '2. Open in browser or share via message\n'
                    '3. Click the link to open the app\n'
                    '4. App should navigate to the correct screen',
                    style: TextStyle(color: Colors.blue[700], fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 8, children: children),
      ],
    );
  }

  Widget _buildLinkButton(
    BuildContext context,
    String label,
    VoidCallback onPressed,
  ) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.link, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        textStyle: const TextStyle(fontSize: 12),
      ),
    );
  }

  void _copyLink(BuildContext context, String link) {
    Clipboard.setData(ClipboardData(text: link));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Link copied: $link'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'View',
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Deep Link'),
                content: SelectableText(link),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
