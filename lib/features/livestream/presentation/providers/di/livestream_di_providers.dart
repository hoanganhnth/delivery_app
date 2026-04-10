import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/network/dio/authenticated_network_providers.dart';
import '../../../data/datasources/livestream_firebase_datasource_impl.dart';
import '../../../data/datasources/livestream_remote_datasource_impl.dart';
import '../../../data/repositories_impl/livestream_interaction_repository_impl.dart';
import '../../../data/repositories_impl/livestream_repository_impl.dart';
import '../../../domain/usecases/get_livestreams_usecase.dart';
import '../../../domain/usecases/livestream_interaction_usecases.dart';

// ================================
// DATA LAYER DI
// Legacy Provider is fine for DI factories (no mutable state)
// ================================

/// API Service
final livestreamApiServiceProvider = Provider<LivestreamApiService>((ref) {
  final dio = ref.watch(authenticatedDioProvider);
  return LivestreamApiService(dio);
});

/// Remote datasource
final livestreamRemoteDataSourceProvider =
    Provider<LivestreamRemoteDataSource>((ref) {
  final apiService = ref.watch(livestreamApiServiceProvider);
  return LivestreamRemoteDataSourceImpl(apiService);
});

/// Firebase datasource
final livestreamFirebaseDataSourceProvider =
    Provider<LivestreamFirebaseDataSource>((ref) {
  return LivestreamFirebaseDataSourceImpl(FirebaseFirestore.instance);
});

/// Repository
final livestreamRepositoryProvider =
    Provider<LivestreamRepositoryImpl>((ref) {
  final remoteDataSource = ref.watch(livestreamRemoteDataSourceProvider);
  return LivestreamRepositoryImpl(remoteDataSource);
});

/// Interaction repository
final livestreamInteractionRepositoryProvider =
    Provider<LivestreamInteractionRepositoryImpl>((ref) {
  final firebaseDataSource = ref.watch(livestreamFirebaseDataSourceProvider);
  return LivestreamInteractionRepositoryImpl(firebaseDataSource);
});

// ================================
// USE CASE DI
// ================================

final getLivestreamsUseCaseProvider = Provider<GetLivestreamsUseCase>((ref) {
  final repository = ref.watch(livestreamRepositoryProvider);
  return GetLivestreamsUseCase(repository);
});

final getLivestreamByIdUseCaseProvider =
    Provider<GetLivestreamByIdUseCase>((ref) {
  final repository = ref.watch(livestreamRepositoryProvider);
  return GetLivestreamByIdUseCase(repository);
});

final getFeaturedLivestreamsUseCaseProvider =
    Provider<GetFeaturedLivestreamsUseCase>((ref) {
  final repository = ref.watch(livestreamRepositoryProvider);
  return GetFeaturedLivestreamsUseCase(repository);
});

final sendCommentUseCaseProvider = Provider<SendCommentUseCase>((ref) {
  final repository = ref.watch(livestreamInteractionRepositoryProvider);
  return SendCommentUseCase(repository);
});

final streamCommentsUseCaseProvider = Provider<StreamCommentsUseCase>((ref) {
  final repository = ref.watch(livestreamInteractionRepositoryProvider);
  return StreamCommentsUseCase(repository);
});

final sendLikeUseCaseProvider = Provider<SendLikeUseCase>((ref) {
  final repository = ref.watch(livestreamInteractionRepositoryProvider);
  return SendLikeUseCase(repository);
});

final streamLikesUseCaseProvider = Provider<StreamLikesUseCase>((ref) {
  final repository = ref.watch(livestreamInteractionRepositoryProvider);
  return StreamLikesUseCase(repository);
});
