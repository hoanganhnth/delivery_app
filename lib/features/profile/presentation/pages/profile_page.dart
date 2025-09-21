import 'package:delivery_app/core/routing/navigation_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/services/app_initializer_service.dart';
import 'package:delivery_app/features/auth/presentation/providers/auth_providers.dart';
import 'package:delivery_app/features/auth/presentation/providers/auth_state.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../generated/l10n.dart';

// Ví dụ provider user giả định

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileProvider = ref.watch(profileStateProvider);
    final user = profileProvider.user;
    
    // Listen to auth state changes and navigate when logged out
    ref.listen<AuthState>(authStateProvider, (previous, next) {
      if (previous?.isAuthenticated == true && !next.isAuthenticated) {
        // User has just logged out
        context.goToLogin();
        ref.read(appInitializerServiceProvider).clearDataAfterLogout();
      }
    });
    
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).profile),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          // Thông tin người dùng ở trên cùng
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.w),
            color: Colors.orange.withValues(alpha: 0.1),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                SizedBox(width: 16.w),
                if (user != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName ?? "Người dùng",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.w),
                      Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),

          SizedBox(height: 24.w),

          // Các phần khác (ví dụ settings, orders…)
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.orange),
            title: Text(S.of(context).account),
          ),
          ListTile(
            leading: const Icon(Icons.history, color: Colors.orange),
            title: Text(S.of(context).orderHistory),
          ),

          // Address management
          ListTile(
            leading: const Icon(Icons.location_on, color: Colors.orange),
            title: const Text("Địa chỉ của tôi"),
            subtitle: const Text("Quản lý địa chỉ giao hàng"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              context.pushAddressList();
            },
          ),

          // setting 
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.orange),
            title: Text(S.of(context).settings),
            onTap: () {
              context.pushSettings();
            },
          ),

          const Spacer(), // đẩy nút logout xuống cuối

          Padding(
            padding: EdgeInsets.all(16.0.w),
            child: SizedBox(
              width: double.infinity,
              height: 48.w,
              child: ElevatedButton.icon(
                onPressed: () async {
                  // Just call logout, navigation will be handled by the listener
                  await ref.read(authStateProvider.notifier).logout();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                icon: const Icon(Icons.logout, color: Colors.white),
                label: Text(
                  S.of(context).signOut,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
