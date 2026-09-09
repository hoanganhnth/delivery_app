import 'package:flutter/material.dart';
import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/generated/l10n.dart';

import '../../application/profile_intent.dart';
import '../../application/profile_view_state.dart';
import '../components/profile_preview_components.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({
    super.key,
    required this.state,
    required this.onIntent,
    this.previewMode = false,
    this.bottomNavigationBar,
    this.onBack,
    this.onCart,
    this.cartItemCount = 0,
  });

  final ProfileViewState state;
  final ValueChanged<ProfileIntent> onIntent;
  final bool previewMode;
  final Widget? bottomNavigationBar;
  final VoidCallback? onBack;
  final VoidCallback? onCart;
  final int cartItemCount;

  @override
  Widget build(BuildContext context) {
    if (previewMode) {
      return Scaffold(
        backgroundColor: PreviewUi.canvas(context),
        appBar: ProfilePreviewHeader(
          itemCount: cartItemCount,
          onBack: onBack,
          onCart: onCart ?? () {},
        ),
        body: ProfilePreviewBody(state: state, onIntent: onIntent),
        bottomNavigationBar: bottomNavigationBar,
      );
    }
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final strings = S.of(context);
    final data = state.data;
    final displayName = data.displayName?.trim().isNotEmpty == true
        ? data.displayName!
        : strings.profileTitle;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: () async => onIntent(const ProfileRefreshRequested()),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                color: scheme.primary,
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                child: SafeArea(
                  bottom: false,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: scheme.onPrimary.withValues(
                          alpha: .18,
                        ),
                        child: Text(
                          data.initial ?? '?',
                          style: TextStyle(
                            color: scheme.onPrimary,
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          displayName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: scheme.onPrimary,
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              sliver: SliverList.list(
                children: [
                  AppSurfaceCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        _ProfileAction(
                          icon: Icons.person_outline_rounded,
                          title: strings.profileEditProfile,
                          subtitle: strings.profileEditProfileDesc,
                          onTap: () => onIntent(
                            const ProfilePersonalInformationRequested(),
                          ),
                        ),
                        const Divider(height: 1),
                        _ProfileAction(
                          icon: Icons.receipt_long_outlined,
                          title: strings.orderHistory,
                          subtitle: strings.orders,
                          onTap: () => onIntent(const ProfileOrdersRequested()),
                        ),
                        const Divider(height: 1),
                        _ProfileAction(
                          icon: Icons.confirmation_number_outlined,
                          title: 'Ví Voucher & Khuyến mãi',
                          subtitle: 'Mã giảm giá, Freeship của bạn',
                          onTap: () =>
                              onIntent(const ProfileVouchersRequested()),
                        ),
                        const Divider(height: 1),
                        _ProfileAction(
                          icon: Icons.location_on_outlined,
                          title: strings.profileMyAddresses,
                          subtitle: strings.profileMyAddressesDesc,
                          onTap: () =>
                              onIntent(const ProfileAddressesRequested()),
                        ),
                        const Divider(height: 1),
                        _ProfileAction(
                          icon: Icons.headset_mic_outlined,
                          title: 'Trung tâm Hỗ trợ & CSKH',
                          subtitle: 'Hotline 24/7, trợ giúp & liên hệ',
                          onTap: () =>
                              onIntent(const ProfileSupportRequested()),
                        ),
                        const Divider(height: 1),
                        _ProfileAction(
                          icon: Icons.live_tv_rounded,
                          title: 'Livestream Săn Deal',
                          subtitle: 'Phát trực tiếp & ưu đãi độc quyền',
                          onTap: () =>
                              onIntent(const ProfileLivestreamRequested()),
                        ),
                        const Divider(height: 1),
                        _ProfileAction(
                          icon: Icons.settings_outlined,
                          title: strings.settings,
                          subtitle: strings.settingsTitle,
                          onTap: () =>
                              onIntent(const ProfileSettingsRequested()),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  OutlinedButton.icon(
                    onPressed: state.isLoggingOut
                        ? null
                        : () => onIntent(const ProfileLogoutRequested()),
                    icon: state.isLoggingOut
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.logout),
                    label: Text(strings.profileLogout),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: scheme.error,
                      side: BorderSide(color: scheme.error),
                      minimumSize: const Size.fromHeight(44),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileAction extends StatelessWidget {
  const _ProfileAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      minVerticalPadding: 6,
      leading: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.primary.withValues(alpha: 0.12),
          borderRadius: AppRadii.control,
        ),
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(icon, color: scheme.primary, size: 20),
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
      ),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}
