import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// BottomSheet cho phép chọn lý do huỷ đơn hàng
class CancelOrderBottomSheet extends StatefulWidget {
  const CancelOrderBottomSheet({super.key});

  /// Hiển thị BottomSheet và trả về lý do huỷ (null nếu dismiss)
  static Future<String?> show(BuildContext context) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const CancelOrderBottomSheet(),
    );
  }

  @override
  State<CancelOrderBottomSheet> createState() => _CancelOrderBottomSheetState();
}

class _CancelOrderBottomSheetState extends State<CancelOrderBottomSheet> {
  static const _reasons = [
    'Đặt nhầm món / nhà hàng',
    'Thay đổi địa chỉ giao hàng',
    'Thời gian giao quá lâu',
    'Tìm được giá rẻ hơn',
    'Không liên lạc được shipper',
    'Lý do cá nhân',
  ];

  int? _selectedIndex;
  final _otherController = TextEditingController();
  bool _showOtherField = false;

  @override
  void dispose() {
    _otherController.dispose();
    super.dispose();
  }

  String? get _selectedReason {
    if (_selectedIndex == null) return null;
    if (_showOtherField) {
      final text = _otherController.text.trim();
      return text.isEmpty ? 'Lý do cá nhân' : text;
    }
    return _reasons[_selectedIndex!];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 12.w),
              width: 40.w,
              height: 4.w,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Title
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  const Icon(Icons.cancel_outlined, color: Colors.red),
                  SizedBox(width: 8.w),
                  Text(
                    'Chọn lý do huỷ đơn',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: Colors.grey.shade200),
            // Reason list
            ...List.generate(_reasons.length, (i) {
              final isLast = _reasons[i] == 'Lý do cá nhân';
              return RadioListTile<int>(
                value: i,
                groupValue: _selectedIndex,
                activeColor: Colors.red,
                title: Text(_reasons[i], style: TextStyle(fontSize: 14.sp)),
                onChanged: (v) {
                  setState(() {
                    _selectedIndex = v;
                    _showOtherField = isLast;
                  });
                },
              );
            }),
            // Other reason text field
            if (_showOtherField)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: TextField(
                  controller: _otherController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: 'Nhập lý do khác...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: EdgeInsets.all(12.w),
                  ),
                ),
              ),
            SizedBox(height: 16.w),
            // Buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Quay lại'),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _selectedIndex != null
                          ? () => Navigator.pop(context, _selectedReason)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Xác nhận huỷ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.w),
          ],
        ),
      ),
    );
  }
}
