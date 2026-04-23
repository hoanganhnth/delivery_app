// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'livestream_di_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// API Service

@ProviderFor(livestreamApiService)
final livestreamApiServiceProvider = LivestreamApiServiceProvider._();

/// API Service

final class LivestreamApiServiceProvider
    extends
        $FunctionalProvider<
          LivestreamApiService,
          LivestreamApiService,
          LivestreamApiService
        >
    with $Provider<LivestreamApiService> {
  /// API Service
  LivestreamApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'livestreamApiServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$livestreamApiServiceHash();

  @$internal
  @override
  $ProviderElement<LivestreamApiService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LivestreamApiService create(Ref ref) {
    return livestreamApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LivestreamApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LivestreamApiService>(value),
    );
  }
}

String _$livestreamApiServiceHash() =>
    r'7d3d2a22e85d3d231a4663c363fbecec424d2440';

/// Remote datasource

@ProviderFor(livestreamRemoteDataSource)
final livestreamRemoteDataSourceProvider =
    LivestreamRemoteDataSourceProvider._();

/// Remote datasource

final class LivestreamRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          LivestreamRemoteDataSource,
          LivestreamRemoteDataSource,
          LivestreamRemoteDataSource
        >
    with $Provider<LivestreamRemoteDataSource> {
  /// Remote datasource
  LivestreamRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'livestreamRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$livestreamRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<LivestreamRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LivestreamRemoteDataSource create(Ref ref) {
    return livestreamRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LivestreamRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LivestreamRemoteDataSource>(value),
    );
  }
}

String _$livestreamRemoteDataSourceHash() =>
    r'22dd7242e2bb8cc8c13b63009aa096a29bab200f';

/// Firebase datasource

@ProviderFor(livestreamFirebaseDataSource)
final livestreamFirebaseDataSourceProvider =
    LivestreamFirebaseDataSourceProvider._();

/// Firebase datasource

final class LivestreamFirebaseDataSourceProvider
    extends
        $FunctionalProvider<
          LivestreamFirebaseDataSource,
          LivestreamFirebaseDataSource,
          LivestreamFirebaseDataSource
        >
    with $Provider<LivestreamFirebaseDataSource> {
  /// Firebase datasource
  LivestreamFirebaseDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'livestreamFirebaseDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$livestreamFirebaseDataSourceHash();

  @$internal
  @override
  $ProviderElement<LivestreamFirebaseDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LivestreamFirebaseDataSource create(Ref ref) {
    return livestreamFirebaseDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LivestreamFirebaseDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LivestreamFirebaseDataSource>(value),
    );
  }
}

String _$livestreamFirebaseDataSourceHash() =>
    r'd5eaa03641c1e3ff11b8ef542a9829084f13614e';

/// Repository

@ProviderFor(livestreamRepository)
final livestreamRepositoryProvider = LivestreamRepositoryProvider._();

/// Repository

final class LivestreamRepositoryProvider
    extends
        $FunctionalProvider<
          LivestreamRepositoryImpl,
          LivestreamRepositoryImpl,
          LivestreamRepositoryImpl
        >
    with $Provider<LivestreamRepositoryImpl> {
  /// Repository
  LivestreamRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'livestreamRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$livestreamRepositoryHash();

  @$internal
  @override
  $ProviderElement<LivestreamRepositoryImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LivestreamRepositoryImpl create(Ref ref) {
    return livestreamRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LivestreamRepositoryImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LivestreamRepositoryImpl>(value),
    );
  }
}

String _$livestreamRepositoryHash() =>
    r'4588202b80ac37011032387791012bca38dba89a';

/// Interaction repository

@ProviderFor(livestreamInteractionRepository)
final livestreamInteractionRepositoryProvider =
    LivestreamInteractionRepositoryProvider._();

/// Interaction repository

final class LivestreamInteractionRepositoryProvider
    extends
        $FunctionalProvider<
          LivestreamInteractionRepositoryImpl,
          LivestreamInteractionRepositoryImpl,
          LivestreamInteractionRepositoryImpl
        >
    with $Provider<LivestreamInteractionRepositoryImpl> {
  /// Interaction repository
  LivestreamInteractionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'livestreamInteractionRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$livestreamInteractionRepositoryHash();

  @$internal
  @override
  $ProviderElement<LivestreamInteractionRepositoryImpl> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LivestreamInteractionRepositoryImpl create(Ref ref) {
    return livestreamInteractionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LivestreamInteractionRepositoryImpl value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LivestreamInteractionRepositoryImpl>(
        value,
      ),
    );
  }
}

String _$livestreamInteractionRepositoryHash() =>
    r'b974b0749695ea645db7ecb9e302cfa7d1bbb164';

@ProviderFor(getLivestreamsUseCase)
final getLivestreamsUseCaseProvider = GetLivestreamsUseCaseProvider._();

final class GetLivestreamsUseCaseProvider
    extends
        $FunctionalProvider<
          GetLivestreamsUseCase,
          GetLivestreamsUseCase,
          GetLivestreamsUseCase
        >
    with $Provider<GetLivestreamsUseCase> {
  GetLivestreamsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getLivestreamsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getLivestreamsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetLivestreamsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetLivestreamsUseCase create(Ref ref) {
    return getLivestreamsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetLivestreamsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetLivestreamsUseCase>(value),
    );
  }
}

