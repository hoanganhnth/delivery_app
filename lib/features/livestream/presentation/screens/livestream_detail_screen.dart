import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:delivery_app/features/livestream/presentation/providers/livestream_detail_notifier.dart';
import 'package:delivery_app/features/livestream/presentation/providers/livestream_state.dart'
    show LivestreamDetailState;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/logger/app_logger.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../domain/entities/livestream_comment_entity.dart';
import '../../domain/entities/livestream_entity.dart';
import '../providers/livestream_providers.dart';
import '../services/agora_service.dart';
import '../widgets/livestream_comment_item.dart';
import '../widgets/livestream_like_animation.dart';
import '../widgets/livestream_product_sheet.dart';

/// Màn hình chi tiết livestream với Agora RTC
class LivestreamDetailScreen extends ConsumerStatefulWidget {
  final num livestreamId;

  const LivestreamDetailScreen({super.key, required this.livestreamId});

  @override
  ConsumerState<LivestreamDetailScreen> createState() =>
      _LivestreamDetailScreenState();
}

class _LivestreamDetailScreenState
    extends ConsumerState<LivestreamDetailScreen> {
  // Agora service
  late final AgoraService _agoraService;
  
  // Controllers
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Like animation pool (giới hạn 5 animation cùng lúc)
  final List<int> _likeAnimations = [];
  static const int _maxLikeAnimations = 5;
  
  // Debounce timer cho comment
  Timer? _commentDebounce;
  
  // Subscriptions
  StreamSubscription? _joinSubscription;
  StreamSubscription? _errorSubscription;

  @override
  void initState() {
    super.initState();
    _agoraService = AgoraService();
    _initAgora();
    
    // Auto scroll listener
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Có thể thêm logic lazy load comments cũ hơn
  }

  /// Initialize Agora RTC Engine
  Future<void> _initAgora() async {
    try {
      AppLogger.d('Initializing Agora service for livestream ${widget.livestreamId}');
      
      // Initialize Agora service
      final initialized = await _agoraService.initialize();
      if (!initialized) {
        _showErrorSnackbar('Không thể khởi tạo video player');
        return;
      }

      // Listen to join events
      _joinSubscription = _agoraService.onJoinChannel.listen((joined) {
        if (mounted) {
          setState(() {
            // Update UI if needed
          });
        }
      });

      // Listen to errors
      _errorSubscription = _agoraService.onError.listen((error) {
        if (mounted) {
          _showErrorSnackbar(error.message);
        }
      });

      // Load livestream detail and join channel
      await _loadLivestreamAndJoin();
    } catch (e) {
      AppLogger.e('Failed to initialize Agora', e);
      _showErrorSnackbar('Lỗi khởi tạo livestream');
    }
  }

  /// Load livestream detail and join channel
  Future<void> _loadLivestreamAndJoin() async {
    final detailState = ref.read(
      livestreamDetailNotifierProvider(widget.livestreamId),
    );
    
    if (detailState.livestream == null) {
      // Load from API first
      await ref.read(
        livestreamDetailNotifierProvider(widget.livestreamId).notifier,
      ).loadLivestreamDetail(widget.livestreamId);
      
      // Wait for state update
      await Future.delayed(const Duration(milliseconds: 100));
    }

    final updatedState = ref.read(
      livestreamDetailNotifierProvider(widget.livestreamId),
    );
    
    if (updatedState.livestream != null) {
      await _agoraService.joinChannel(updatedState.livestream!);
    }
  }

  /// Send comment with debounce (tránh spam)
  Future<void> _sendComment() async {
    final message = _commentController.text.trim();
    if (message.isEmpty) return;

    // Cancel previous debounce
    _commentDebounce?.cancel();

    // Debounce 300ms
    _commentDebounce = Timer(const Duration(milliseconds: 300), () async {
      _commentController.clear();
      
      // TODO: Get current user info from auth
      final comment = LivestreamCommentEntity(
        id: const Uuid().v4(),
        livestreamId: widget.livestreamId,
        userId: 'user123', // Replace with actual user ID
        userName: 'User Name', // Replace with actual user name
        userAvatar: null,
        message: message,
        timestamp: DateTime.now(),
      );

      try {
        final notifier = ref.read(
          livestreamInteractionNotifierProvider(widget.livestreamId).notifier,
        );
        await notifier.sendComment(comment);

        // Auto scroll to bottom
        _scrollToBottom();
      } catch (e) {
        AppLogger.e('Failed to send comment', e);
        _showErrorSnackbar('Không thể gửi bình luận');
      }
    });
  }

  /// Send like (optimized with pool limit)
  Future<void> _sendLike() async {
    // Trigger animation first (optimistic UI)
    _triggerLikeAnimation();
    
    final like = LivestreamLikeEntity(
      id: const Uuid().v4(),
      livestreamId: widget.livestreamId,
      userId: 'user123', // Replace with actual user ID
      userName: 'User Name',
      userAvatar: null,
      timestamp: DateTime.now(),
    );

    try {
      final notifier = ref.read(
        livestreamInteractionNotifierProvider(widget.livestreamId).notifier,
      );
      await notifier.sendLike(like);
    } catch (e) {
      AppLogger.e('Failed to send like', e);
      // Silent fail for like (không cần thông báo lỗi)
    }
  }

  /// Trigger like animation with pool limit
  void _triggerLikeAnimation() {
    // Giới hạn số animation đồng thời
    if (_likeAnimations.length >= _maxLikeAnimations) {
      return; // Skip nếu đã đủ animation
    }
    
    final animId = DateTime.now().millisecondsSinceEpoch;
    
    setState(() {
      _likeAnimations.add(animId);
    });

    // Remove animation after 2 seconds
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _likeAnimations.remove(animId);
        });
      }
    });
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;
    
    // Smooth scroll to bottom
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
      livestreamDetailNotifierProvider(widget.livestreamId),
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

  void _showErrorSnackbar(String message) {
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    AppLogger.d('Disposing LivestreamDetailScreen');
    
    // Cancel all timers and subscriptions
    _commentDebounce?.cancel();
    _joinSubscription?.cancel();
    _errorSubscription?.cancel();
    
    // Dispose controllers
    _commentController.dispose();
    _scrollController.dispose();
    
    // Dispose Agora service
    _agoraService.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final detailState = ref.watch(
      livestreamDetailNotifierProvider(widget.livestreamId),
    );
    final interactionState = ref.watch(
      livestreamInteractionNotifierProvider(widget.livestreamId),
    );

    if (detailState.isLoading) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (detailState.hasError || !detailState.hasLivestream) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        body: Center(
          child: Text(
            'Không tìm thấy livestream',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    final livestream = detailState.livestream!;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Video player (Agora RTC)
          _buildVideoView(),

          // Overlay UI
          SafeArea(
            child: Column(
              children: [
                // Top bar
                _buildTopBar(livestream, detailState),

                const Spacer(),

                // Comments section
                _buildCommentsSection(interactionState),

                SizedBox(height: 16.w),

                // Bottom controls
                _buildBottomControls(livestream),
              ],
            ),
          ),

          // Like animations
          ...(_likeAnimations.map(
            (id) => LivestreamLikeAnimation(key: ValueKey(id)),
          )),
        ],
      ),
    );
  }

  /// Build video view (optimized)
  Widget _buildVideoView() {
    if (!_agoraService.isInitialized || !_agoraService.isJoined) {
      return Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(color: Colors.white),
              SizedBox(height: 16.w),
              Text(
                _agoraService.isInitialized 
                  ? 'Đang kết nối livestream...' 
                  : 'Đang khởi tạo...',
                style: TextStyle(color: Colors.white70, fontSize: 14.sp),
              ),
            ],
          ),
        ),
      );
    }

    final engine = _agoraService.engine;
    if (engine == null) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: Icon(Icons.error, color: Colors.red, size: 48),
        ),
      );
    }

    return AgoraVideoView(
      controller: VideoViewController(
        rtcEngine: engine,
        canvas: const VideoCanvas(uid: 0),
      ),
    );
  }

  /// Build top bar
  Widget _buildTopBar(
    LivestreamEntity livestream,
    LivestreamDetailState detailState,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black.withValues(alpha: 0.6), Colors.transparent],
        ),
      ),
      child: Row(
        children: [
          // Back button
          Container(
            decoration: BoxDecoration(
              color: Colors.black38,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),

          SizedBox(width: 12.w),

          // Streamer info
          Expanded(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      livestream.streamerAvatar != null
                          ? NetworkImage(livestream.streamerAvatar!)
                          : null,
                  child:
                      livestream.streamerAvatar == null
                          ? const Icon(Icons.person)
                          : null,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        livestream.streamerName,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.w,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.circle, color: Colors.white, size: 6),
                            SizedBox(width: 4.w),
                            Text(
                              'LIVE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Viewer count
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.visibility, color: Colors.white, size: 16),
                SizedBox(width: 4.w),
                Text(
                  _formatCount(detailState.currentViewerCount),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 8.w),

          // Share button
          Container(
            decoration: BoxDecoration(
              color: Colors.black38,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.share, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  /// Build comments section
  Widget _buildCommentsSection(LivestreamInteractionState interactionState) {
    return Container(
      height: 200.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child:
          interactionState.comments.isEmpty
              ? const SizedBox.shrink()
              : ListView.builder(
                controller: _scrollController,
                itemCount: interactionState.comments.length,
                itemBuilder: (context, index) {
                  final comment = interactionState.comments[index];
                  return LivestreamCommentItem(comment: comment);
                },
              ),
    );
  }

  /// Build bottom controls
  Widget _buildBottomControls(LivestreamEntity livestream) {
    final detailState = ref.watch(
      livestreamDetailNotifierProvider(widget.livestreamId),
    );

    return Container(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          // Comment input
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white24),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Viết bình luận...',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _sendComment(),
                    ),
                  ),
                  IconButton(
                    onPressed: _sendComment,
                    icon: Icon(Icons.send, color: context.colors.primary),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(width: 8.w),

          // Like button
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: _sendLike,
                  icon: Icon(Icons.favorite, color: Colors.red, size: 28),
                ),
              ),
              Text(
                _formatCount(detailState.currentLikeCount),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          SizedBox(width: 8.w),

          // Products button
          if (livestream.products != null && livestream.products!.isNotEmpty)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: _showProductSheet,
                    icon: Icon(
                      Icons.shopping_bag,
                      color: Colors.orange,
                      size: 28,
                    ),
                  ),
                ),
                Text(
                  '${livestream.products!.length}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  /// Format count with memoization
  String _formatCount(int count) {
    if (count >= 1000000) {
      final value = (count / 1000000).toStringAsFixed(1);
      return value.endsWith('.0') ? '${count ~/ 1000000}M' : '${value}M';
    } else if (count >= 1000) {
      final value = (count / 1000).toStringAsFixed(1);
      return value.endsWith('.0') ? '${count ~/ 1000}K' : '${value}K';
    }
    return count.toString();
  }
}

/// Provider for Agora service (singleton per livestream)
final agoraServiceProvider = Provider.family<AgoraService, num>((ref, livestreamId) {
  final service = AgoraService();
  
  // Auto-dispose when provider is removed
  ref.onDispose(() {
    service.dispose();
  });
  
  return service;
});
