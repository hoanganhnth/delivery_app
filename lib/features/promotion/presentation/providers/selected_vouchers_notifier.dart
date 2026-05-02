import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_vouchers_notifier.g.dart';

@riverpod
class SelectedVouchersNotifier extends _$SelectedVouchersNotifier {
  @override
  List<int> build() {
    return [];
  }

  void toggleVoucher(int voucherId) {
    if (state.contains(voucherId)) {
      state = state.where((id) => id != voucherId).toList();
    } else {
      state = [...state, voucherId];
    }
  }

  void clear() {
    state = [];
  }
}
