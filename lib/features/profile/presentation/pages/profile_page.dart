import 'package:delivery_app/core/routing/navigation_helper.dart';
import 'package:delivery_app/core/services/app_initializer_service.dart';
import 'package:delivery_app/features/auth/presentation/providers/auth_providers.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Ví dụ provider user giả định

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileProvider = ref.watch(profileStateProvider);
    final user = profileProvider.user;
    return Scaffold(  
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          // Thông tin người dùng ở trên cùng
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            color: Colors.orange.withValues( alpha: 0.1),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                const SizedBox(width: 16),
                if (user != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName ?? "Người dùng",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Các phần khác (ví dụ settings, orders…)
          const ListTile(
            leading: Icon(Icons.settings, color: Colors.orange),
            title: Text("Cài đặt tài khoản"),
          ),
          const ListTile(
            leading: Icon(Icons.history, color: Colors.orange),
            title: Text("Lịch sử đơn hàng"),
          ),

          const Spacer(), // đẩy nút logout xuống cuối

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  ref.read(authStateProvider.notifier).logout();
                  context.goToLogin();
                ref.read(appInitializerServiceProvider).clearDataAfterLogout();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  "Đăng xuất",
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
