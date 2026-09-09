import 'package:flutter/material.dart';
import 'home_mock_sheet.dart';
import 'home_style.dart';

class HomeOfferStrip extends StatelessWidget {
  const HomeOfferStrip({super.key});
  @override
  Widget build(BuildContext context) => ColoredBox(
    color: HomeStyle.surface(context),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: HomeStyle.accent(context).withValues(alpha: .06),
          border: Border.all(
            color: HomeStyle.accent(context).withValues(alpha: .18),
          ),
          borderRadius: HomeStyle.controlRadius,
        ),
        child: Row(
          children: [
            Icon(
              Icons.confirmation_number_outlined,
              color: HomeStyle.accent(context),
              size: 23,
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Freeship cho bữa ngon',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Áp dụng trong bản trải nghiệm',
                    style: TextStyle(
                      fontSize: 10,
                      color: HomeStyle.muted(context),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: () => showHomeMockSheet(
                context,
                'Voucher mẫu — không áp dụng cho đơn thật',
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(0, 32),
                padding: const EdgeInsets.symmetric(horizontal: 10),
              ),
              child: const Text('Lấy mã', style: TextStyle(fontSize: 11)),
            ),
          ],
        ),
      ),
    ),
  );
}
