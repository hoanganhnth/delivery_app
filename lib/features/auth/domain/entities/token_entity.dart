import 'package:equatable/equatable.dart';

/// Token entity representing authentication tokens
class TokenEntity extends Equatable {
  final String accessToken;
  final String refreshToken;
  final DateTime accessTokenExpiresAt;
  final DateTime refreshTokenExpiresAt;
  final String tokenType;

  const TokenEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.accessTokenExpiresAt,
    required this.refreshTokenExpiresAt,
    this.tokenType = 'Bearer',
  });

  /// Check if access token is expired
  bool get isAccessTokenExpired {
    return DateTime.now().isAfter(accessTokenExpiresAt.subtract(const Duration(minutes: 5)));
  }

  /// Check if refresh token is expired
  bool get isRefreshTokenExpired {
    return DateTime.now().isAfter(refreshTokenExpiresAt);
  }

  /// Check if tokens are valid
  bool get isValid {
    return !isRefreshTokenExpired;
  }

  @override
  List<Object?> get props => [
        accessToken,
        refreshToken,
        accessTokenExpiresAt,
        refreshTokenExpiresAt,
        tokenType,
      ];
}
