import 'package:delivery_app/features/main/application/main_shell_intent.dart';
import 'package:delivery_app/features/main/application/main_shell_state.dart';
import 'package:delivery_app/features/main/application/main_shell_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps tab intents inside the shell ViewModel', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(mainShellViewModelProvider).index, 0);
    container
        .read(mainShellViewModelProvider.notifier)
        .dispatch(const MainTabSelected(2));

    expect(container.read(mainShellViewModelProvider).tab, MainTab.profile);
    expect(container.read(mainShellViewModelProvider).index, 2);
  });
}
