import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/livestream_providers.dart';
import '../widgets/livestream_card_horizontal.dart';

/// Widget hiển thị danh sách livestream theo hàng ngang ở trang Home
class LivestreamHomeSection extends ConsumerStatefulWidget {
  const LivestreamHomeSection({super.key});

  @override
  ConsumerState<LivestreamHomeSection> createState() => _LivestreamHomeSectionState();
}

class _LivestreamHomeSectionState extends ConsumerState<LivestreamHomeSection> {
  @override
  void initState() {
    super.initState();
    // Load featured livestreams when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(livestreamNotifierProvider.notifier).loadFeaturedLivestreams();
    });
  }

  @override
  Widget build(BuildContext context) {
    final livestreamState = ref.watch(livestreamNotifierProvider);

    // Don't show section if no livestreams
    if (livestreamState.livestreams.isEmpty && !livestreamState.isLoading) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        // Section header
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.live_tv, color: Colors.red, size: 24),
                  SizedBox(width: 8.w),
                  Text(
                    'Livestream đang diễn ra',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to all livestreams screen
                  Navigator.pushNamed(context, '/livestreams');
                },
                child: Text(
                  'Xem tất cả',
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 12.w),

        // Horizontal list of livestreams
        SizedBox(
          height: 200.w,
          child: livestreamState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : livestreamState.hasError
                  ? Center(
                      child: Text(
                        'Lỗi: ${livestreamState.errorMessage}',
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: livestreamState.livestreams.length,
                      itemBuilder: (context, index) {
                        final livestream = livestreamState.livestreams[index];
                        return Container(
                          width: 280.w,
                          margin: EdgeInsets.only(
                            right: index < livestreamState.livestreams.length - 1
                                ? 12.w
                                : 0,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              // Navigate to livestream detail
                              Navigator.pushNamed(
                                context,
                                '/livestream-detail',
                                arguments: livestream.id,
                              );
                            },
                            child: LivestreamCardHorizontal(livestream: livestream),
                          ),
                        );
                      },
                    ),
        ),

        SizedBox(height: 24.w),
      ],
    );
  }
}
