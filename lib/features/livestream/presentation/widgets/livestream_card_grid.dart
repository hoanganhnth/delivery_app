import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/live_indicator_badge.dart';
import '../../domain/entities/livestream_entity.dart';

/// Card hiển thị livestream trong grid view - Editorial Style
/// Features:
/// - Rounded corners 24px (Stitch design)
/// - Gradient vignette overlay
/// - Animated LIVE badge
/// - Hover scale effect (desktop/web)
class LivestreamCardGrid extends StatefulWidget {
  final LivestreamEntity livestream;

  const LivestreamCardGrid({
    super.key,
    required this.livestream,
  });

  @override
  State<LivestreamCardGrid> createState() => _LivestreamCardGridState();
}

class _LivestreamCardGridState extends State<LivestreamCardGrid> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..scale(_isHovered ? 1.03 : 1.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: _isHovered ? 0.15 : 0.08),
                blurRadius: _isHovered ? 20 : 12,
                offset: Offset(0, _isHovered ? 8 : 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24.r),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Thumbnail
                _buildThumbnail(),

                // Gradient overlay
                _buildGradientOverlay(),

                // LIVE badge
                if (widget.livestream.isLive)
                  Positioned(
                    top: 12.w,
                    left: 12.w,
                    child: const LiveIndicatorBadge(),
                  ),

                // Viewer count
                Positioned(
                  top: 12.w,
                  right: 12.w,
                  child: _buildViewerBadge(theme),
                ),

                // Bottom info
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _buildBottomInfo(theme),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    return CachedNetworkImage(
      imageUrl: widget.livestream.thumbnailUrl ?? 
                widget.livestream.coverImageUrl ?? '',
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: Center(
          child: Icon(
            Icons.live_tv_rounded,
            size: 40.sp,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: Center(
          child: Icon(
            Icons.image_not_supported_rounded,
            size: 40.sp,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.transparent,
            Colors.black.withValues(alpha: 0.7),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
    );
  }

  Widget _buildViewerBadge(ThemeData theme) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.visibility_rounded,
            color: Colors.white,
            size: 12.sp,
          ),
          SizedBox(width: 4.w),
          Text(
            _formatCount(widget.livestream.viewerCount),
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomInfo(ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          Text(
            widget.livestream.title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h),
          // Streamer info
          Row(
            children: [
              // Avatar
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: ClipOval(
                  child: widget.livestream.streamerAvatar != null
                      ? CachedNetworkImage(
                          imageUrl: widget.livestream.streamerAvatar!,
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) => _buildDefaultAvatar(),
                        )
                      : _buildDefaultAvatar(),
                ),
              ),
              SizedBox(width: 8.w),
              // Name
              Expanded(
                child: Text(
                  widget.livestream.streamerName,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Likes
              Icon(
                Icons.favorite_rounded,
                color: theme.colorScheme.error,
                size: 14.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                _formatCount(widget.livestream.likeCount),
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar() {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Icon(
        Icons.person_rounded,
        size: 14.sp,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}
