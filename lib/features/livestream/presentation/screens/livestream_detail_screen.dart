import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/logger/app_logger.dart';
import '../../domain/entities/livestream_comment_entity.dart';
import '../providers/providers.dart';
import '../widgets/livestream_bottom_controls.dart';
import '../widgets/livestream_comments_list.dart';
import '../widgets/livestream_like_animation.dart';
import '../widgets/livestream_product_sheet.dart';
import '../widgets/livestream_top_bar.dart';
import '../widgets/livestream_video_view.dart';

/// Màn hình chi tiết livestream — UI thuần, logic do Riverpod quản lý
class LivestreamDetailScreen extends ConsumerWidget {
  final num livestreamId;

  const LivestreamDetailScreen({super.key, required this.livestreamId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewerState = ref.watch(livestreamViewerProvider(livestreamId));

    return Scaffold(
      backgroundColor: Colors.black,
      body: switch (viewerState) {
        LivestreamViewerIdle() || LivestreamViewerConnecting() =>
          const Center(child: CircularProgressIndicator(color: Colors.white)),
        LivestreamViewerError(:final message) => _LivestreamErrorView(
            message: message,
            onRetry: () => ref
                .read(livestreamViewerProvider(livestreamId).notifier)
                .joinLivestream(),
            onBack: () => Navigator.pop(context),
          ),
        LivestreamViewerWatching(:final channelName, :final remoteUid) =>
          _LivestreamWatchingView(
            livestreamId: livestreamId,
            channelName: channelName,
            remoteUid: remoteUid,
          ),
        LivestreamViewerDisconnected() => _LivestreamErrorView(
            message: 'Livestream đã kết thúc',
            onRetry: null,
            onBack: () => Navigator.pop(context),
          ),
      },
    );
  }
}

/// Error / Disconnected view
class _LivestreamErrorView extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final VoidCallback onBack;

  const _LivestreamErrorView({
    required this.message,
    this.onRetry,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
          ),
          const Spacer(),
          Icon(Icons.error_outline, color: Colors.red, size: 48.sp),
          SizedBox(height: 16.h),
          Text(
            message,
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Thử lại'),
            ),
          ],
          const Spacer(),
        ],
      ),
    );
  }
}

/// Watching view — contains ephemeral UI state (controllers, like animations)
/// This is StatefulWidget because TextEditingController & ScrollController
/// are ephemeral local state (SKILL anti-pattern rule #129)
class _LivestreamWatchingView extends ConsumerStatefulWidget {
  final num livestreamId;
  final String channelName;
  final int? remoteUid;

  const _LivestreamWatchingView({
    required this.livestreamId,
    required this.channelName,
    this.remoteUid,
  });

  @override
  ConsumerState<_LivestreamWatchingView> createState() =>
      _LivestreamWatchingViewState();
}

class _LivestreamWatchingViewState
    extends ConsumerState<_LivestreamWatchingView> {
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Like animation pool — ephemeral local UI state
  final List<int> _likeAnimations = [];
  static const int _maxLikeAnimations = 5;
  Timer? _commentDebounce;

  @override
  void dispose() {
    _commentDebounce?.cancel();
    _commentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendComment() {
    final message = _commentController.text.trim();
    if (message.isEmpty) return;

    _commentDebounce?.cancel();
    _commentDebounce = Timer(const Duration(milliseconds: 300), () async {
      _commentController.clear();

      // TODO: Get current user info from auth provider
      final comment = LivestreamCommentEntity(
        id: const Uuid().v4(),
        livestreamId: widget.livestreamId,
        userId: 'user123',
        userName: 'User Name',
        userAvatar: null,
        message: message,
        timestamp: DateTime.now(),
      );

      try {
        await ref
            .read(
                livestreamInteractionProvider(widget.livestreamId).notifier)
            .sendComment(comment);
        _scrollToBottom();
      } catch (e) {
        AppLogger.e('Failed to send comment', e);
      }
    });
  }

  void _sendLike() {
    _triggerLikeAnimation();

    final like = LivestreamLikeEntity(
      id: const Uuid().v4(),
      livestreamId: widget.livestreamId,
      userId: 'user123',
      userName: 'User Name',
      userAvatar: null,
      timestamp: DateTime.now(),
    );

    ref
        .read(livestreamInteractionProvider(widget.livestreamId).notifier)
        .sendLike(like);
  }

  void _triggerLikeAnimation() {
    if (_likeAnimations.length >= _maxLikeAnimations) return;

    final animId = DateTime.now().millisecondsSinceEpoch;
    setState(() => _likeAnimations.add(animId));

    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _likeAnimations.remove(animId));
      }
    });
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showProductSheet() {
    final detailState = ref.read(
      livestreamDetailProvider(widget.livestreamId),
    );
    if (detailState.livestream?.products == null ||
        detailState.livestream!.products!.isEmpty) {
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: true,
      builder: (context) => LivestreamProductSheet(
        products: detailState.livestream!.products!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final detailState = ref.watch(
      livestreamDetailProvider(widget.livestreamId),
    );
    final interactionState = ref.watch(
      livestreamInteractionProvider(widget.livestreamId),
    );

    // Get agora service from provider for video view
    final agoraService =
        ref.watch(agoraServiceForViewerProvider(widget.livestreamId));

    final livestream = detailState.livestream;
    if (livestream == null) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    return Stack(
      children: [
        // Video player (Agora RTC)
        LivestreamVideoView(
          agoraService: agoraService,
          remoteUid: widget.remoteUid,
        ),

        // Overlay UI
        SafeArea(
          child: Column(
            children: [
              // Top bar
              LivestreamTopBar(
                livestream: livestream,
                viewerCount: detailState.currentViewerCount,
                onBack: () => Navigator.pop(context),
              ),

              const Spacer(),

              // Comments section
              LivestreamCommentsList(
                interactionState: interactionState,
                scrollController: _scrollController,
              ),

              SizedBox(height: 16.w),

              // Bottom controls
              LivestreamBottomControls(
                livestream: livestream,
                likeCount: detailState.currentLikeCount,
                commentController: _commentController,
                onSendComment: _sendComment,
                onSendLike: _sendLike,
                onShowProducts: _showProductSheet,
              ),
            ],
          ),
        ),

        // Like animations — isolated with RepaintBoundary
        RepaintBoundary(
          child: Stack(
            children: _likeAnimations
                .map((id) => LivestreamLikeAnimation(key: ValueKey(id)))
                .toList(),
          ),
        ),
      ],
    );
  }
}
