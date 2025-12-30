import 'package:delivery_app/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/features/profile/presentation/providers/profile_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Profile Screen
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileStateProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          children: [
            if (profileState.hasUser) ...[
              CircleAvatar(
                radius: 50,
                child: Text(
                  profileState.user!.email.substring(0, 1).toUpperCase(),
                  style: TextStyle(fontSize: 32.sp),
                ),
              ),
              SizedBox(height: 16.w),
              Text(
                profileState.user!.email,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              if (profileState.user!.fullName != null) ...[
                SizedBox(height: 8.w),
                Text(
                  profileState.user!.fullName!,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
              SizedBox(height: 32.w),
              ListTile(
                leading: const Icon(Icons.support_agent),
                title: const Text('Hỗ trợ khách hàng'),
                subtitle: const Text('Chat với CSKH'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to support chat
                  context.go('/support-chat');
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit Profile'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to edit profile
                },
              ),
              ListTile(
                leading: const Icon(Icons.security),
                title: const Text('Change Password'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to change password
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () async {
                  final authNotifier = ref.read(authStateProvider.notifier);
                  await authNotifier.logout();
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
