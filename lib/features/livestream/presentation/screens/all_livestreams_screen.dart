import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/livestream_providers.dart';
import '../widgets/livestream_card_grid.dart';

/// Màn hình hiển thị tất cả livestream theo grid 2 cột
class AllLivestreamsScreen extends ConsumerStatefulWidget {
  const AllLivestreamsScreen({super.key});

  @override
  ConsumerState<AllLivestreamsScreen> createState() => _AllLivestreamsScreenState();
}

class _AllLivestreamsScreenState extends ConsumerState<AllLivestreamsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Load livestreams when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(livestreamNotifierProvider.notifier).loadLivestreams(refresh: true);
    });

    // Setup infinite scroll
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.8) {
      final state = ref.read(livestreamNotifierProvider);
      if (!state.isLoading && state.hasMore) {
        ref.read(livestreamNotifierProvider.notifier).loadLivestreams();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final livestreamState = ref.watch(livestreamNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Tất cả Livestream',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Implement search
            },
            icon: const Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(livestreamNotifierProvider.notifier).loadLivestreams(refresh: true);
        },
        child: livestreamState.isLoading && livestreamState.livestreams.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : livestreamState.hasError && livestreamState.livestreams.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 60, color: Colors.grey),
                        SizedBox(height: 16.w),
                        Text(
                          'Lỗi: ${livestreamState.errorMessage}',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 16.w),
                        ElevatedButton(
                          onPressed: () {
                            ref.read(livestreamNotifierProvider.notifier).loadLivestreams(refresh: true);
                          },
                          child: const Text('Thử lại'),
                        ),
                      ],
                    ),
                  )
                : livestreamState.livestreams.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.live_tv_outlined, size: 80, color: Colors.grey),
                            SizedBox(height: 16.w),
                            Text(
                              'Chưa có livestream nào',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.all(16.w),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 12.w,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: livestreamState.livestreams.length + (livestreamState.hasMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index >= livestreamState.livestreams.length) {
                            // Loading indicator for pagination
                            return const Center(child: CircularProgressIndicator());
                          }

                          final livestream = livestreamState.livestreams[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/livestream-detail',
                                arguments: livestream.id,
                              );
                            },
                            child: LivestreamCardGrid(livestream: livestream),
                          );
                        },
                      ),
      ),
    );
  }
}
