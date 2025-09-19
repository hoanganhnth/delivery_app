import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_links/app_links.dart';
import '../../services/share_service.dart';
import '../../routing/router_config.dart';

/// Demo widget for testing app_links deep linking
class AppLinksDemoWidget extends ConsumerStatefulWidget {
  const AppLinksDemoWidget({super.key});

  @override
  ConsumerState<AppLinksDemoWidget> createState() => _AppLinksDemoWidgetState();
}

class _AppLinksDemoWidgetState extends ConsumerState<AppLinksDemoWidget> {
  final AppLinks _appLinks = AppLinks();
  String? _latestLink;
  String? _initialLink;

  @override
  void initState() {
    super.initState();
    _initDeepLinks();
  }

  Future<void> _initDeepLinks() async {
    // Get initial link
    try {
      final Uri? initialUri = await _appLinks.getInitialLink();
      if (mounted) {
        setState(() {
          _initialLink = initialUri?.toString();
        });
      }
    } catch (e) {
      debugPrint('Failed to get initial link: $e');
    }

    // Listen for incoming links
    _appLinks.uriLinkStream.listen(
      (Uri uri) {
        if (mounted) {
          setState(() {
            _latestLink = uri.toString();
          });
        }
      },
      onError: (err) {
        debugPrint('Deep link error: $err');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final shareService = ref.watch(shareServiceProvider);
    final config = ref.watch(routerConfigProvider);
    
    return Card(
      margin: EdgeInsets.all(16.w),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'App Links Demo',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.w),
            Text(
              'Using app_links package for deep linking',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16.w),
            
            // Link Status
            _buildLinkStatus(),
            
            SizedBox(height: 16.w),
            
            // Test Links Section
            Text(
              'Test Deep Links',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.w),
            
            // Custom Scheme Links
            _buildSection(
              context,
              'Custom Scheme (deliveryapp://)',
              [
                _buildTestButton(
                  'Restaurant',
                  'deliveryapp://restaurant?id=rest_1',
                ),
                _buildTestButton(
                  'Order',
                  'deliveryapp://order?id=ORD1001',
                ),
                _buildTestButton(
                  'Track Order',
                  'deliveryapp://track?order_id=ORD1001',
                ),
                _buildTestButton(
                  'Promo',
                  'deliveryapp://promo?code=SAVE20',
                ),
              ],
            ),
            
            SizedBox(height: 16.w),
            
            // Universal Links
            _buildSection(
              context,
              'Universal Links (HTTPS)',
              [
                _buildTestButton(
                  'Restaurant',
                  '${config.baseUrl ?? "https://deliveryapp.com"}/restaurant?id=rest_1',
                ),
                _buildTestButton(
                  'Order',
                  '${config.baseUrl ?? "https://deliveryapp.com"}/order?id=ORD1001',
                ),
                _buildTestButton(
                  'Reset Password',
                  '${config.baseUrl ?? "https://deliveryapp.com"}/reset-password?token=abc123',
                ),
              ],
            ),
            
            SizedBox(height: 16.w),
            
            // Share Service Integration
            _buildSection(
              context,
              'Share Service',
              [
                ElevatedButton.icon(
                  onPressed: () => _shareRestaurant(shareService),
                  icon: const Icon(Icons.share, size: 16),
                  label: const Text('Share Restaurant'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
                    textStyle: TextStyle(fontSize: 12.sp),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _shareOrder(shareService),
                  icon: const Icon(Icons.share, size: 16),
                  label: const Text('Share Order'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
                    textStyle: TextStyle(fontSize: 12.sp),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 16.w),
            
            // Instructions
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info, color: Colors.green, size: 16),
                      SizedBox(width: 8.w),
                      Text(
                        'How to Test',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.w),
                  Text(
                    '1. Copy a link above\n'
                    '2. Open in browser or share via message\n'
                    '3. Click the link to test deep linking\n'
                    '4. App should navigate to the correct screen\n'
                    '5. Check link status above for received links',
                    style: TextStyle(
                      color: Colors.green[700],
                      fontSize: 12.sp,
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

  Widget _buildLinkStatus() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.1),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Link Status',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.w),
          if (_initialLink != null) ...[
            Text(
              'Initial Link: $_initialLink',
              style: TextStyle(
                color: Colors.blue[700],
                fontSize: 12.sp,
                fontFamily: 'monospace',
              ),
            ),
            SizedBox(height: 4.w),
          ],
          if (_latestLink != null) ...[
            Text(
              'Latest Link: $_latestLink',
              style: TextStyle(
                color: Colors.blue[700],
                fontSize: 12.sp,
                fontFamily: 'monospace',
              ),
            ),
          ] else ...[
            Text(
              'No links received yet',
              style: TextStyle(
                color: Colors.blue[700],
                fontSize: 12.sp,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.w),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: children,
        ),
      ],
    );
  }

  Widget _buildTestButton(String label, String link) {
    return ElevatedButton.icon(
      onPressed: () => _copyLink(link),
      icon: const Icon(Icons.link, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
        textStyle: TextStyle(fontSize: 12.sp),
      ),
    );
  }

  void _copyLink(String link) {
    Clipboard.setData(ClipboardData(text: link));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Link copied: $link'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _shareRestaurant(ShareService shareService) async {
    try {
      await shareService.shareRestaurant('rest_1', 'Amazing Restaurant');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Restaurant link shared!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to share: $e')),
        );
      }
    }
  }

  Future<void> _shareOrder(ShareService shareService) async {
    try {
      await shareService.shareOrder('ORD1001');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Order link shared!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to share: $e')),
        );
      }
    }
  }
}
