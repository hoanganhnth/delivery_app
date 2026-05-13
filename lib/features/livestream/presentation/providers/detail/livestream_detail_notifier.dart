import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../domain/entities/livestream_entity.dart';
import '../../../domain/usecases/get_livestreams_usecase.dart';
import '../../../domain/usecases/livestream_interaction_usecases.dart';
import '../di/livestream_di_providers.dart';
import 'livestream_detail_state.dart';

part 'livestream_detail_notifier.g.dart';

/// Livestream detail notifier — manages livestream metadata
@riverpod
class LivestreamDetail extends _$LivestreamDetail {
  StreamSubscription? _likesSubscription;
  StreamSubscription? _metadataSubscription;

  @override
  LivestreamDetailState build(String id) {
    ref.onDispose(() {
      _likesSubscription?.cancel();
      _metadataSubscription?.cancel();
    });

    return const LivestreamDetailState();
  }

  /// Load livestream detail
  Future<void> loadLivestreamDetail(String id) async {
    state = state.copyWith(isLoading: true, clearFailure: true);

    final getLivestreamByIdUseCase = ref.read(getLivestreamByIdUseCaseProvider);
    final result = await getLivestreamByIdUseCase(
      GetLivestreamByIdParams(id: id),
    );
    if (!ref.mounted) return;

    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (livestream) {
        state = state.copyWith(
          isLoading: false,
          livestream: livestream,
          currentViewerCount: livestream.viewerCount,
          currentLikeCount: livestream.likeCount,
        );
        
        // Fetch full product list explicitly
        _fetchFullProducts(id, livestream);

        // Start streaming likes for count updates
        _startStreamingLikes(id);
        // Start streaming metadata for realtime product updates
        _startStreamingMetadata(id);
      },
    );
  }

  Future<void> _fetchFullProducts(String id, LivestreamEntity livestream) async {
    try {
      final repository = ref.read(livestreamRepositoryProvider);
      final result = await repository.getLivestreamProducts(id);
      
      if (!ref.mounted) return;
      
      result.fold(
        (failure) {}, // Ignore error, keep initial products
        (products) {
          if (!ref.mounted) return;
          final currentLivestream = state.livestream ?? livestream;
          state = state.copyWith(
            livestream: currentLivestream.copyWith(products: products),
          );
        },
      );
    } catch (e) {
      // Ignore
    }
  }

  /// Stream likes from Firebase for count updates
  void _startStreamingLikes(String livestreamId) {
    _likesSubscription?.cancel();

    final streamLikesUseCase = ref.read(streamLikesUseCaseProvider);
    final likesStream = streamLikesUseCase(
      StreamLikesParams(livestreamId: livestreamId),
    );

    _likesSubscription = likesStream.listen((either) {
      either.fold((failure) {}, (likes) {
        if (!ref.mounted) return;
        state = state.copyWith(currentLikeCount: likes.length);
      });
    });
  }

  /// Stream metadata from Firebase for realtime product pin/unpin updates
  void _startStreamingMetadata(String livestreamId) {
    _metadataSubscription?.cancel();

    final docRef = FirebaseFirestore.instance
        .collection('livestreams_metadata')
        .doc(livestreamId);

    _metadataSubscription = docRef.snapshots().listen((snapshot) {
      if (!ref.mounted) return;
      if (!snapshot.exists) return;

      final data = snapshot.data();
      if (data == null) return;

      final currentLivestream = state.livestream;
      if (currentLivestream == null) return;

      // Parse pinned product from Firebase metadata
      final pinnedProductData = data['pinnedProduct'] as Map<String, dynamic>?;
      if (pinnedProductData != null) {
        final isPinned = pinnedProductData['isPinned'] as bool? ?? false;
        final productId = pinnedProductData['productId'] as num?;
        final productName = pinnedProductData['productName'] as String? ?? '';
        final price = (pinnedProductData['price'] as num?)?.toDouble() ?? 0.0;
        final image = pinnedProductData['image'] as String? ?? '';

        if (isPinned && productId != null) {
          // Update existing products or add the pinned product
          final existingProducts = currentLivestream.products?.toList() ?? [];

          // Reset all pins first
          final updatedProducts = existingProducts.map((p) {
            return p.copyWith(isPinned: p.id == productId);
          }).toList();

          // If product doesn't exist in list, add it
          final exists = updatedProducts.any((p) => p.id == productId);
          if (!exists) {
            updatedProducts.add(
              LivestreamProductEntity(
                id: productId,
                name: productName,
                price: price,
                image: image,
                restaurantId: 0,
                restaurantName: '',
                isPinned: true,
              ),
            );
          }

          state = state.copyWith(
            livestream: currentLivestream.copyWith(products: updatedProducts),
          );
        } else {
          // Unpin all products
          final updatedProducts = currentLivestream.products
              ?.map((p) => p.copyWith(isPinned: false))
              .toList();
          state = state.copyWith(
            livestream: currentLivestream.copyWith(products: updatedProducts),
          );
        }
        
        // Re-fetch full products list from backend to ensure perfect sync (additions/deletions)
        _fetchFullProducts(livestreamId, currentLivestream);
      }
    });
  }

  /// Update viewer count
  void updateViewerCount(int count) {
    state = state.copyWith(currentViewerCount: count);
  }
}
