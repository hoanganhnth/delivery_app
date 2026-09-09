import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/contracts/cart_port_provider.dart';

import 'main_shell_intent.dart';
import 'main_shell_state.dart';

final mainShellViewModelProvider =
    NotifierProvider<MainShellViewModel, MainShellViewState>(
      MainShellViewModel.new,
    );

class MainShellViewModel extends Notifier<MainShellViewState> {
  @override
  MainShellViewState build() {
    final cartReader = ref.watch(cartReaderPortProvider);
    final count = cartReader.current?.totalItems ?? 0;

    final cartSubscription = cartReader.changes.listen((snapshot) {
      state = state.copyWith(cartItemCount: snapshot.totalItems);
    });
    ref.onDispose(cartSubscription.cancel);

    return _fromTab(MainTab.home, cartItemCount: count);
  }

  void dispatch(MainShellIntent intent) {
    switch (intent) {
      case MainTabSelected(:final index):
        state = _fromTab(_fromIndex(index), cartItemCount: state.cartItemCount);
    }
  }

  MainShellViewState _fromTab(MainTab tab, {int cartItemCount = 0}) {
    return MainShellViewState(
      tab: tab,
      index: _indexFor(tab),
      cartItemCount: cartItemCount,
    );
  }

  int _indexFor(MainTab tab) {
    return switch (tab) {
      MainTab.home => 0,
      MainTab.orders => 1,
      MainTab.cart => 2,
      MainTab.account => 3,
    };
  }

  MainTab _fromIndex(int index) {
    return switch (index) {
      0 => MainTab.home,
      1 => MainTab.orders,
      2 => MainTab.cart,
      3 => MainTab.account,
      _ => MainTab.home,
    };
  }
}
