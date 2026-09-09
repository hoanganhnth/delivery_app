import 'package:delivery_app/core/design_system/components/app_image.dart';
import 'package:flutter/material.dart';
import 'home_style.dart';
import 'home_mock_data.dart';
import 'home_mock_sheet.dart';

class HomeBannerCarousel extends StatefulWidget {
  const HomeBannerCarousel({super.key});
  @override
  State<HomeBannerCarousel> createState() => _HomeBannerCarouselState();
}

class _HomeBannerCarouselState extends State<HomeBannerCarousel> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.textScalerOf(context).scale(1).clamp(1.0, 3.0);
    return ColoredBox(
      color: HomeStyle.surface(context),
      child: Column(
        children: [
          SizedBox(
            height: 152 * scale * scale,
            child: PageView.builder(
              itemCount: 3,
              onPageChanged: (index) => setState(() => _index = index),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: ColoredBox(
                    color: const Color(0xFFFCE8DA),
                    child: Stack(
                      children: [
                        Positioned(
                          right: -28,
                          top: 10,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFFFF7EF),
                                width: 6,
                              ),
                            ),
                            child: AppContentImage(
                              imageUrl: homeSuggestedDishes[index].image,
                              semanticLabel: 'Ảnh món minh họa',
                              width: 132,
                              height: 132,
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                          child: DefaultTextStyle.merge(
                            style: const TextStyle(height: 1.1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'ĐẠI TIỆC MÓN NGON',
                                  style: TextStyle(
                                    fontSize: 10,
                                    letterSpacing: 1,
                                    color: Color(0xFFB2371F),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  index == 0
                                      ? 'Ăn ngon mỗi ngày'
                                      : index == 1
                                      ? 'Bữa ngon hết ý'
                                      : 'Khám phá món ngon',
                                  style: const TextStyle(
                                    fontSize: 19,
                                    height: 1.3,
                                    color: Color(0xFFB2371F),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Text(
                                  'FREESHIP XTRA',
                                  style: TextStyle(
                                    fontSize: 22,
                                    height: 1.3,
                                    letterSpacing: -.7,
                                    color: Color(0xFFEE4D2D),
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const Text(
                                  'Ưu đãi giao hàng 15.000đ',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFFB2371F),
                                  ),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () => showHomeMockSheet(
                                    context,
                                    'Ưu đãi mẫu — Freeship Xtra',
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEE4D2D),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Text(
                                      'Đặt ngay  →',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 17,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < 3; i++)
                  Semantics(
                    label: 'Slide ${i + 1}',
                    selected: i == _index,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: i == _index ? 10 : 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: i == _index
                            ? HomeStyle.accent(context)
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
