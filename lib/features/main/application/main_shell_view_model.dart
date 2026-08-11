import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main_shell_intent.dart';
import 'main_shell_state.dart';

final mainShellViewModelProvider =
    NotifierProvider<MainShellViewModel, MainShellViewState>(
      MainShellViewModel.new,
    );

class MainShellViewModel extends Notifier<MainShellViewState> {
  @override
  MainShellViewState build() => _fromTab(MainTab.home);

  void dispatch(MainShellIntent intent) {
    switch (intent) {
      case MainTabSelected(:final index):
        state = _fromTab(_fromIndex(index));
    }
  }

  MainShellViewState _fromTab(MainTab tab) {
    return MainShellViewState(tab: tab, index: _indexFor(tab));
  }

  int _indexFor(MainTab tab) {
    return switch (tab) {
      MainTab.home => 0,
      MainTab.cart => 1,
      MainTab.profile => 2,
    };
  }

  MainTab _fromIndex(int index) {
    return switch (index) {
      0 => MainTab.home,
      1 => MainTab.cart,
      2 => MainTab.profile,
      _ => MainTab.home,
    };
  }
}
