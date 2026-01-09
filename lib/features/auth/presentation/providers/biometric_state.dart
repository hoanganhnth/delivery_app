import '../../../../core/error/failures.dart';
import '../../domain/entities/biometric_entity.dart';

/// State for biometric authentication
class BiometricState {
  final bool isAvailable;
  final bool isEnabled;
  final bool isLoading;
  final List<BiometricType> availableTypes;
  final Failure? failure;

  const BiometricState({
    this.isAvailable = false,
    this.isEnabled = false,
    this.isLoading = false,
    this.availableTypes = const [],
    this.failure,
  });

  // Computed properties
  bool get hasError => failure != null;
  String? get errorMessage => failure?.message;
  bool get canUseBiometric => isAvailable && availableTypes.isNotEmpty;

  BiometricState copyWith({
    bool? isAvailable,
    bool? isEnabled,
    bool? isLoading,
    List<BiometricType>? availableTypes,
    Failure? failure,
    bool clearFailure = false,
  }) {
    return BiometricState(
      isAvailable: isAvailable ?? this.isAvailable,
      isEnabled: isEnabled ?? this.isEnabled,
      isLoading: isLoading ?? this.isLoading,
      availableTypes: availableTypes ?? this.availableTypes,
      failure: clearFailure ? null : (failure ?? this.failure),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BiometricState &&
        other.isAvailable == isAvailable &&
        other.isEnabled == isEnabled &&
        other.isLoading == isLoading &&
        other.availableTypes == availableTypes &&
        other.failure == failure;
  }

  @override
  int get hashCode {
    return isAvailable.hashCode ^
        isEnabled.hashCode ^
        isLoading.hashCode ^
        availableTypes.hashCode ^
        failure.hashCode;
  }

  @override
  String toString() {
    return 'BiometricState(isAvailable: $isAvailable, isEnabled: $isEnabled, isLoading: $isLoading, hasError: $hasError)';
  }
}