String _$getLivestreamsUseCaseHash() =>
    r'ebf987feb9c7de6e58f88b8c918d82a082a0b08e';

@ProviderFor(getLivestreamByIdUseCase)
final getLivestreamByIdUseCaseProvider = GetLivestreamByIdUseCaseProvider._();

final class GetLivestreamByIdUseCaseProvider
    extends
        $FunctionalProvider<
          GetLivestreamByIdUseCase,
          GetLivestreamByIdUseCase,
          GetLivestreamByIdUseCase
        >
    with $Provider<GetLivestreamByIdUseCase> {
  GetLivestreamByIdUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getLivestreamByIdUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getLivestreamByIdUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetLivestreamByIdUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetLivestreamByIdUseCase create(Ref ref) {
    return getLivestreamByIdUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetLivestreamByIdUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetLivestreamByIdUseCase>(value),
    );
  }
}

String _$getLivestreamByIdUseCaseHash() =>
    r'af82ce57190a42000489c50250877b606bf6cd90';

@ProviderFor(getFeaturedLivestreamsUseCase)
final getFeaturedLivestreamsUseCaseProvider =
    GetFeaturedLivestreamsUseCaseProvider._();

final class GetFeaturedLivestreamsUseCaseProvider
    extends
        $FunctionalProvider<
          GetFeaturedLivestreamsUseCase,
          GetFeaturedLivestreamsUseCase,
          GetFeaturedLivestreamsUseCase
        >
    with $Provider<GetFeaturedLivestreamsUseCase> {
  GetFeaturedLivestreamsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getFeaturedLivestreamsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getFeaturedLivestreamsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetFeaturedLivestreamsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetFeaturedLivestreamsUseCase create(Ref ref) {
    return getFeaturedLivestreamsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetFeaturedLivestreamsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetFeaturedLivestreamsUseCase>(
        value,
      ),
    );
  }
}

String _$getFeaturedLivestreamsUseCaseHash() =>
    r'1ea5bb3484ebcd574e18bb8a26851d7b36b9a2c7';

@ProviderFor(sendCommentUseCase)
final sendCommentUseCaseProvider = SendCommentUseCaseProvider._();

final class SendCommentUseCaseProvider
    extends
        $FunctionalProvider<
          SendCommentUseCase,
          SendCommentUseCase,
          SendCommentUseCase
        >
    with $Provider<SendCommentUseCase> {
  SendCommentUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sendCommentUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sendCommentUseCaseHash();

  @$internal
  @override
  $ProviderElement<SendCommentUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SendCommentUseCase create(Ref ref) {
    return sendCommentUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SendCommentUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SendCommentUseCase>(value),
    );
  }
}

String _$sendCommentUseCaseHash() =>
    r'220280026245c03b960ee8cf98465978d78ae51c';

@ProviderFor(streamCommentsUseCase)
final streamCommentsUseCaseProvider = StreamCommentsUseCaseProvider._();

final class StreamCommentsUseCaseProvider
    extends
        $FunctionalProvider<
          StreamCommentsUseCase,
          StreamCommentsUseCase,
          StreamCommentsUseCase
        >
    with $Provider<StreamCommentsUseCase> {
  StreamCommentsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'streamCommentsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$streamCommentsUseCaseHash();

  @$internal
  @override
  $ProviderElement<StreamCommentsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  StreamCommentsUseCase create(Ref ref) {
    return streamCommentsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StreamCommentsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StreamCommentsUseCase>(value),
    );
  }
}

String _$streamCommentsUseCaseHash() =>
    r'987d4794fab70cbd8c28104ed8c6fdbca641bdb9';

@ProviderFor(sendLikeUseCase)
final sendLikeUseCaseProvider = SendLikeUseCaseProvider._();

final class SendLikeUseCaseProvider
    extends
        $FunctionalProvider<SendLikeUseCase, SendLikeUseCase, SendLikeUseCase>
    with $Provider<SendLikeUseCase> {
  SendLikeUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sendLikeUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sendLikeUseCaseHash();

  @$internal
  @override
  $ProviderElement<SendLikeUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SendLikeUseCase create(Ref ref) {
    return sendLikeUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SendLikeUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SendLikeUseCase>(value),
    );
  }
}

String _$sendLikeUseCaseHash() => r'58c6d213e0cec9ae09e8dbedddaddcfac4ec56c6';

@ProviderFor(streamLikesUseCase)
final streamLikesUseCaseProvider = StreamLikesUseCaseProvider._();

final class StreamLikesUseCaseProvider
    extends
        $FunctionalProvider<
          StreamLikesUseCase,
          StreamLikesUseCase,
          StreamLikesUseCase
        >
    with $Provider<StreamLikesUseCase> {
  StreamLikesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'streamLikesUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$streamLikesUseCaseHash();

  @$internal
  @override
  $ProviderElement<StreamLikesUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  StreamLikesUseCase create(Ref ref) {
    return streamLikesUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StreamLikesUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StreamLikesUseCase>(value),
    );
  }
}

String _$streamLikesUseCaseHash() =>
    r'8f654b71b5324bc6d446737a219dfe99e5b753e2';
