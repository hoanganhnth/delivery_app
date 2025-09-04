import 'package:delivery_app/core/error/failures.dart';

import '../../domain/entities/user_entity.dart';


class ProfileState {
  final bool isLoading;
  final UserEntity? user;
  final Failure? failure;
  const ProfileState({
    this.isLoading = false,
    this.user,
    this.failure,
  });

  // Computed properties
  bool get hasError => failure != null;
  String? get errorMessage => failure?.message;
  bool get hasUser => user != null;


  ProfileState copyWith({
    bool? isLoading,
    UserEntity? user,
    Failure? failure,
    bool clearFailure = false,
    bool clearUser = false,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      user: clearUser ? null : (user ?? this.user),
      failure: clearFailure ? null : (failure ?? this.failure),
    );
  }
 

  

  
}