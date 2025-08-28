import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

/// Profile Screen
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (authState.hasUser) ...[
              CircleAvatar(
                radius: 50,
                child: Text(
                  authState.user!.email.substring(0, 1).toUpperCase(),
                  style: const TextStyle(fontSize: 32),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                authState.user!.email,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              if (authState.user!.name != null) ...[
                const SizedBox(height: 8),
                Text(
                  authState.user!.name!,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
              const SizedBox(height: 32),
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
