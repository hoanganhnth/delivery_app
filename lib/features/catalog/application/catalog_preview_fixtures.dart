import 'catalog_search_preview_fixtures.dart';
import '../../../core/contracts/catalog_contract.dart';

/// Synthetic IDs used only by the customer preview when the catalog API has
/// no rows yet. They are positive so GoRouter can open the same detail route,
/// but the detail ViewModel recognizes them before making a remote request.
const catalogPreviewRestaurantIdOffset = 900000;

int? catalogPreviewRestaurantIdFor(String rawId) {
  final value = int.tryParse(rawId);
  if (value == null || value >= 0) return null;
  final index = -value;
  if (index < 1 || index > catalogSearchPreviewFixtures.length) return null;
  return catalogPreviewRestaurantIdOffset + index;
}

CatalogDetailResult? catalogPreviewDetailFor(num restaurantId) {
  final index = restaurantId.toInt() - catalogPreviewRestaurantIdOffset - 1;
  if (index < 0 || index >= catalogSearchPreviewFixtures.length) return null;

  final restaurant = catalogSearchPreviewFixtures[index];
  final menu = _previewMenus[index];
  return CatalogDetailResult(
    restaurant: CatalogRestaurantSnapshot(
      id: restaurantId,
      name: restaurant.name,
      address: _addresses[index],
      rating: restaurant.rating,
      reviewCount: 100,
      deliveryTimeMinutes: restaurant.deliveryTimeMinutes,
      category: restaurant.cuisine,
      distanceKm: restaurant.distanceKm,
      deliveryFee: 0,
      openingHour: '08:00',
      closingHour: '22:00',
      isOpen: true,
      imageUrl: restaurant.imageUrl,
    ),
    menuItems: [
      for (var menuIndex = 0; menuIndex < menu.length; menuIndex++)
        CatalogMenuSnapshot(
          id: _menuId(index, menuIndex),
          restaurantId: restaurantId,
          name: menu[menuIndex].name,
          description: 'Chuẩn vị, chế biến khi nhận đơn',
          price: menu[menuIndex].price,
          status: CatalogMenuStatus.available,
          imageUrl: menu[menuIndex].imageUrl,
        ),
    ],
  );
}

int _menuId(int restaurantIndex, int menuIndex) =>
    910000 + restaurantIndex * 10 + menuIndex + 1;

const _addresses = [
  '9A Đinh Liệt, Hoàn Kiếm, Hà Nội',
  '151 Bà Triệu, Hai Bà Trưng, Hà Nội',
  '40 Võ Chí Công, Tây Hồ, Hà Nội',
  '95 Lê Duẩn, Đống Đa, Hà Nội',
  '25 Phủ Doãn, Hoàn Kiếm, Hà Nội',
  '8 Hàng Đường, Hoàn Kiếm, Hà Nội',
];

