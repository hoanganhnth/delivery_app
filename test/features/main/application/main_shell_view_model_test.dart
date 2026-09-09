import 'package:delivery_app/features/main/application/main_shell_intent.dart';
import 'package:delivery_app/features/main/application/main_shell_state.dart';
import 'package:delivery_app/features/main/application/main_shell_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps four web mobile destinations and rejects invalid indices', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(mainShellViewModelProvider).index, 0);
    expect(container.read(mainShellViewModelProvider).tab, MainTab.home);

    container
        .read(mainShellViewModelProvider.notifier)
        .dispatch(const MainTabSelected(1));
    expect(container.read(mainShellViewModelProvider).tab.name, 'orders');
    expect(container.read(mainShellViewModelProvider).index, 1);

    container
        .read(mainShellViewModelProvider.notifier)
        .dispatch(const MainTabSelected(2));
    expect(container.read(mainShellViewModelProvider).tab.name, 'cart');
    expect(container.read(mainShellViewModelProvider).index, 2);
    container
        .read(mainShellViewModelProvider.notifier)
        .dispatch(const MainTabSelected(3));
    expect(container.read(mainShellViewModelProvider).tab, MainTab.account);
    expect(container.read(mainShellViewModelProvider).index, 3);
    container
        .read(mainShellViewModelProvider.notifier)
        .dispatch(const MainTabSelected(42));
    expect(container.read(mainShellViewModelProvider).tab, MainTab.home);
  });
}
