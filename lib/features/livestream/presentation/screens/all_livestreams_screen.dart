import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:delivery_app/core/routing/routing.dart';
import 'package:delivery_app/core/widgets/amber_widgets.dart';
import '../providers/providers.dart';
import '../widgets/livestream_card_grid.dart';

/// Màn hình hiển thị tất cả livestream - Stitch Editorial Redesign
/// Design: Editorial style với rounded cards, category pills, staggered grid
class AllLivestreamsScreen extends ConsumerStatefulWidget {
  const AllLivestreamsScreen({super.key});

  @override
  ConsumerState<AllLivestreamsScreen> createState() =>
      _AllLivestreamsScreenState();
}

class _AllLivestreamsScreenState extends ConsumerState<AllLivestreamsScreen> {
  final ScrollController _scrollController = ScrollController();
  String _selectedCategory = 'All';

  final List<Map<String, dynamic>> _categoryData = [
    {'icon': Icons.restaurant_menu, 'label': 'All'},
    {'icon': Icons.local_fire_department, 'label': 'Street Food'},
    {'icon': Icons.dining, 'label': 'Fine Dining'},
    {'icon': Icons.cake, 'label': 'Baking'},
    {'icon': Icons.icecream, 'label': 'Desserts'},
    {'icon': Icons.local_cafe, 'label': 'Drinks'},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(livestreamListProvider.notifier).loadLivestreams(refresh: true);
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      final state = ref.read(livestreamListProvider);
      if (!state.isLoading && state.hasMore) {
        ref.read(livestreamListProvider.notifier).loadLivestreams();
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
    final theme = Theme.of(context);
    final livestreamState = ref.watch(livestreamListProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await ref.read(livestreamListProvider.notifier).loadLivestreams(refresh: true);
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Editorial Header
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h),
                  child: EditorialHeader(
                    subtitle: 'LIVE NOW',
                    title: 'Foodie ',
                    titleHighlight: 'Live',
                    description: 'Watch chefs cook in real-time',
                  ),
                ),

                // Category Pills - Horizontal scroll
                SizedBox(
                  height: 100.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: _categoryData.length,
                    separatorBuilder: (_, __) => SizedBox(width: 12.w),
                    itemBuilder: (context, index) {
                      final category = _categoryData[index];
                      final isActive = category['label'] == _selectedCategory;
                      return CategoryPill(
                        icon: category['icon'] as IconData,
                        label: category['label'] as String,
                        isActive: isActive,
                        onTap: () {
                          setState(() {
                            _selectedCategory = category['label'] as String;
                          });
                          // TODO: Filter livestreams by category
                        },
                      );
                    },
                  ),
                ),

                SizedBox(height: 20.h),

                // Content
                _buildContent(context, theme, livestreamState),

                // Bottom padding for navigation
                SizedBox(height: 140.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.5,
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18.sp,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          const Spacer(),
          // Search button
          GestureDetector(
            onTap: () {
              // TODO: Implement search
            },
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.5,
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(
                Icons.search_rounded,
                size: 22.sp,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // Filter button
          GestureDetector(
            onTap: () {
              // TODO: Show filter bottom sheet
            },
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(
                Icons.tune_rounded,
                size: 20.sp,
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ThemeData theme,
    dynamic livestreamState,
  ) {
    // Loading state
    if (livestreamState.isLoading && livestreamState.livestreams.isEmpty) {
      return SizedBox(
        height: 300.h,
        child: Center(
          child: CircularProgressIndicator(color: theme.colorScheme.primary),
        ),
      );
    }

    // Error state
    if (livestreamState.hasError && livestreamState.livestreams.isEmpty) {
      return SizedBox(
        height: 300.h,
        child: _buildErrorState(context, theme, livestreamState.errorMessage),
      );
    }

    // Empty state
    if (livestreamState.livestreams.isEmpty) {
      return SizedBox(
        height: 300.h,
        child: _buildEmptyState(theme),
      );
    }

    // Livestream Grid - Staggered layout
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: MasonryGridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 16.w,
        itemCount:
            livestreamState.livestreams.length +
            (livestreamState.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          // Loading indicator for pagination
          if (index >= livestreamState.livestreams.length) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: CircularProgressIndicator(
                  color: theme.colorScheme.primary,
                  strokeWidth: 2,
                ),
              ),
            );
          }

          final livestream = livestreamState.livestreams[index];
          // Staggered heights: alternate between tall and normal
          final isLarge = index % 3 == 0;

          return GestureDetector(
            onTap: () {
              context.pushNamed(
                'livestream-detail',
                pathParameters: {'id': livestream.id},
              );
            },
            child: SizedBox(
              height: isLarge ? 280.h : 220.h,
              child: LivestreamCardGrid(livestream: livestream),
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    ThemeData theme,
    String? errorMessage,
  ) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: theme.colorScheme.errorContainer.withValues(
                    alpha: 0.3,
                  ),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Icon(
                  Icons.wifi_off_rounded,
                  size: 40.sp,
                  color: theme.colorScheme.error,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Oops! Something went wrong',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                errorMessage ?? 'Unable to load livestreams',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              FilledButton.icon(
                onPressed: () {
                  ref
                      .read(livestreamListProvider.notifier)
                      .loadLivestreams(refresh: true);
                },
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Try Again'),
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withValues(
                  alpha: 0.3,
                ),
                borderRadius: BorderRadius.circular(32.r),
              ),
              child: Icon(
                Icons.live_tv_rounded,
                size: 48.sp,
                color: theme.colorScheme.primary,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'No Livestreams Yet',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Check back later for live cooking sessions',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