const _previewMenus = [
  [
    _PreviewMenu(
      'Hủ tiếu khô',
      45000,
      'https://huawei-food-cms.grab.com/compressed_webp/items/VNITE2023111914492527567/photo/menueditor_item_c3d3f9b6b3564c77936cb73431bfdc0b_1700405329714594563.webp',
    ),
    _PreviewMenu(
      'Miến trộn đặc biệt',
      65000,
      'https://huawei-food-cms.grab.com/compressed_webp/items/VNITE2023111911010426793/photo/menueditor_item_d29f1ba8efcc4fe1bdb282ed29f26055_1700391598741126523.webp',
    ),
    _PreviewMenu(
      'Mì vằn thắn khô',
      50000,
      'https://huawei-food-cms.grab.com/compressed_webp/items/VNITE2023111914463299997/photo/menueditor_item_f6404ca875e24a26bc9f5b97680c2446_1700405152975562977.webp',
    ),
    _PreviewMenu(
      'Sủi cảo',
      35000,
      'https://huawei-food-cms.grab.com/compressed_webp/items/VNITE2023111914515531082/photo/menueditor_item_032e42061c424af38751171ad81bdf17_1700405422484594897.webp',
    ),
  ],
  [
    _PreviewMenu(
      'Mẹt ngan 6 món',
      45000,
      'https://huawei-food-cms.grab.com/compressed_webp/items/VNITE2020122012185051411/photo/menueditor_item_ca6635947e4744788e0749fbac83b989_1608466727893312846.webp',
    ),
    _PreviewMenu(
      'Lẩu ngan kim chi',
      65000,
      'https://huawei-food-cms.grab.com/compressed_webp/items/VNITE2020122012202595748/photo/menueditor_item_653fadcafeb743108203dbd1a52985ea_1608466823118751901.webp',
    ),
    _PreviewMenu(
      'Ngan xào lăn',
      50000,
      'https://huawei-food-cms.grab.com/compressed_webp/items/VNITE2020122012212601154/photo/menueditor_item_e324cad7b8014aabbb853c1364e25819_1608466884075571616.webp',
    ),
    _PreviewMenu(
      'Dồi ngan chiên giòn',
      35000,
      'https://huawei-food-cms.grab.com/compressed_webp/items/VNITE2020122012222454145/photo/menueditor_item_e188068bc8b64000a58a82c5a0210ce5_1608466942012066871.webp',
    ),
  ],
  [
    _PreviewMenu(
      'Phở bò tái',
      45000,
      'https://huawei-food-cms.grab.com/compressed_webp/items/5-C2AVT2XXJAN3EN-C2AVT2XXRYXKR6/photo/aa6d7f29c002479da97479072dd3e50a_1672487127673721257.webp',
    ),
    _PreviewMenu(
      'Phở tái chín',
      65000,
      'https://huawei-food-cms.grab.com/compressed_webp/items/5-C2AVT2XXJAN3EN-C2AVT2XYACBFR2/photo/da5b1a95fcb34edaad147c99f8bcc8d6_1672487123718182389.webp',
    ),
    _PreviewMenu(
      'Phở tái nạm',
      50000,
      'https://huawei-food-cms.grab.com/compressed_webp/items/5-C2AVT2XXJAN3EN-C2AVT2XYBFKBNJ/photo/24941e925e6f43acbe1df9308b23d5c0_1677496042435568871.webp',
    ),
    _PreviewMenu(
      'Phở tái gầu',
      35000,
      'https://huawei-food-cms.grab.com/compressed_webp/items/5-C2AVT2XXJAN3EN-C2AVT2XYDETJET/photo/6f95463d6dc64209871b12cf5d89d23b_1672487124646202794.webp',
    ),
  ],
  [
    _PreviewMenu(
      'Bánh cuốn nóng',
      45000,
      'https://huawei-food-cms.grab.com/compressed_webp/items/5-C2AZDEVCMGCBG2-C2AZDEVCVBUEE2/photo/a36fd9afb87d4e5a856f65b75ee7c835_1669033384647813088.webp',
    ),
    _PreviewMenu(
      'Bánh cuốn lạp xưởng sườn',
      65000,
      'https://huawei-food-cms.grab.com/compressed_webp/items/5-C2AZDEVCMGCBG2-C2AZDEVDAXNYWA/photo/94d9198d03dc4561b6f08f496de93a48_1669033388894280528.webp',
    ),
    _PreviewMenu(
      'Bánh cuốn chả sườn',
      50000,
      'https://huawei-food-cms.grab.com/compressed_webp/items/5-C2AZDEVCMGCBG2-C2AZDEVDC63AAT/photo/317ab324272c4fca9f0314f664e631a4_1669033384777697843.webp',
    ),
    _PreviewMenu(
      'Bánh cuốn chả',
      35000,
      'https://huawei-food-cms.grab.com/compressed_webp/items/5-C2AZDEVCMGCBG2-C2AZDEVDE74VTA/photo/23f578128d0e4320a3558421cf406a6a_1669033388472562010.webp',
    ),
  ],
  [
    _PreviewMenu(
      'Phở chín',
      45000,
      'https://huawei-food-cms.grab.com/compressed_webp/items/5-C2BBLE6CBETJCE-C2BBLE6CVCNFLX/photo/menueditor_item_256299fd59dd4f10bb24b5a68b62d9c6_1602494154054157051.webp',
    ),
    _PreviewMenu(
      'Phở nạm',
      65000,
      'https://huawei-food-cms.grab.com/compressed_webp/items/5-C2BBLE6CBETJCE-C2BBLE6DMGBUVA/photo/menueditor_item_b4d91edeb7ad4443b340c6af3e5e760f_1602494829231587495.webp',
    ),
    _PreviewMenu(
      'Phở bắp bò',
      50000,
      'https://huawei-food-cms.grab.com/compressed_webp/items/5-C2BBLE6CBETJCE-C2BBLE6DRN2FJA/photo/menueditor_item_ef67ccdbc15f40869ff71d5aaed48df9_1602495326496274876.webp',
    ),
    _PreviewMenu(
      'Phở đặc biệt',
      35000,
      'https://huawei-food-cms.grab.com/compressed_webp/items/5-C2BBLE6CBETJCE-C2BBLE6EEXLJRJ/photo/menueditor_item_5dfb6cddfe314300a5795b2462e36491_1620621006115189665.webp',
    ),
  ],
  [
    _PreviewMenu(
      'Đào dẻo chua ngọt 100g',
      45000,
      'https://huawei-food-cms.grab.com/compressed_webp/items/VNITE2020102110453321629/photo/menueditor_item_0e28f498d654434c8ac512bcd4825f97_1652266199773192509.webp',
    ),
    _PreviewMenu(
      'Mơ xào gừng 100g',
      65000,
      'https://huawei-food-cms.grab.com/compressed_webp/items/VNITE2020102110575828911/photo/menueditor_item_f80e9baea27a47469bae04960aabe17a_1641740664911218876.webp',
    ),
    _PreviewMenu(
      'Ô mai cam 100g',
      50000,
      'https://huawei-food-cms.grab.com/compressed_webp/items/VNITE2020102110582995349/photo/menueditor_item_83f28e03441a4215ae29cd866156675d_1641740844391696259.webp',
    ),
    _PreviewMenu(
      'Ô mai chua mặn ngọt 100g',
      35000,
      'https://huawei-food-cms.grab.com/compressed_webp/items/VNITE2020102110594952005/photo/menueditor_item_af535970e7554c2a8d3767c6e0b611b4_1641740934547226238.webp',
    ),
  ],
];

class _PreviewMenu {
  const _PreviewMenu(this.name, this.price, this.imageUrl);

  final String name;
  final double price;
  final String imageUrl;
}
