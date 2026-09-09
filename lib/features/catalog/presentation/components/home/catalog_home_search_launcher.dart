import 'package:delivery_app/features/catalog/application/catalog_home_intent.dart';
import 'package:delivery_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'home_style.dart';

class CatalogHomeSearchLauncher extends StatelessWidget {
  const CatalogHomeSearchLauncher({super.key, required this.onIntent});
  final ValueChanged<CatalogHomeIntent> onIntent;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: HomeStyle.surface(context),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(
        HomeStyle.gutter,
        0,
        HomeStyle.gutter,
        12,
      ),
      child: Material(
        color: HomeStyle.canvas(context),
        borderRadius: HomeStyle.controlRadius,
        child: Semantics(
          button: true,
          child: InkWell(
            borderRadius: HomeStyle.controlRadius,
            onTap: () => onIntent(const CatalogHomeSearchRequested()),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
              child: Row(
                children: [
                  Icon(Icons.search, size: 20, color: HomeStyle.muted(context)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      S.of(context).pilotHomeSearchHint,
                      style: TextStyle(
                        fontSize: 13,
                        color: HomeStyle.muted(context),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(
                    Icons.arrow_forward,
                    size: 18,
                    color: HomeStyle.accent(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
