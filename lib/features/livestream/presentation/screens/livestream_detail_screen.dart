import 'dart:async';
import 'package:delivery_app/features/livestream/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/logger/app_logger.dart';
import '../../domain/entities/livestream_comment_entity.dart';
import '../services/agora_service.dart';
import '../widgets/livestream_like_animation.dart';
import '../widgets/livestream_product_sheet.dart';
import '../widgets/livestream_video_view.dart';
import '../widgets/livestream_top_bar.dart';
import '../widgets/livestream_bottom_controls.dart';
import '../widgets/livestream_comments_list.dart';

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

  // Remote user UID (streamer) cho video rendering
  int? _remoteUid;
  
  // Subscriptions
  StreamSubscription? _joinSubscription;
  StreamSubscription? _errorSubscription;
  StreamSubscription? _remoteUidSubscription;

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
          setState(() {});
        }
      });

      // Listen to errors
      _errorSubscription = _agoraService.onError.listen((error) {
        if (mounted) {
          _showErrorSnackbar(error.message);
        }
      });

      // Listen to remote user (streamer) joined/left
      _remoteUidSubscription = _agoraService.onRemoteUserChanged.listen((uid) {
        if (mounted) {
          setState(() {
            _remoteUid = uid;
          });
        }
      });

      // Load livestream detail and join channel
      await _loadLivestreamAndJoin();
    } catch (e) {
      AppLogger.e('Failed to initialize Agora', e);
      _showErrorSnackbar('Lỗi khởi tạo livestream');
    }
  }

  /// Load livestream detail and join Agora channel via backend API
  Future<void> _loadLivestreamAndJoin() async {
    // 1. Load livestream detail first
    final detailState = ref.read(
      livestreamDetailProvider(widget.livestreamId),
    );
    
    if (detailState.livestream == null) {
      await ref.read(
        livestreamDetailProvider(widget.livestreamId).notifier,
      ).loadLivestreamDetail(widget.livestreamId);
      
      await Future.delayed(const Duration(milliseconds: 100));
    }

    // 2. Call join API to get Agora token
    final repository = ref.read(livestreamRepositoryProvider);
    final joinResult = await repository.joinLivestream(widget.livestreamId);
    
    joinResult.fold(
      (failure) {
        _showErrorSnackbar('Không thể tham gia livestream: ${failure.message}');
      },
      (joinData) async {
        // 3. Join Agora channel with token from backend
        await _agoraService.joinChannel(
          token: joinData.token,
          channelName: joinData.channelName,
          uid: joinData.uid,
        );

        // 4. Update viewer count if available
        if (joinData.currentViewers != null) {
          ref.read(
            livestreamDetailProvider(widget.livestreamId).notifier,
          ).updateViewerCount(joinData.currentViewers!);
        }
      },
    );
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
          livestreamInteractionProvider(widget.livestreamId).notifier,
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
        livestreamInteractionProvider(widget.livestreamId).notifier,
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
    _remoteUidSubscription?.cancel();
    
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
      livestreamDetailProvider(widget.livestreamId),
    );
    final interactionState = ref.watch(
      livestreamInteractionProvider(widget.livestreamId),
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
          LivestreamVideoView(
            agoraService: _agoraService,
            remoteUid: _remoteUid,
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

          // Like animations
          ...(_likeAnimations.map(
            (id) => LivestreamLikeAnimation(key: ValueKey(id)),
          )),
        ],
      ),
    );
  }

  /// ---
  /// Helpers extracted to widget files
  /// ---
}
