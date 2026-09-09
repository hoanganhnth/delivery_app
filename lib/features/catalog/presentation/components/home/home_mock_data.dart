import 'package:delivery_app/features/catalog/application/catalog_home_state.dart';
import 'package:delivery_app/features/catalog/application/home_suggested_dish.dart';

/// Display-only fixtures from customer-preview/catalog.json. Negative IDs must
/// never cross an API or cart boundary; Home handles their taps locally.
const homeMockRestaurants = <CatalogRestaurantViewData>[
  CatalogRestaurantViewData(
    id: -1,
    name: "Mì vằn thắn 9A Đinh Liệt",
    imageUrl:
        "https://huawei-food-cms.grab.com/compressed_webp/merchants/5-C23JAXXEVTVCAE/hero/2bd4d62de5484a1b8527247792af9dcb_1632883838487470130.webp",
    category: "Mì & phở",
    rating: 4.8,
    distanceKm: 1.2,
    deliveryTimeMinutes: 25,
    deliveryFee: 0,
  ),
  CatalogRestaurantViewData(
    id: -2,
    name: "Đệ Nhất Ngan Hà Thành - Hai Bà Trưng",
    imageUrl:
        "https://huawei-food-cms.grab.com/compressed_webp/merchants/5-C2ATGECUMATBC6/hero/9ceee0c1651b4a0e8f4a84f729889fa5_1601031051605780203.webp",
    category: "Cơm & bún",
    rating: 4.7,
    distanceKm: 1.9,
    deliveryTimeMinutes: 25,
    deliveryFee: 0,
  ),
  CatalogRestaurantViewData(
    id: -3,
    name: "Vũ Sáng",
    imageUrl:
        "https://huawei-food-cms.grab.com/compressed_webp/merchants/5-C2AVT2XXJAN3EN/hero/8aa05d98a66b44bfacfbabb611e1d13b_1601286294430345935.webp",
    category: "Mì & phở",
    rating: 4.9,
    distanceKm: 2.6,
    deliveryTimeMinutes: 25,
    deliveryFee: 0,
  ),
  CatalogRestaurantViewData(
    id: -4,
    name: "Bánh Cuốn Nóng - Lê Duẩn",
    imageUrl:
        "https://huawei-food-cms.grab.com/compressed_webp/merchants/5-C2AZDEVCMGCBG2/hero/f61c038804514334ab6096ab2aafcd8d_1601619242619616255.webp",
    category: "Bánh cuốn",
    rating: 4.6,
    distanceKm: 3.3,
    deliveryTimeMinutes: 25,
    deliveryFee: 0,
  ),
  CatalogRestaurantViewData(
    id: -5,
    name: "Phở Lý Quốc Sư - 25 Phủ Doãn",
    imageUrl:
        "https://huawei-food-cms.grab.com/compressed_webp/merchants/5-C2BBLE6CBETJCE/hero/46ba1cd0b76d4c1ea06bb6319f698318_1602151382116124903.webp",
    category: "Mì & phở",
    rating: 4.8,
    distanceKm: 4.0,
    deliveryTimeMinutes: 25,
    deliveryFee: 0,
  ),
  CatalogRestaurantViewData(
    id: -6,
    name: "Ô Mai Gia Lợi - 8 Hàng Đường",
    imageUrl:
        "https://huawei-food-cms.grab.com/compressed_webp/merchants/5-C2BETREHE7LKRN/hero/f0ca7d18-76aa-4b6c-9d28-0c7bd12fb76b__store_cover__2024__08__15__06__23__05.webp",
    category: "Ăn vặt",
    rating: 4.7,
    distanceKm: 4.7,
    deliveryTimeMinutes: 25,
    deliveryFee: 0,
  ),
];

const homeSuggestedDishes = <HomeSuggestedDish>[
  HomeSuggestedDish(
    name: "Mì vằn thắn khô",
    image:
        "https://huawei-food-cms.grab.com/compressed_webp/items/VNITE2023111914463299997/photo/menueditor_item_f6404ca875e24a26bc9f5b97680c2446_1700405152975562977.webp",
    price: 50000,
    restaurantId: -1,
  ),
  HomeSuggestedDish(
    name: "Ngan xào lăn",
    image:
        "https://huawei-food-cms.grab.com/compressed_webp/items/VNITE2020122012212601154/photo/menueditor_item_e324cad7b8014aabbb853c1364e25819_1608466884075571616.webp",
    price: 50000,
    restaurantId: -2,
  ),
  HomeSuggestedDish(
    name: "Phở tái nạm",
    image:
        "https://huawei-food-cms.grab.com/compressed_webp/items/5-C2AVT2XXJAN3EN-C2AVT2XYBFKBNJ/photo/24941e925e6f43acbe1df9308b23d5c0_1677496042435568871.webp",
    price: 50000,
    restaurantId: -3,
  ),
  HomeSuggestedDish(
    name: "Bánh cuốn chả sườn",
    image:
        "https://huawei-food-cms.grab.com/compressed_webp/items/5-C2AZDEVCMGCBG2-C2AZDEVDC63AAT/photo/317ab324272c4fca9f0314f664e631a4_1669033384777697843.webp",
    price: 50000,
    restaurantId: -4,
  ),
];
