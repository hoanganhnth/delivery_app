import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/core/services/share/_riverpod/share_provider.dart';
import 'package:delivery_app/core/services/deep_link/_riverpod/deep_link_provider.dart';
import 'package:delivery_app/features/restaurants/domain/extensions/deep_link_extensions.dart';
import 'package:delivery_app/features/restaurants/domain/extensions/share_extensions.dart';
import '../../routing/router_config.dart';

/// Demo widget for testing deep links
class DeepLinkDemoWidget extends ConsumerWidget {
  const DeepLinkDemoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shareService = ref.watch(shareServiceProvider);
    final deepLinkService = ref.watch(deepLinkServiceProvider);
    final config = ref.watch(routerConfigProvider);
    final baseUrl = config.baseUrl ?? 'https://deliveryapp.com';

    return Card(
      margin: EdgeInsets.all(16.w),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deep Link Demo',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.w),
            Text(
              'Base URL: ${config.baseUrl ?? "Not configured"}',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: ref.colors.textSecondary),
            ),
            SizedBox(height: 16.w),

            // Restaurant Deep Links
            _buildSection(context, 'Restaurant Links', [
              _buildLinkButton(
                context,
                'Restaurant #1',
                () => _copyLink(
                  context,
                  deepLinkService.generateRestaurantLink(baseUrl, 'rest_1'),
                ),
              ),
              _buildLinkButton(
                context,
                'Share Restaurant',
                () => shareService.shareRestaurant(
                  restaurantId: 'rest_1',
                  restaurantName: 'Amazing Restaurant',
                  baseUrl: baseUrl,
                ),
              ),
            ]),

            SizedBox(height: 16.w),

            // Order Deep Links — using generic generateDeepLink (Core method)
            _buildSection(context, 'Order Links', [
              _buildLinkButton(
                context,
                'Order #ORD1001',
                () => _copyLink(
                  context,
                  deepLinkService.generateDeepLink(
                    baseUrl: baseUrl,
                    path: '/order',
                    params: {'id': 'ORD1001'},
                  ),
                ),
              ),
              _buildLinkButton(
                context,
                'Track Order',
                () => _copyLink(
                  context,
                  deepLinkService.generateDeepLink(
                    baseUrl: baseUrl,
                    path: '/track',
                    params: {'order_id': 'ORD1001'},
                  ),
                ),
              ),
            ]),

            SizedBox(height: 16.w),

            // Promo Deep Links
            _buildSection(context, 'Promo Links', [
              _buildLinkButton(
                context,
                'SAVE20 Promo',
                () => _copyLink(
                  context,
                  deepLinkService.generatePromoLink(baseUrl, 'SAVE20'),
                ),
              ),
              _buildLinkButton(
                context,
                'Share Promo',
                () => shareService.sharePromo(
                  promoCode: 'SAVE20',
                  description: '20% off your order',
                  baseUrl: baseUrl,
                ),
              ),
            ]),

            SizedBox(height: 16.w),

            // Custom Deep Links — pure Core method
            _buildSection(context, 'Custom Links', [
              _buildLinkButton(
                context,
                'Menu Link',
                () => _copyLink(
                  context,
                  deepLinkService.generateDeepLink(
                    baseUrl: baseUrl,
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
                  deepLinkService.generateDeepLink(
                    baseUrl: baseUrl,
                    path: '/reset-password',
                    params: {'token': 'abc123'},
                  ),
                ),
              ),
            ]),

            SizedBox(height: 16.w),

            // Test Links Section
            Container(
              padding: EdgeInsets.all(12.w),
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
                      SizedBox(width: 8.w),
                      Text(
                        'How to Test Deep Links',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.w),
                  Text(
                    '1. Copy a link above\n'
                    '2. Open in browser or share via message\n'
                    '3. Click the link to open the app\n'
                    '4. App should navigate to the correct screen',
                    style: TextStyle(color: Colors.blue[700], fontSize: 12.sp),
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
        SizedBox(height: 8.w),
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
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
        textStyle: TextStyle(fontSize: 12.sp),
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
