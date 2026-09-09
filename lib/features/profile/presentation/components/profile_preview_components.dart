import 'package:delivery_app/features/profile/application/profile_intent.dart';
import 'package:delivery_app/features/profile/application/profile_view_state.dart';
import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

const _profilePreviewAccent = Color(0xFFEE4D2D);

class ProfilePreviewHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const ProfilePreviewHeader({
    super.key,
    required this.onBack,
    required this.onCart,
    this.itemCount = 0,
    this.title = 'Tôi',
  });

  final VoidCallback? onBack;
  final VoidCallback onCart;
  final int itemCount;
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) => AppBar(
    automaticallyImplyLeading: false,
    toolbarHeight: 50,
    elevation: 0,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    backgroundColor: PreviewUi.surface(context),
    leadingWidth: 44,
    leading: onBack == null
        ? const SizedBox(width: 44)
        : IconButton(
            key: const Key('profile_back'),
            tooltip: 'Quay lại',
            onPressed: onBack,
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.arrow_back, color: _profilePreviewAccent),
          ),
    title: Text(
      title,
      style: TextStyle(
        color: PreviewUi.text(context),
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
    ),
    centerTitle: true,
    actions: [
      SizedBox(
        width: 44,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            IconButton(
              key: const Key('profile_cart_action'),
              tooltip: 'Giỏ hàng',
              onPressed: onCart,
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.shopping_bag_outlined, size: 22),
            ),
            if (itemCount > 0)
              Positioned(
                right: 1,
                top: 4,
                child: Container(
                  constraints: const BoxConstraints(minWidth: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: _profilePreviewAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    itemCount > 99 ? '99+' : '$itemCount',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ],
  );
}

class ProfilePreviewBody extends StatelessWidget {
  const ProfilePreviewBody({
    super.key,
    required this.state,
    required this.onIntent,
  });

  final ProfileViewState state;
  final ValueChanged<ProfileIntent> onIntent;

  @override
  Widget build(BuildContext context) {
    final data = state.data;
    final displayName = data.displayName?.trim().isNotEmpty == true
        ? data.displayName!.trim()
        : 'Khách trải nghiệm';
    final subtitle = data.email?.trim().isNotEmpty == true
        ? data.email!.trim()
        : 'Tài khoản trải nghiệm';
    return RefreshIndicator(
      onRefresh: () async => onIntent(const ProfileRefreshRequested()),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: _profilePreviewAccent,
            padding: const EdgeInsets.fromLTRB(18, 26, 18, 26),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: .6),
                      width: 2,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 42,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFFFFB8A5)
                              : const Color(0xFFFFE5DC),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Material(
            color: PreviewUi.surface(context),
            child: Column(
              children: [
                _ProfilePreviewAction(
                  icon: Icons.person,
                  title: 'Thông tin cá nhân',
                  subtitle: 'Quản lý họ tên, số điện thoại và email',
                  onTap: () =>
                      onIntent(const ProfilePersonalInformationRequested()),
                ),
                _ProfilePreviewAction(
                  icon: Icons.location_on,
                  title: 'Địa chỉ của tôi',
                  subtitle: 'Quản lý địa chỉ nhận món',
                  onTap: () => onIntent(const ProfileAddressesRequested()),
                ),
                _ProfilePreviewAction(
                  icon: Icons.receipt_long,
                  title: 'Đơn hàng của tôi',
                  subtitle: 'Theo dõi và xem lịch sử đơn hàng',
                  onTap: () => onIntent(const ProfileOrdersRequested()),
                ),
                _ProfilePreviewAction(
                  icon: Icons.settings,
                  title: 'Cài đặt',
                  subtitle: 'Giao diện và công cụ trải nghiệm',
                  onTap: () => onIntent(const ProfileSettingsRequested()),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 24, 15, 24),
            child: OutlinedButton.icon(
              key: const Key('profile_logout'),
              onPressed: state.isLoggingOut
                  ? null
                  : () => onIntent(const ProfileLogoutRequested()),
              icon: state.isLoggingOut
                  ? const SizedBox.square(
                      dimension: 17,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.logout),
              label: const Text('Đăng xuất'),
              style: OutlinedButton.styleFrom(
                foregroundColor: _profilePreviewAccent,
                side: const BorderSide(color: _profilePreviewAccent),
                minimumSize: const Size.fromHeight(44),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfilePreviewAction extends StatelessWidget {
  const _ProfilePreviewAction({
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
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: PreviewUi.divider(context))),
      ),
      child: Row(
        children: [
          Icon(icon, color: _profilePreviewAccent, size: 21),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: PreviewUi.muted(context),
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: PreviewUi.muted(context), size: 20),
        ],
      ),
    ),
  );
}

class ProfilePersonalInformationPreviewBody extends StatelessWidget {
  const ProfilePersonalInformationPreviewBody({
    super.key,
    required this.data,
    this.isLoading = false,
    this.errorMessage,
    this.onRetry,
  });

  final ProfileViewData data;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final displayName = data.displayName?.trim().isNotEmpty == true
        ? data.displayName!.trim()
        : 'Khách trải nghiệm';
    final phone = data.phone?.trim().isNotEmpty == true
        ? data.phone!
        : '0900000000';
    final email = data.email?.trim().isNotEmpty == true
        ? data.email!
        : 'khach@example.com';
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 30, 16, 55),
      children: [
        if (isLoading) const LinearProgressIndicator(),
        if (errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              children: [
                Text(errorMessage!, textAlign: TextAlign.center),
                TextButton(onPressed: onRetry, child: const Text('Thử lại')),
              ],
            ),
          ),
        Container(
          width: 78,
          height: 78,
          margin: const EdgeInsets.only(bottom: 14),
          decoration: BoxDecoration(
            border: Border.all(color: _profilePreviewAccent, width: 2),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.person,
            color: _profilePreviewAccent,
            size: 48,
          ),
        ),
        Text(
          displayName,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Text(
          'Tài khoản preview nội bộ',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: PreviewUi.muted(context)),
        ),
        const SizedBox(height: 30),
        _ProfilePreviewDetails(
          rows: [
            ('Họ và tên', displayName),
            ('Số điện thoại', phone),
            ('Email', email),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.info, color: _profilePreviewAccent, size: 18),
            SizedBox(width: 7),
            Expanded(
              child: Text(
                'Đây là dữ liệu mẫu để đối chiếu giao diện, không phải thông tin tài khoản thật.',
                style: TextStyle(fontSize: 11, color: PreviewUi.muted(context)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProfilePreviewDetails extends StatelessWidget {
  const _ProfilePreviewDetails({required this.rows});

  final List<(String, String)> rows;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      for (final row in rows)
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: PreviewUi.divider(context)),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  row.$1,
                  style: TextStyle(
                    fontSize: 13,
                    color: PreviewUi.muted(context),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Flexible(
                child: Text(
                  row.$2,
                  textAlign: TextAlign.end,
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
        ),
    ],
  );
}
