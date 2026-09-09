import 'catalog_search_state.dart';

/// Display-only fallback rows used when the catalog API has no searchable
/// restaurant data yet. Negative IDs are intentionally non-canonical; the
/// page intercepts them before any restaurant or cart API is called.
const catalogSearchPreviewFixtures = <CatalogRestaurantSearchViewData>[
  CatalogRestaurantSearchViewData(
    id: '-1',
    name: 'Mì vằn thắn 9A Đinh Liệt',
    cuisine: 'Mì & phở',
    rating: 4.8,
    distanceKm: 1.2,
    deliveryTimeMinutes: 25,
    imageUrl:
        'https://huawei-food-cms.grab.com/compressed_webp/merchants/5-C23JAXXEVTVCAE/hero/2bd4d62de5484a1b8527247792af9dcb_1632883838487470130.webp',
  ),
  CatalogRestaurantSearchViewData(
    id: '-2',
    name: 'Đệ Nhất Ngan Hà Thành - Hai Bà Trưng',
    cuisine: 'Cơm & bún',
    rating: 4.7,
    distanceKm: 1.9,
    deliveryTimeMinutes: 25,
    imageUrl:
        'https://huawei-food-cms.grab.com/compressed_webp/merchants/5-C2ATGECUMATBC6/hero/9ceee0c1651b4a0e8f4a84f729889fa5_1601031051605780203.webp',
  ),
  CatalogRestaurantSearchViewData(
    id: '-3',
    name: 'Vũ Sáng',
    cuisine: 'Mì & phở',
    rating: 4.9,
    distanceKm: 2.6,
    deliveryTimeMinutes: 25,
    imageUrl:
        'https://huawei-food-cms.grab.com/compressed_webp/merchants/5-C2AVT2XXJAN3EN/hero/8aa05d98a66b44bfacfbabb611e1d13b_1601286294430345935.webp',
  ),
  CatalogRestaurantSearchViewData(
    id: '-4',
    name: 'Bánh Cuốn Nóng - Lê Duẩn',
    cuisine: 'Bánh cuốn',
    rating: 4.6,
    distanceKm: 3.3,
    deliveryTimeMinutes: 25,
    imageUrl:
        'https://huawei-food-cms.grab.com/compressed_webp/merchants/5-C2AZDEVCMGCBG2/hero/f61c038804514334ab6096ab2aafcd8d_1601619242619616255.webp',
  ),
  CatalogRestaurantSearchViewData(
    id: '-5',
    name: 'Phở Lý Quốc Sư - 25 Phủ Doãn',
    cuisine: 'Mì & phở',
    rating: 4.8,
    distanceKm: 4.0,
    deliveryTimeMinutes: 25,
    imageUrl:
        'https://huawei-food-cms.grab.com/compressed_webp/merchants/5-C2BBLE6CBETJCE/hero/46ba1cd0b76d4c1ea06bb6319f698318_1602151382116124903.webp',
  ),
  CatalogRestaurantSearchViewData(
    id: '-6',
    name: 'Ô Mai Gia Lợi - 8 Hàng Đường',
    cuisine: 'Ăn vặt',
    rating: 4.7,
    distanceKm: 4.7,
    deliveryTimeMinutes: 25,
    imageUrl:
        'https://huawei-food-cms.grab.com/compressed_webp/merchants/5-C2BETREHE7LKRN/hero/f0ca7d18-76aa-4b6c-9d28-0c7bd12fb76b__store_cover__2024__08__15__06__23__05.webp',
  ),
];
