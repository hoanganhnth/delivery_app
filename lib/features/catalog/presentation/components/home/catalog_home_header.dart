import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:delivery_app/features/catalog/application/catalog_home_intent.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'home_style.dart';

class CatalogHomeHeader extends StatelessWidget {
  const CatalogHomeHeader({
    super.key,
    required this.onIntent,
    this.deliveryAddress,
  });
  final ValueChanged<CatalogHomeIntent> onIntent;
  final String? deliveryAddress;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final address = deliveryAddress?.trim();
    return ColoredBox(
      color: HomeStyle.surface(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: HomeStyle.gutter),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'ShopeeFood',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                      color: HomeStyle.accent(context),
                    ),
                  ),
                ),
                AppIconButton(
                  tooltip: strings.pilotHomeOpenNotifications,
                  icon: Icons.notifications_outlined,
                  onPressed: () =>
                      onIntent(const CatalogHomeNotificationsRequested()),
                ),
                AppIconButton(
                  tooltip: strings.pilotHomeOpenCart,
                  icon: Icons.shopping_cart_outlined,
                  onPressed: () => onIntent(const CatalogHomeCartRequested()),
                ),
              ],
            ),
            Semantics(
              button: true,
              child: InkWell(
                onTap: () => onIntent(const CatalogHomeAddressRequested()),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 48),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 18,
                        color: HomeStyle.accent(context),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        strings.pilotHomeDeliverTo,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const Text(': ', style: TextStyle(fontSize: 12)),
                      Expanded(
                        child: Text(
                          address?.isNotEmpty == true
                              ? address!
                              : strings.pilotHomeSelectAddress,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Icon(Icons.chevron_right, size: 18),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
