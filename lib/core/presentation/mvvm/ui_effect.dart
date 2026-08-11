import 'package:equatable/equatable.dart';

/// A one-shot UI effect with a stable identity.
///
/// Effects live in a ViewModel state queue until the page adapter acknowledges
/// them. This makes navigation/dialog/toast requests observable and testable
/// without putting BuildContext or platform objects in the ViewModel.
final class UiEffectEnvelope<E> extends Equatable {
  const UiEffectEnvelope({required this.id, required this.effect});

  final int id;
  final E effect;

  @override
  List<Object?> get props => [id, effect];
}

/// Removes an acknowledged effect from an immutable queue.
List<UiEffectEnvelope<E>> consumeUiEffect<E>(
  List<UiEffectEnvelope<E>> effects,
  int id,
) {
  return List<UiEffectEnvelope<E>>.unmodifiable(
    effects.where((effect) => effect.id != id),
  );
}
