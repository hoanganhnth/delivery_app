import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/support_remote_datasource.dart';
import '../../data/repositories/support_repository_impl.dart';
import '../../domain/repositories/support_repository.dart';
import '../../domain/usecases/close_conversation_usecase.dart'; // ✅ Thêm
import '../../domain/usecases/get_or_create_conversation_usecase.dart';
import '../../domain/usecases/load_initial_messages_usecase.dart';
import '../../domain/usecases/load_more_messages_usecase.dart';
import '../../domain/usecases/send_media_message_usecase.dart';
import '../../domain/usecases/send_text_message_usecase.dart';
import '../../domain/usecases/stream_messages_usecase.dart';
import '../../domain/usecases/stream_new_messages_usecase.dart';

// Data Source
final supportRemoteDataSourceProvider = Provider<SupportRemoteDataSource>((ref) {
  return SupportRemoteDataSourceImpl();
});

// Repository
final supportRepositoryProvider = Provider<SupportRepository>((ref) {
  final dataSource = ref.watch(supportRemoteDataSourceProvider);
  return SupportRepositoryImpl(dataSource);
});

// Use Cases
final getOrCreateConversationUseCaseProvider = Provider<GetOrCreateConversationUseCase>((ref) {
  final repository = ref.watch(supportRepositoryProvider);
  return GetOrCreateConversationUseCase(repository);
});

final streamMessagesUseCaseProvider = Provider<StreamMessagesUseCase>((ref) {
  final repository = ref.watch(supportRepositoryProvider);
  return StreamMessagesUseCase(repository);
});

final loadInitialMessagesUseCaseProvider = Provider<LoadInitialMessagesUseCase>((ref) {
  final repository = ref.watch(supportRepositoryProvider);
  return LoadInitialMessagesUseCase(repository);
});

final loadMoreMessagesUseCaseProvider = Provider<LoadMoreMessagesUseCase>((ref) {
  final repository = ref.watch(supportRepositoryProvider);
  return LoadMoreMessagesUseCase(repository);
});

final streamNewMessagesUseCaseProvider = Provider<StreamNewMessagesUseCase>((ref) {
  final repository = ref.watch(supportRepositoryProvider);
  return StreamNewMessagesUseCase(repository);
});

final sendTextMessageUseCaseProvider = Provider<SendTextMessageUseCase>((ref) {
  final repository = ref.watch(supportRepositoryProvider);
  return SendTextMessageUseCase(repository);
});

final sendMediaMessageUseCaseProvider = Provider<SendMediaMessageUseCase>((ref) {
  final repository = ref.watch(supportRepositoryProvider);
  return SendMediaMessageUseCase(repository);
});

// ✅ Thêm CloseConversationUseCase provider
final closeConversationUseCaseProvider = Provider<CloseConversationUseCase>((ref) {
  final repository = ref.watch(supportRepositoryProvider);
  return CloseConversationUseCase(repository);
});
