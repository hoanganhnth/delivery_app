import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/theme/app_colors.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_notifier.dart';

class ProfileHeader extends ConsumerWidget {
  final AppColors colors;

  const ProfileHeader({
    super.key,
    required this.colors,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);

    return SliverAppBar(
      expandedHeight: 200.h,
      pinned: true,
      backgroundColor: colors.primary,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colors.primaryDark,
                colors.primary,
                colors.primaryLight.withValues(alpha: 0.8),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Avatar with border and shadow
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.5),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 48.r,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    child: profileState.hasUser
                        ? Text(
                            profileState.user!.email
                                .substring(0, 1)
                                .toUpperCase(),
                            style: TextStyle(
                              fontSize: 36.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        : Icon(
                            Icons.person,
                            size: 48.r,
                            color: Colors.white,
                          ),
                  ),
                ),
                SizedBox(height: ResponsiveSize.m),
                // User Name and Email
                if (profileState.hasUser) ...[
                  Text(
                    profileState.user!.fullName ?? 'User',
                    style: TextStyle(
                      fontSize: ResponsiveSize.fontXl,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: ResponsiveSize.xs),
                  Text(
                    profileState.user!.email,
                    style: TextStyle(
                      fontSize: ResponsiveSize.fontM,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
