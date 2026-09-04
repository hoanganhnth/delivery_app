import 'package:equatable/equatable.dart';

enum MainTab { home, search, account }

final class MainShellViewState extends Equatable {
  const MainShellViewState({
    required this.tab,
    required this.index,
    this.cartItemCount = 0,
  });

  final MainTab tab;
  final int index;
  final int cartItemCount;

  MainShellViewState copyWith({
    MainTab? tab,
    int? index,
    int? cartItemCount,
  }) {
    return MainShellViewState(
      tab: tab ?? this.tab,
      index: index ?? this.index,
      cartItemCount: cartItemCount ?? this.cartItemCount,
    );
  }

  @override
  List<Object?> get props => [tab, index, cartItemCount];
}
