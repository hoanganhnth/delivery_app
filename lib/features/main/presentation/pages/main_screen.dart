import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/features/cart/presentation/pages/cart_page.dart';
import 'package:delivery_app/features/orders/presentation/pages/orders_list_page.dart';
import 'package:delivery_app/features/home/presentation/pages/home_page.dart';
import 'package:delivery_app/features/profile/presentation/pages/profile_page.dart';

import '../../application/main_shell_view_model.dart';
import '../views/main_shell_view.dart';

/// Riverpod adapter for the main tab shell.
class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mainShellViewModelProvider);
    return MainShellView(
      state: state,
      pages: const [
        HomePage(),
        OrdersListPage(isTab: true),
        CartPage(isTab: true),
        ProfilePage(isTab: true),
      ],
      onIntent: (intent) =>
          ref.read(mainShellViewModelProvider.notifier).dispatch(intent),
    );
  }
}
