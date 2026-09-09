import 'package:delivery_app/features/settings/application/settings_intent.dart';
import 'package:delivery_app/features/settings/application/settings_state.dart';
import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

const _settingsPreviewAccent = Color(0xFFEE4D2D);

class SettingsPreviewHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const SettingsPreviewHeader({
    super.key,
    required this.onBack,
    required this.onCart,
  });

  final VoidCallback onBack;
  final VoidCallback onCart;

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
    leading: IconButton(
      key: const Key('settings_back'),
      tooltip: 'Quay lại',
      onPressed: onBack,
      padding: EdgeInsets.zero,
      icon: const Icon(Icons.arrow_back, color: _settingsPreviewAccent),
    ),
    title: Text(
      'Cài đặt',
      style: TextStyle(
        color: PreviewUi.text(context),
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
    ),
    centerTitle: true,
    actions: [
      IconButton(
        key: const Key('settings_cart_action'),
        tooltip: 'Giỏ hàng',
        onPressed: onCart,
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.shopping_bag_outlined, size: 22),
      ),
      const SizedBox(width: 4),
    ],
  );
}

class SettingsPreviewBody extends StatelessWidget {
  const SettingsPreviewBody({
    super.key,
    required this.state,
    required this.onIntent,
  });

  final SettingsViewState state;
  final ValueChanged<SettingsIntent> onIntent;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.only(top: 8, bottom: 24),
    children: [
      const _SettingsPreviewGroupTitle('Giao diện'),
      Container(
        color: PreviewUi.surface(context),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: [
            const Icon(Icons.palette, color: _settingsPreviewAccent, size: 21),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chủ đề',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Chọn giao diện cho bản preview',
                    style: TextStyle(
                      fontSize: 10,
                      color: PreviewUi.muted(context),
                    ),
                  ),
                ],
              ),
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                key: const Key('settings_preview_theme'),
                value: state.isDarkMode ? 'dark' : 'light',
                isDense: true,
                style: TextStyle(color: PreviewUi.text(context), fontSize: 11),
                items: const [
                  DropdownMenuItem(value: 'light', child: Text('Sáng')),
                  DropdownMenuItem(value: 'dark', child: Text('Tối')),
                ],
                onChanged: state.isThemeUpdating
                    ? null
                    : (value) {
                        if (value != null &&
                            (value == 'dark') != state.isDarkMode) {
                          onIntent(const SettingsThemeToggled());
                        }
                      },
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 8),
      const _SettingsPreviewGroupTitle('Công cụ trải nghiệm'),
      Container(
        color: PreviewUi.surface(context),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            InkWell(
              key: const Key('settings_preview_debug'),
              onTap: () => onIntent(const SettingsDebugPreviewToggled()),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: [
                    const Icon(
                      Icons.bug_report,
                      color: _settingsPreviewAccent,
                      size: 21,
                    ),
                    const SizedBox(width: 11),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Debug preview',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Hiện thông tin chẩn đoán trong bản mock',
                            style: TextStyle(
                              fontSize: 10,
                              color: PreviewUi.muted(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _PreviewSwitch(value: state.debugEnabled),
                  ],
                ),
              ),
            ),
            if (state.debugEnabled)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(11),
                color: const Color(0xFF24272B),
                child: const Text(
                  'Debug đang bật\nBackend: Không gọi API\nDữ liệu: Fixture trong bộ nhớ',
                  style: TextStyle(
                    color: Color(0xFFEAF1F5),
                    fontFamily: 'monospace',
                    fontSize: 10,
                    height: 1.6,
                  ),
                ),
              ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.science, color: _settingsPreviewAccent, size: 17),
            SizedBox(width: 7),
            Expanded(
              child: Text(
                'Các cài đặt chỉ áp dụng trong preview và sẽ trở về mặc định khi tải lại trang.',
                style: TextStyle(fontSize: 11, color: PreviewUi.muted(context)),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

class _SettingsPreviewGroupTitle extends StatelessWidget {
  const _SettingsPreviewGroupTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(14, 7, 14, 6),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: PreviewUi.text(context),
      ),
    ),
  );
}

class _PreviewSwitch extends StatelessWidget {
  const _PreviewSwitch({required this.value});

  final bool value;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: const Duration(milliseconds: 150),
    width: 42,
    height: 24,
    padding: const EdgeInsets.all(3),
    decoration: BoxDecoration(
      color: value
          ? _settingsPreviewAccent
          : Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF555555)
          : const Color(0xFFD7D7D7),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Align(
      alignment: value ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          color: PreviewUi.surface(context),
          shape: BoxShape.circle,
        ),
      ),
    ),
  );
}
