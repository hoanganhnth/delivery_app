import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/core/network/dio/authenticated_network_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/datasources/livestream_firebase_datasource_impl.dart';
import '../../../data/datasources/livestream_remote_datasource_impl.dart';
import '../../../data/repositories_impl/livestream_interaction_repository_impl.dart';
import '../../../data/repositories_impl/livestream_repository_impl.dart';
import '../../../domain/usecases/get_livestreams_usecase.dart';
import '../../../domain/usecases/livestream_interaction_usecases.dart';

part 'livestream_di_providers.g.dart';

// ================================
// DATA LAYER DI
// ================================

/// API Service
@Riverpod(keepAlive: true)
LivestreamApiService livestreamApiService(Ref ref) {
  final dio = ref.watch(authenticatedDioProvider);
  return LivestreamApiService(dio);
}

/// Remote datasource
@Riverpod(keepAlive: true)
LivestreamRemoteDataSource livestreamRemoteDataSource(Ref ref) {
  final apiService = ref.watch(livestreamApiServiceProvider);
  return LivestreamRemoteDataSourceImpl(apiService);
}

/// Firebase datasource
@Riverpod(keepAlive: true)
LivestreamFirebaseDataSource livestreamFirebaseDataSource(Ref ref) {
  return LivestreamFirebaseDataSourceImpl(FirebaseFirestore.instance);
}

/// Repository
@Riverpod(keepAlive: true)
LivestreamRepositoryImpl livestreamRepository(Ref ref) {
  final remoteDataSource = ref.watch(livestreamRemoteDataSourceProvider);
  return LivestreamRepositoryImpl(remoteDataSource);
}

/// Interaction repository
@Riverpod(keepAlive: true)
LivestreamInteractionRepositoryImpl livestreamInteractionRepository(Ref ref) {
  final firebaseDataSource = ref.watch(livestreamFirebaseDataSourceProvider);
  return LivestreamInteractionRepositoryImpl(firebaseDataSource);
}

// ================================
// USE CASE DI
// ================================

@Riverpod(keepAlive: true)
GetLivestreamsUseCase getLivestreamsUseCase(Ref ref) {
  final repository = ref.watch(livestreamRepositoryProvider);
  return GetLivestreamsUseCase(repository);
}

@Riverpod(keepAlive: true)
GetLivestreamByIdUseCase getLivestreamByIdUseCase(Ref ref) {
  final repository = ref.watch(livestreamRepositoryProvider);
  return GetLivestreamByIdUseCase(repository);
}

@Riverpod(keepAlive: true)
GetFeaturedLivestreamsUseCase getFeaturedLivestreamsUseCase(Ref ref) {
  final repository = ref.watch(livestreamRepositoryProvider);
  return GetFeaturedLivestreamsUseCase(repository);
}

@Riverpod(keepAlive: true)
SendCommentUseCase sendCommentUseCase(Ref ref) {
  final repository = ref.watch(livestreamInteractionRepositoryProvider);
  return SendCommentUseCase(repository);
}

@Riverpod(keepAlive: true)
StreamCommentsUseCase streamCommentsUseCase(Ref ref) {
  final repository = ref.watch(livestreamInteractionRepositoryProvider);
  return StreamCommentsUseCase(repository);
}

@Riverpod(keepAlive: true)
SendLikeUseCase sendLikeUseCase(Ref ref) {
  final repository = ref.watch(livestreamInteractionRepositoryProvider);
  return SendLikeUseCase(repository);
}

@Riverpod(keepAlive: true)
StreamLikesUseCase streamLikesUseCase(Ref ref) {
  final repository = ref.watch(livestreamInteractionRepositoryProvider);
  return StreamLikesUseCase(repository);
}
