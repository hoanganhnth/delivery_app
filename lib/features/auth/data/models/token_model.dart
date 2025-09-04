import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/auth_entity.dart';

part 'token_model.freezed.dart';
part 'token_model.g.dart';

@freezed
abstract class TokenModel with _$TokenModel {
  const factory TokenModel({
    required String accessToken,
     required String refreshToken,
  }) = _TokenModel;

  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenModelFromJson(json);
}

/// Extension to convert TokenModel to AuthEntity
extension TokenModelX on TokenModel {
  AuthEntity toEntity() {
    return AuthEntity(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}

/// Extension to convert AuthEntity to TokenModel
extension AuthEntityX on AuthEntity {
  TokenModel toModel() {
    return TokenModel(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
