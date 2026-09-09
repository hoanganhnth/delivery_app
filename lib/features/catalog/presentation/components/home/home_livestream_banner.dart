import 'package:flutter/material.dart';
import 'home_style.dart';

/// Existing livestream destination styled as the preview's compact offer strip.
class HomeLivestreamBanner extends StatelessWidget {
  const HomeLivestreamBanner({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(HomeStyle.gutter),
    child: Material(
      color: HomeStyle.accent(context).withValues(alpha: 0.06),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: HomeStyle.accent(context).withValues(alpha: 0.2),
        ),
        borderRadius: HomeStyle.controlRadius,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: HomeStyle.controlRadius,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Icon(
                Icons.live_tv_outlined,
                color: HomeStyle.accent(context),
                size: 24,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Livestream Ẩm Thực & Săn Deal',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Xem trực tiếp & nhận voucher độc quyền',
                      style: TextStyle(
                        fontSize: 11,
                        color: HomeStyle.muted(context),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right,
                size: 20,
                color: HomeStyle.accent(context),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
