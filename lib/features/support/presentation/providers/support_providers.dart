import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/datasources/support_remote_datasource.dart';
import '../../data/repositories/support_repository_impl.dart';
import '../../domain/repositories/support_repository.dart';
import '../../domain/usecases/close_conversation_usecase.dart';
import '../../domain/usecases/get_or_create_conversation_usecase.dart';
import '../../domain/usecases/load_initial_messages_usecase.dart';
import '../../domain/usecases/load_more_messages_usecase.dart';
import '../../domain/usecases/send_media_message_usecase.dart';
import '../../domain/usecases/send_text_message_usecase.dart';
import '../../domain/usecases/stream_messages_usecase.dart';
import '../../domain/usecases/stream_new_messages_usecase.dart';

import '../../../../core/services/_riverpod/image_upload_service_provider.dart';

part 'support_providers.g.dart';

// Data Source
@Riverpod(keepAlive: true)
SupportRemoteDataSource supportRemoteDataSource(Ref ref) {
  final imageUploadService = ref.watch(imageUploadServiceProvider);
  return SupportRemoteDataSourceImpl(imageUploadService: imageUploadService);
}

// Repository
@Riverpod(keepAlive: true)
SupportRepository supportRepository(Ref ref) {
  final dataSource = ref.watch(supportRemoteDataSourceProvider);
  return SupportRepositoryImpl(dataSource);
}

// Use Cases
@Riverpod(keepAlive: true)
GetOrCreateConversationUseCase getOrCreateConversationUseCase(Ref ref) {
  final repository = ref.watch(supportRepositoryProvider);
  return GetOrCreateConversationUseCase(repository);
}

@Riverpod(keepAlive: true)
StreamMessagesUseCase streamMessagesUseCase(Ref ref) {
  final repository = ref.watch(supportRepositoryProvider);
  return StreamMessagesUseCase(repository);
}

@Riverpod(keepAlive: true)
LoadInitialMessagesUseCase loadInitialMessagesUseCase(Ref ref) {
  final repository = ref.watch(supportRepositoryProvider);
  return LoadInitialMessagesUseCase(repository);
}

@Riverpod(keepAlive: true)
LoadMoreMessagesUseCase loadMoreMessagesUseCase(Ref ref) {
  final repository = ref.watch(supportRepositoryProvider);
  return LoadMoreMessagesUseCase(repository);
}

@Riverpod(keepAlive: true)
StreamNewMessagesUseCase streamNewMessagesUseCase(Ref ref) {
  final repository = ref.watch(supportRepositoryProvider);
  return StreamNewMessagesUseCase(repository);
}

@Riverpod(keepAlive: true)
SendTextMessageUseCase sendTextMessageUseCase(Ref ref) {
  final repository = ref.watch(supportRepositoryProvider);
  return SendTextMessageUseCase(repository);
}

@Riverpod(keepAlive: true)
SendMediaMessageUseCase sendMediaMessageUseCase(Ref ref) {
  final repository = ref.watch(supportRepositoryProvider);
  return SendMediaMessageUseCase(repository);
}

@Riverpod(keepAlive: true)
CloseConversationUseCase closeConversationUseCase(Ref ref) {
  final repository = ref.watch(supportRepositoryProvider);
  return CloseConversationUseCase(repository);
}
