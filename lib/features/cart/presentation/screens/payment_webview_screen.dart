import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:delivery_app/features/cart/domain/entities/cart_entity.dart';
import 'package:delivery_app/features/orders/data/dtos/create_order_request_dto.dart';
import 'package:delivery_app/features/orders/presentation/providers/orders/create_order_async_notifiers.dart';
import 'package:delivery_app/features/cart/presentation/providers/state/cart_notifier.dart';
import 'package:delivery_app/core/widgets/feedback/toast/toast_utils.dart';
import 'package:delivery_app/core/widgets/amber_widgets.dart';

class PaymentWebViewScreen extends ConsumerStatefulWidget {
  final String paymentUrl;
  final String paymentRef;
  final CartEntity cart;
  final CreateOrderRequestDto orderRequest;

  const PaymentWebViewScreen({
    super.key,
    required this.paymentUrl,
    required this.paymentRef,
    required this.cart,
    required this.orderRequest,
  });

  @override
  ConsumerState<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends ConsumerState<PaymentWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            // Check if we hit the callback URL (the backend redirect)
            // VNPay will redirect to vnpay-callback after user interaction
            if (request.url.contains('vnpay-callback') || 
                request.url.contains('vnp_ResponseCode')) {
              
              _handlePaymentCallback(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  void _handlePaymentCallback(String url) async {
    final uri = Uri.parse(url);
    final responseCode = uri.queryParameters['vnp_ResponseCode'];
    
    if (responseCode == '00') {
      // Thanh toán thành công, tiến hành tạo order
      ToastUtils.showOrderPlacedSuccess(context);
      ref.read(createOrderProvider.notifier).createOrder(widget.orderRequest);
      ref.read(cartProvider.notifier).clearCart();
      context.go('/');
    } else {
      // Thanh toán thất bại hoặc hủy
      ToastUtils.showOrderPlacedError(context, message: 'Thanh toán thất bại hoặc đã bị hủy.');
      if (context.canPop()) {
        context.pop();
      } else {
        context.go('/');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán VNPay'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            // Hiển thị hộp thoại xác nhận hủy
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Hủy thanh toán?'),
                content: const Text('Bạn có chắc chắn muốn hủy quá trình thanh toán?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('Không'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go('/');
                      }
                    },
                    child: const Text('Có'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
