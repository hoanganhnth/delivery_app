import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 64, color: Colors.orange),
            SizedBox(height: 16),
            Text(
              'Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Manage your account',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Consumer(
              builder: (context, ref, child) {
                // You can use ref to watch providers and build UI accordingly
                // final user = ref.watch(user)
                return Text(
                  'Additional profile info here',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
