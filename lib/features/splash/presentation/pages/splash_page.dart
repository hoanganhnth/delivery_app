import 'dart:async';

import 'package:delivery_app/core/routing/constants/app_routes.dart';
import 'package:delivery_app/features/splash/application/splash_effect.dart';
import 'package:delivery_app/features/splash/application/splash_intent.dart';
import 'package:delivery_app/features/splash/application/splash_state.dart';
import 'package:delivery_app/features/splash/application/splash_view_model.dart';
import 'package:delivery_app/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        unawaited(
          ref
              .read(splashViewModelProvider.notifier)
              .dispatch(const SplashStartRequested()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<SplashViewState>(splashViewModelProvider, (previous, next) {
      final handledIds = {
        for (final envelope in previous?.effects ?? const []) envelope.id,
      };
      for (final envelope in next.effects) {
        if (!handledIds.contains(envelope.id)) {
          unawaited(_handleEffect(envelope.id, envelope.effect));
        }
      }
    });
    return SplashView(
      state: ref.watch(splashViewModelProvider),
      onIntent: (intent) => unawaited(
        ref.read(splashViewModelProvider.notifier).dispatch(intent),
      ),
    );
  }

  Future<void> _handleEffect(int effectId, SplashEffect effect) async {
    if (!mounted) return;
    switch (effect) {
      case SplashNavigateToMain():
        context.go(AppRoutes.main);
      case SplashNavigateToLogin():
        context.go(AppRoutes.login);
    }
    if (mounted) {
      await ref
          .read(splashViewModelProvider.notifier)
          .dispatch(SplashEffectConsumed(effectId));
    }
  }
}
