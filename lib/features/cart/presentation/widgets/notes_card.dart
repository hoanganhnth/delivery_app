import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Widget ghi chú trong checkout
class NotesCard extends StatelessWidget {
  final TextEditingController notesController;

  const NotesCard({
    super.key,
    required this.notesController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: TextFormField(
          controller: notesController,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText:
                'Ghi chú đặc biệt cho đơn hàng (ví dụ: không cay, giao tận tay...)',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
