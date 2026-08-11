import 'package:flutter/material.dart';

import '../pages/cart_page.dart';

/// Compatibility route owner while callers migrate to [CartPage].
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) => const CartPage();
}
