import 'package:delivery_app/core/routing/routing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/services/app_initializer/_riverpod/app_initializer_provider.dart';
import 'package:delivery_app/features/auth/presentation/providers/providers.dart';
import 'package:delivery_app/features/profile/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';

// Ví dụ provider user giả định

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);
    final user = profileState.user;

    // Listen to auth state changes and navigate when logged out
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (previous?.isAuthenticated == true && !next.isAuthenticated) {
        context.goToLogin();
        ref.read(appInitializerServiceProvider).cleanup();
      }
    });

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Top App Bar
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 16.w, 24.w, 12.w),
              child: Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: ref.colors.primary, width: 2),
                      image: const DecorationImage(
                        image: NetworkImage('https://images.unsplash.com/photo-1583394838336-acd977736f90?w=100'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Amber Hearth',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      letterSpacing: -0.5,
                      color: ref.colors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.search_rounded, color: ref.colors.textPrimary),
                ],
              ),
            ),

            SizedBox(height: 32.h),

            // Profile Info
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 120.w,
                  height: 120.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: ref.colors.primary.withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                      image: const DecorationImage(
                      image: NetworkImage('https://images.unsplash.com/photo-1583394838336-acd977736f90?w=400'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -4,
                  right: -4,
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: ref.colors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3.w),
                      boxShadow: [
                        BoxShadow(
                          color: ref.colors.primary.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(Icons.edit_rounded, color: Colors.white, size: 16.w),
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),
            Text(
              user?.fullName ?? "Chef Amber",
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w800,
                color: ref.colors.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              user?.email ?? "chef@amberhearth.com",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF9C7A49),
              ),
            ),

            SizedBox(height: 32.h),

            // Stats Board
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.w),
              padding: EdgeInsets.symmetric(vertical: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: ref.colors.textSecondary.withValues(alpha: 0.1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(child: _buildStatItem('24', 'ORDERS', ref)),
                  Container(
                    width: 1,
                    height: 32.h,
                    color: ref.colors.textSecondary.withValues(alpha: 0.1),
                  ),
                  Expanded(child: _buildStatItem('12', 'REVIEWS', ref)),
                  Container(
                    width: 1,
                    height: 32.h,
                    color: ref.colors.textSecondary.withValues(alpha: 0.1),
                  ),
                  Expanded(child: _buildStatItem('4.9', 'RATING', ref)),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Actions List
            _buildActionLink(
              context,
              ref: ref,
              title: "Account Info",
              icon: Icons.person_outline_rounded,
              bgColor: const Color(0xFFFFEDD5),
              iconColor: const Color(0xFF9C7A49),
              onTap: () {},
            ),
            _buildActionLink(
              context,
              ref: ref,
              title: "Order History",
              icon: Icons.receipt_long_rounded,
              bgColor: const Color(0xFFFFE0B2),
              iconColor: const Color(0xFFE65100),
              onTap: () => context.pushOrders(),
            ),
            _buildActionLink(
              context,
              ref: ref,
              title: "Addresses",
              icon: Icons.location_on_outlined,
              bgColor: const Color(0xFFFFFBEB),
              iconColor: const Color(0xFFFBC02D),
              onTap: () => context.pushAddressList(),
            ),
            _buildActionLink(
              context,
              ref: ref,
              title: "Customer Support",
              icon: Icons.headset_mic_outlined,
              bgColor: const Color(0xFFF5F5F4),
              iconColor: const Color(0xFF78716C),
              onTap: () => context.pushSupport(),
            ),
            _buildActionLink(
              context,
              ref: ref,
              title: "Settings",
              icon: Icons.settings_outlined,
              bgColor: const Color(0xFFF5F5F4),
              iconColor: const Color(0xFF78716C),
              onTap: () => context.pushSettings(),
            ),

            SizedBox(height: 16.h),

            // Logout Button
            GestureDetector(
              onTap: () async {
                await ref.read(authProvider.notifier).logout();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.w),
                padding: EdgeInsets.symmetric(vertical: 20.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFBA1A1A).withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout_rounded, color: const Color(0xFFBA1A1A), size: 18.w),
                    SizedBox(width: 8.w),
                    Text(
                      'LOGOUT',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: const Color(0xFFBA1A1A),
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 120.h), // Safe bottom spacing
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label, WidgetRef ref) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w800,
            color: ref.colors.textPrimary,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF9C7A49),
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }

  Widget _buildActionLink(
    BuildContext context, {
    required WidgetRef ref,
    required String title,
    required IconData icon,
    required Color bgColor,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 6.w),
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(icon, color: iconColor),
            ),
            SizedBox(width: 16.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: ref.colors.textPrimary,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16.w,
              color: ref.colors.textSecondary.withValues(alpha: 0.3),
            ),
          ],
        ),
      ),
    );
  }
}
