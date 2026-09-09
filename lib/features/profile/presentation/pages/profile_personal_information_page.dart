import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:delivery_app/core/design_system/components/preview_bottom_navigation.dart';
import 'package:delivery_app/core/routing/routing.dart';

import '../../application/profile_view_model.dart';
import '../../application/profile_intent.dart';
import '../views/profile_personal_information_view.dart';

class ProfilePersonalInformationPage extends ConsumerStatefulWidget {
  const ProfilePersonalInformationPage({super.key, this.previewMode = false});

  final bool previewMode;

  @override
  ConsumerState<ProfilePersonalInformationPage> createState() =>
      _ProfilePersonalInformationPageState();
}

class _ProfilePersonalInformationPageState
    extends ConsumerState<ProfilePersonalInformationPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final state = ref.read(profileViewModelProvider);
      if (!state.data.hasUser && !state.isLoading) _refresh();
    });
  }

  Future<void> _refresh() => ref
      .read(profileViewModelProvider.notifier)
      .dispatch(const ProfileRefreshRequested());

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileViewModelProvider);
    return ProfilePersonalInformationView(
      data: state.data,
      isLoading: state.isLoading,
      errorMessage: state.errorMessage,
      onRetry: state.isLoading ? null : _refresh,
      previewMode: widget.previewMode,
      onBack: widget.previewMode
          ? () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go(AppRoutes.profile);
              }
            }
          : null,
      onCart: widget.previewMode ? () => context.go(AppRoutes.cart) : null,
      bottomNavigationBar: widget.previewMode
          ? PreviewBottomNavigation(
              currentIndex: 3,
              onTap: (index) {
                switch (index) {
                  case 0:
                    context.go(AppRoutes.main);
                  case 1:
                    context.go(AppRoutes.orders);
                  case 2:
                    context.go(AppRoutes.cart);
                  case 3:
                    context.go(AppRoutes.profile);
                }
              },
            )
          : null,
    );
  }
}
