// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../routing/guard_manager.dart';
// import '../../routing/app_routes.dart';

// /// Demo widget showing how to use GuardManager for UI logic
// class GuardDemoWidget extends ConsumerWidget {
//   const GuardDemoWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final guardManager = ref.watch(guardManagerProvider);
//     final userRole = guardManager.getUserRole();

//     return Card(
//       margin: const EdgeInsets.all(16),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'GuardManager Demo',
//               style: Theme.of(
//                 context,
//               ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),

//             // User Role Display
//             _buildRoleInfo(context, userRole),

//             const SizedBox(height: 16),

//             // Route Access Check
//             Text(
//               'Route Access:',
//               style: Theme.of(context).textTheme.titleMedium,
//             ),
//             const SizedBox(height: 8),

//             _buildRouteAccess(context, guardManager, AppRoutes.home, 'Home'),
//             _buildRouteAccess(
//               context,
//               guardManager,
//               AppRoutes.admin,
//               'Admin Panel',
//             ),
//             _buildRouteAccess(
//               context,
//               guardManager,
//               AppRoutes.profile,
//               'Profile',
//             ),
//             _buildRouteAccess(context, guardManager, AppRoutes.login, 'Login'),

//             const SizedBox(height: 16),

//             // Onboarding Status
//             _buildOnboardingStatus(context, guardManager),

//             const SizedBox(height: 16),

//             // Role-based UI
//             _buildRoleBasedUI(context, userRole),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildRoleInfo(BuildContext context, UserRole userRole) {
//     Color roleColor;
//     IconData roleIcon;
//     String roleText;

//     switch (userRole) {
//       case UserRole.guest:
//         roleColor = Colors.grey;
//         roleIcon = Icons.person_outline;
//         roleText = 'Guest User';
//         break;
//       case UserRole.regular:
//         roleColor = Colors.blue;
//         roleIcon = Icons.person;
//         roleText = 'Regular User';
//         break;
//       case UserRole.premium:
//         roleColor = Colors.purple;
//         roleIcon = Icons.star;
//         roleText = 'Premium User';
//         break;
//       case UserRole.admin:
//         roleColor = Colors.red;
//         roleIcon = Icons.admin_panel_settings;
//         roleText = 'Admin User';
//         break;
//     }

//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: roleColor.withValues(alpha: 0.1),
//         border: Border.all(color: roleColor.withValues(alpha: 0.3)),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           Icon(roleIcon, color: roleColor),
//           const SizedBox(width: 8),
//           Text(
//             'Current Role: $roleText',
//             style: TextStyle(color: roleColor, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildRouteAccess(
//     BuildContext context,
//     GuardManager guardManager,
//     String route,
//     String routeName,
//   ) {
//     final canAccess = guardManager.canAccessRoute(route);

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         children: [
//           Icon(
//             canAccess ? Icons.check_circle : Icons.cancel,
//             color: canAccess ? Colors.green : Colors.red,
//             size: 16,
//           ),
//           const SizedBox(width: 8),
//           Text('$routeName: '),
//           Text(
//             canAccess ? 'Accessible' : 'Restricted',
//             style: TextStyle(
//               color: canAccess ? Colors.green : Colors.red,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildOnboardingStatus(
//     BuildContext context,
//     GuardManager guardManager,
//   ) {
//     // final hasCompleted = guardManager.hasCompletedOnboarding();
//     final hasCompleted = true; // Placeholder until onboarding logic is implemented

//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: hasCompleted
//             ? Colors.green.withValues(alpha: 0.1)
//             : Colors.orange.withValues(alpha: 0.1),
//         border: Border.all(
//           color: hasCompleted
//               ? Colors.green.withValues(alpha: 0.3)
//               : Colors.orange.withValues(alpha: 0.3),
//         ),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           Icon(
//             hasCompleted ? Icons.check_circle : Icons.warning,
//             color: hasCompleted ? Colors.green : Colors.orange,
//           ),
//           const SizedBox(width: 8),
//           Text(
//             hasCompleted ? 'Onboarding Completed' : 'Onboarding Pending',
//             style: TextStyle(
//               color: hasCompleted ? Colors.green : Colors.orange,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildRoleBasedUI(BuildContext context, UserRole userRole) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Role-based Features:',
//           style: Theme.of(context).textTheme.titleMedium,
//         ),
//         const SizedBox(height: 8),

//         // Features available to all authenticated users
//         if (userRole.isAuthenticated) ...[
//           _buildFeatureItem(Icons.shopping_cart, 'Shopping Cart', Colors.blue),
//           _buildFeatureItem(Icons.receipt, 'Order History', Colors.blue),
//         ],

//         // Premium features
//         if (userRole.canAccessPremium) ...[
//           _buildFeatureItem(Icons.star, 'Premium Features', Colors.purple),
//           _buildFeatureItem(
//             Icons.priority_high,
//             'Priority Support',
//             Colors.purple,
//           ),
//         ],

//         // Admin features
//         if (userRole.canAccessAdmin) ...[
//           _buildFeatureItem(
//             Icons.admin_panel_settings,
//             'Admin Panel',
//             Colors.red,
//           ),
//           _buildFeatureItem(Icons.analytics, 'Analytics Dashboard', Colors.red),
//         ],

//         // Guest message
//         if (userRole.isGuest) ...[
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.grey.withValues(alpha: 0.1),
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: const Text(
//               'Please log in to access more features',
//               style: TextStyle(fontStyle: FontStyle.italic),
//             ),
//           ),
//         ],
//       ],
//     );
//   }

//   Widget _buildFeatureItem(IconData icon, String title, Color color) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         children: [
//           Icon(icon, color: color, size: 16),
//           const SizedBox(width: 8),
//           Text(title, style: TextStyle(color: color)),
//         ],
//       ),
//     );
//   }
// }
