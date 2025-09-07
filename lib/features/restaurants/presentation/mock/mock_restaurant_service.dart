import '../../domain/entities/restaurant_entity.dart';
import '../../domain/entities/menu_item_entity.dart';

class MockRestaurantService {
  static List<RestaurantEntity> getMockRestaurants() {
    return [
      const RestaurantEntity(
        id: 1,
        name: 'KFC - Nguyễn Trãi',
        description: 'Gà rán Kentucky ngon tuyệt',
        address: '123 Nguyễn Trãi, Q.1, TP.HCM',
        phone: '0901234567',
        image:
            'https://images.unsplash.com/photo-1513639776629-7b61b0ac49cb?w=300',
        addressLat: 10.7769,
        addressLng: 106.7009,
      ),
      const RestaurantEntity(
        id: 2,
        name: 'Pizza Hut - Vincom',
        description: 'Pizza ngon nhất thế giới',
        address: '456 Đồng Khởi, Q.1, TP.HCM',
        phone: '0902345678',
        image:
            'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=300',
        addressLat: 10.7740,
        addressLng: 106.7010,
      ),
      const RestaurantEntity(
        id: 3,
        name: 'Lotteria - Saigon Centre',
        description: 'Burger Hàn Quốc chính hiệu',
        address: '789 Lê Lợi, Q.1, TP.HCM',
        phone: '0903456789',
        image:
            'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=300',
        addressLat: 10.7720,
        addressLng: 106.7000,
      ),
      const RestaurantEntity(
        id: 4,
        name: 'Phở Hòa - Pasteur',
        description: 'Phở bò Hà Nội chính gốc',
        address: '321 Pasteur, Q.3, TP.HCM',
        phone: '0904567890',
        image:
            'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?w=300',
        addressLat: 10.7780,
        addressLng: 106.6920,
      ),
      const RestaurantEntity(
        id: 5,
        name: 'Highlands Coffee - Landmark',
        description: 'Cà phê Việt Nam đậm đà',
        address: '654 Tôn Đức Thắng, Q.1, TP.HCM',
        phone: '0905678901',
        image:
            'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=300',
        addressLat: 10.7700,
        addressLng: 106.7050,
      ),
      const RestaurantEntity(
        id: 6,
        name: 'Bánh Mì Huỳnh Hoa',
        description: 'Bánh mì thập cẩm nổi tiếng Sài Gòn',
        address: '26 Lê Thị Riêng, Q.1, TP.HCM',
        phone: '0906789012',
        image:
            'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=300',
        addressLat: 10.7690,
        addressLng: 106.6990,
      ),
    ];
  }

  static List<MenuItemEntity> getMockMenuItems(num restaurantId) {
    switch (restaurantId) {
      case 1: // KFC
        return [
          const MenuItemEntity(
            id: 101,
            restaurantId: 1,
            name: 'Gà Rán Giòn Cay',
            description: 'Miếng gà rán giòn tan với gia vị cay nồng đặc trưng',
            price: 45000,
            image:
                'https://images.unsplash.com/photo-1626645738196-c2a7c87a8f58?w=200',
            status: MenuItemStatus.available,
          ),
          const MenuItemEntity(
            id: 102,
            restaurantId: 1,
            name: 'Combo Gà + Burger',
            description: '1 miếng gà + 1 burger + khoai tây + nước ngọt',
            price: 89000,
            image:
                'https://images.unsplash.com/photo-1553979459-d2229ba7433a?w=200',
            status: MenuItemStatus.available,
          ),
          const MenuItemEntity(
            id: 103,
            restaurantId: 1,
            name: 'Khoai Tây Chiên',
            description: 'Khoai tây chiên giòn rụm size lớn',
            price: 25000,
            image:
                'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=200',
            status: MenuItemStatus.available,
          ),
        ];
      case 2: // Pizza Hut
        return [
          const MenuItemEntity(
            id: 201,
            restaurantId: 2,
            name: 'Pizza Hải Sản Đặc Biệt',
            description: 'Pizza với tôm, mực, nghêu và phô mai mozzarella',
            price: 199000,
            image:
                'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=200',
            status: MenuItemStatus.available,
          ),
          const MenuItemEntity(
            id: 202,
            restaurantId: 2,
            name: 'Pizza Pepperoni',
            description: 'Pizza truyền thống với xúc xích pepperoni',
            price: 159000,
            image:
                'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=200',
            status: MenuItemStatus.available,
          ),
          const MenuItemEntity(
            id: 203,
            restaurantId: 2,
            name: 'Gà Nướng BBQ',
            description: 'Gà nướng BBQ với sốt đặc biệt',
            price: 129000,
            image:
                'https://images.unsplash.com/photo-1598103442097-8b74394b95c6?w=200',
            status: MenuItemStatus.soldOut,
          ),
        ];
      case 3: // Lotteria
        return [
          const MenuItemEntity(
            id: 301,
            restaurantId: 3,
            name: 'Bulgogi Burger',
            description: 'Burger thịt nướng Hàn Quốc với sốt bulgogi',
            price: 65000,
            image:
                'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=200',
            status: MenuItemStatus.available,
          ),
          const MenuItemEntity(
            id: 302,
            restaurantId: 3,
            name: 'Chicken Tender',
            description: 'Gà chiên giòn kiểu Hàn Quốc với sốt cay ngọt',
            price: 55000,
            image:
                'https://images.unsplash.com/photo-1562967914-608f82629710?w=200',
            status: MenuItemStatus.available,
          ),
        ];
      case 4: // Phở Hòa
        return [
          const MenuItemEntity(
            id: 401,
            restaurantId: 4,
            name: 'Phở Bò Tái',
            description: 'Phở bò với thịt tái mềm ngon',
            price: 55000,
            image:
                'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?w=200',
            status: MenuItemStatus.available,
          ),
          const MenuItemEntity(
            id: 402,
            restaurantId: 4,
            name: 'Phở Gà',
            description: 'Phở gà truyền thống với thịt gà thơm ngon',
            price: 50000,
            image:
                'https://images.unsplash.com/photo-1559054663-e8239f818b76?w=200',
            status: MenuItemStatus.available,
          ),
        ];
      case 5: // Highlands Coffee
        return [
          const MenuItemEntity(
            id: 501,
            restaurantId: 5,
            name: 'Cà Phê Sữa Đá',
            description: 'Cà phê phin truyền thống với sữa đặc',
            price: 35000,
            image:
                'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=200',
            status: MenuItemStatus.available,
          ),
          const MenuItemEntity(
            id: 502,
            restaurantId: 5,
            name: 'Bánh Croissant',
            description: 'Bánh croissant bơ thơm giòn',
            price: 25000,
            image:
                'https://images.unsplash.com/photo-1549497538-303791108f95?w=200',
            status: MenuItemStatus.available,
          ),
        ];
      case 6: // Bánh Mì Huỳnh Hoa
        return [
          const MenuItemEntity(
            id: 601,
            restaurantId: 6,
            name: 'Bánh Mì Thập Cẩm',
            description: 'Bánh mì với jambon, chả lụa, pate và rau thơm',
            price: 25000,
            image:
                'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=200',
            status: MenuItemStatus.available,
          ),
          const MenuItemEntity(
            id: 602,
            restaurantId: 6,
            name: 'Bánh Mì Gà Nướng',
            description: 'Bánh mì với gà nướng và rau củ tươi ngon',
            price: 30000,
            image:
                'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=200',
            status: MenuItemStatus.available,
          ),
        ];
      default:
        return [];
    }
  }
}
