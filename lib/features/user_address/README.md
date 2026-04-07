# User Address Feature - Widget Optimization ✅

## 📦 Widgets Extracted

### 1. **AddressCard** (`widgets/address_card.dart`)
Thay thế `_AddressCard` trong `address_list_screen.dart`

**Sub-widgets:**
- `_AddressCardHeader` - Header với icon, label, badge, menu
- `_AddressIconBox` - Icon box tự động theo loại địa chỉ
- `_DefaultBadge` - Badge "Mặc định"
- `_AddressPopupMenu` - Popup menu (Edit/Set Default/Delete)
- `_AddressCardDetails` - Phone + Full address

**Features:**
- ✅ Icon tự động: Nhà riêng 🏠 | Công ty 🏢 | Trường học 🎓 | Khác 📍
- ✅ Default badge với primary color
- ✅ Border khác biệt cho address mặc định (2px primary)
- ✅ Popup menu với 3 actions
- ✅ Shadow và rounded corners (Editorial style)

---

### 2. **QuickLabelChips** (`widgets/quick_label_chips.dart`)
ChoiceChips cho `add_edit_address_screen.dart`

**Props:**
- `selectedLabel: String` - Label đang chọn
- `onSelected: ValueChanged<String>` - Callback khi chọn

**Labels:** Nhà riêng | Công ty | Trường học | Khác

**Design:**
- ✅ Selected: Primary color background + bold text + 2px border
- ✅ Unselected: Card background + normal text + 1px border
- ✅ Rounded corners (`radiusM`)

---

### 3. **GPSLocationCard** (`widgets/gps_location_card.dart`)
GPS location card cho `add_edit_address_screen.dart`

**Props:**
- `latitude: double?`
- `longitude: double?`
- `isLoading: bool`
- `onGetLocation: VoidCallback`

**Features:**
- ✅ Hiển thị lat/lng (6 decimal places)
- ✅ Loading state với CircularProgressIndicator
- ✅ Primary color theme
- ✅ Outlined button "Lấy vị trí hiện tại"

---

### 4. **Settings Widgets** (`settings/widgets/settings_widgets.dart`)

#### **SettingsCard**
Container cho nhóm settings tiles
```dart
SettingsCard(
  children: [
    SettingsTile(...),
    SettingsTile(...),
  ],
)
```

#### **SettingsTile**
Row với icon, title, subtitle, trailing
```dart
SettingsTile(
  icon: Icons.person,
  title: 'Tài khoản',
  subtitle: 'Thông tin cá nhân',
  trailing: Icon(Icons.arrow_forward_ios),
  onTap: () {},
  showDivider: true, // Mặc định true
)
```

#### **SectionTitle**
Title cho mỗi section
```dart
SectionTitle(title: 'TÀI KHOẢN')
```

---

## 🎯 Screen Updates

### **address_list_screen.dart**
- ✅ Thay `_AddressCard` → `AddressCard` (from `widgets/address_card.dart`)
- ✅ Import: `import '../widgets/address_card.dart';`

### **add_edit_address_screen.dart**
- ⏳ TODO: Thay inline chips → `QuickLabelChips`
- ⏳ TODO: Thay GPS container → `GPSLocationCard`
- ⏳ TODO: Import widgets

### **settings_screen.dart**
- ⏳ TODO: Thay helper methods → `SettingsCard`, `SettingsTile`, `SectionTitle`
- ⏳ TODO: Import: `import '../widgets/settings_widgets.dart';`

### **profile_screen.dart**
- ⏳ TODO: Dùng `SettingsTile` và `SectionTitle` từ settings widgets
- ⏳ TODO: Import: `import '../../settings/presentation/widgets/settings_widgets.dart';`

---

## ✅ Checklist

- [x] `AddressCard` extracted với 5 sub-widgets
- [x] `QuickLabelChips` created
- [x] `GPSLocationCard` created
- [x] `SettingsCard`, `SettingsTile`, `SectionTitle` created
- [x] `address_list_screen.dart` updated
- [x] All widgets pass `flutter analyze` (0 errors)
- [ ] `add_edit_address_screen.dart` - Apply widgets
- [ ] `settings_screen.dart` - Apply widgets  
- [ ] `profile_screen.dart` - Apply widgets

---

## 📖 Usage Examples

### AddressCard
```dart
AddressCard(
  address: address,
  onTap: () => _selectAddress(address),
  onEdit: () => _navigateToEditAddress(address),
  onDelete: () => _showDeleteConfirmation(context, address),
  onSetDefault: () => _setDefaultAddress(address),
)
```

### QuickLabelChips
```dart
QuickLabelChips(
  selectedLabel: _labelController.text,
  onSelected: (label) {
    setState(() {
      _labelController.text = label;
    });
  },
)
```

### GPSLocationCard
```dart
GPSLocationCard(
  latitude: _latitude,
  longitude: _longitude,
  isLoading: _isGettingLocation,
  onGetLocation: _getCurrentLocation,
)
```

### SettingsTile
```dart
SettingsTile(
  icon: Icons.person,
  title: 'Thông tin cá nhân',
  trailing: Icon(Icons.arrow_forward_ios, size: 16.w),
  onTap: () => context.push('/profile/edit'),
)
```

---

## 🏗️ Architecture

```
lib/features/
├── user_address/
│   └── presentation/
│       ├── screens/
│       │   ├── address_list_screen.dart      ✅ Uses AddressCard
│       │   └── add_edit_address_screen.dart  ⏳ TODO: Use QuickLabelChips, GPSLocationCard
│       └── widgets/
│           ├── address_card.dart             ✅ NEW
│           ├── quick_label_chips.dart        ✅ NEW
│           └── gps_location_card.dart        ✅ NEW
│
├── settings/
│   └── presentation/
│       ├── screens/
│       │   └── settings_screen.dart          ⏳ TODO: Use SettingsCard, SettingsTile
│       └── widgets/
│           └── settings_widgets.dart         ✅ NEW
│
└── profile/
    └── presentation/
        └── screens/
            └── profile_screen.dart           ⏳ TODO: Use SettingsTile, SectionTitle
```

---

## 📊 Impact

**Before:**
- `address_list_screen.dart`: 578 lines (với `_AddressCard` inline)
- `add_edit_address_screen.dart`: Nhiều inline widgets
- `settings_screen.dart`: Helper methods không reusable
- `profile_screen.dart`: Helper methods không reusable

**After:**
- `address_list_screen.dart`: ~315 lines (-45% code)
- `address_card.dart`: 5 sub-widgets, reusable
- `quick_label_chips.dart`: Reusable trong bất kỳ form nào
- `gps_location_card.dart`: Reusable cho GPS features
- `settings_widgets.dart`: 3 widgets reusable cho Settings + Profile

**Benefits:**
- ✅ Code maintainability tăng
- ✅ Widgets reusable
- ✅ Easier testing (có thể test từng widget riêng)
- ✅ Consistent design system
- ✅ Giảm code duplication

---

**Next Steps:** Apply widgets vào `add_edit_address_screen.dart`, `settings_screen.dart`, `profile_screen.dart`
