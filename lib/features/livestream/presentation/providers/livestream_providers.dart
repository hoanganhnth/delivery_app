import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio/authenticated_network_providers.dart';
import '../../data/datasources/livestream_firebase_datasource_impl.dart';
import '../../data/datasources/livestream_remote_datasource_impl.dart';
import '../../data/repositories_impl/livestream_interaction_repository_impl.dart';
import '../../data/repositories_impl/livestream_repository_impl.dart';
import '../../domain/usecases/get_livestreams_usecase.dart';
import '../../domain/usecases/livestream_interaction_usecases.dart';
import 'livestream_detail_notifier.dart';
import 'livestream_notifier.dart';
import 'livestream_state.dart';

// ================================
// DATA LAYER PROVIDERS
// ================================

/// API Service provider
final livestreamApiServiceProvider = Provider<LivestreamApiService>((ref) {
  final dio = ref.watch(authenticatedDioProvider);
  return LivestreamApiService(dio);
});

/// Remote datasource provider
final livestreamRemoteDataSourceProvider = Provider<LivestreamRemoteDataSource>((ref) {
  final apiService = ref.watch(livestreamApiServiceProvider);
  return LivestreamRemoteDataSourceImpl(apiService);
});

/// Firebase datasource provider
final livestreamFirebaseDataSourceProvider = Provider<LivestreamFirebaseDataSource>((ref) {
  return LivestreamFirebaseDataSourceImpl(FirebaseFirestore.instance);
});

/// Repository provider
final livestreamRepositoryProvider = Provider<LivestreamRepositoryImpl>((ref) {
  final remoteDataSource = ref.watch(livestreamRemoteDataSourceProvider);
  return LivestreamRepositoryImpl(remoteDataSource);
});

/// Interaction repository provider
final livestreamInteractionRepositoryProvider = Provider<LivestreamInteractionRepositoryImpl>((ref) {
  final firebaseDataSource = ref.watch(livestreamFirebaseDataSourceProvider);
  return LivestreamInteractionRepositoryImpl(firebaseDataSource);
});

// ================================
// USE CASE PROVIDERS
// ================================

/// Get livestreams use case
final getLivestreamsUseCaseProvider = Provider<GetLivestreamsUseCase>((ref) {
  final repository = ref.watch(livestreamRepositoryProvider);
  return GetLivestreamsUseCase(repository);
});

/// Get livestream by ID use case
final getLivestreamByIdUseCaseProvider = Provider<GetLivestreamByIdUseCase>((ref) {
  final repository = ref.watch(livestreamRepositoryProvider);
  return GetLivestreamByIdUseCase(repository);
});

/// Get featured livestreams use case
final getFeaturedLivestreamsUseCaseProvider = Provider<GetFeaturedLivestreamsUseCase>((ref) {
  final repository = ref.watch(livestreamRepositoryProvider);
  return GetFeaturedLivestreamsUseCase(repository);
});

/// Send comment use case
final sendCommentUseCaseProvider = Provider<SendCommentUseCase>((ref) {
  final repository = ref.watch(livestreamInteractionRepositoryProvider);
  return SendCommentUseCase(repository);
});

/// Stream comments use case
final streamCommentsUseCaseProvider = Provider<StreamCommentsUseCase>((ref) {
  final repository = ref.watch(livestreamInteractionRepositoryProvider);
  return StreamCommentsUseCase(repository);
});

/// Send like use case
final sendLikeUseCaseProvider = Provider<SendLikeUseCase>((ref) {
  final repository = ref.watch(livestreamInteractionRepositoryProvider);
  return SendLikeUseCase(repository);
});

/// Stream likes use case
final streamLikesUseCaseProvider = Provider<StreamLikesUseCase>((ref) {
  final repository = ref.watch(livestreamInteractionRepositoryProvider);
  return StreamLikesUseCase(repository);
});

// ================================
// STATE NOTIFIER PROVIDERS
// ================================

/// Livestream list notifier provider
final livestreamNotifierProvider = StateNotifierProvider<LivestreamNotifier, LivestreamState>((ref) {
  final getLivestreamsUseCase = ref.watch(getLivestreamsUseCaseProvider);
  final getFeaturedLivestreamsUseCase = ref.watch(getFeaturedLivestreamsUseCaseProvider);

  return LivestreamNotifier(
    getLivestreamsUseCase: getLivestreamsUseCase,
    getFeaturedLivestreamsUseCase: getFeaturedLivestreamsUseCase,
  );
});

/// Livestream detail notifier provider (with parameter)
final livestreamDetailNotifierProvider = StateNotifierProvider.family<
    LivestreamDetailNotifier, LivestreamDetailState, num>((ref, livestreamId) {
  final getLivestreamByIdUseCase = ref.watch(getLivestreamByIdUseCaseProvider);
  final streamCommentsUseCase = ref.watch(streamCommentsUseCaseProvider);
  final streamLikesUseCase = ref.watch(streamLikesUseCaseProvider);

  final notifier = LivestreamDetailNotifier(
    getLivestreamByIdUseCase: getLivestreamByIdUseCase,
    streamCommentsUseCase: streamCommentsUseCase,
    streamLikesUseCase: streamLikesUseCase,
  );

  // Auto-load livestream detail
  notifier.loadLivestreamDetail(livestreamId);

  return notifier;
});

/// Livestream interaction notifier provider (with parameter)
final livestreamInteractionNotifierProvider = StateNotifierProvider.family<
    LivestreamInteractionNotifier, LivestreamInteractionState, num>((ref, livestreamId) {
  final sendCommentUseCase = ref.watch(sendCommentUseCaseProvider);
  final sendLikeUseCase = ref.watch(sendLikeUseCaseProvider);
  final streamCommentsUseCase = ref.watch(streamCommentsUseCaseProvider);
  final streamLikesUseCase = ref.watch(streamLikesUseCaseProvider);

  final notifier = LivestreamInteractionNotifier(
    sendCommentUseCase: sendCommentUseCase,
    sendLikeUseCase: sendLikeUseCase,
    streamCommentsUseCase: streamCommentsUseCase,
    streamLikesUseCase: streamLikesUseCase,
  );

  // Auto-start streaming
  notifier.startStreaming(livestreamId);

  return notifier;
});
