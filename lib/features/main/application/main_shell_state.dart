import 'package:equatable/equatable.dart';

enum MainTab { home, cart, profile }

final class MainShellViewState extends Equatable {
  const MainShellViewState({required this.tab, required this.index});

  final MainTab tab;
  final int index;

  @override
  List<Object?> get props => [tab, index];
}
