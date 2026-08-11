import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Page-adapter form for restaurant ratings.
///
/// It owns only ephemeral text/rating input state. Submission is delegated to
/// the page's ViewModel callback, keeping Gateway access out of the widget.
class RestaurantRatingBottomSheet extends StatefulWidget {
  const RestaurantRatingBottomSheet({
    super.key,
    required this.restaurantName,
    required this.onSubmit,
  });

  final String restaurantName;
  final Future<String?> Function(int rating, String comment) onSubmit;

  @override
  State<RestaurantRatingBottomSheet> createState() =>
      _RestaurantRatingBottomSheetState();
}

class _RestaurantRatingBottomSheetState
    extends State<RestaurantRatingBottomSheet> {
  int _rating = 5;
  final TextEditingController _commentController = TextEditingController();
  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submitRating() async {
    if (_isSubmitting) return;
    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });
    final error = await widget.onSubmit(
      _rating,
      _commentController.text.trim(),
    );
    if (!mounted) return;
    if (error == null) {
      Navigator.pop(context, true);
      return;
    }
    setState(() {
      _isSubmitting = false;
      _errorMessage = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16.w,
        right: 16.w,
        top: 24.w,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Đánh giá Nhà hàng',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: colors.onSurface,
              ),
            ),
            SizedBox(height: 8.w),
            Text(
              widget.restaurantName,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: colors.primary,
              ),
            ),
            SizedBox(height: 24.w),
            RatingBar.builder(
              initialRating: 5,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
              itemBuilder: (context, _) =>
                  const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) =>
                  setState(() => _rating = rating.toInt()),
            ),
            SizedBox(height: 24.w),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Nhà hàng chuẩn bị món có ngon không?',
                hintStyle: TextStyle(color: colors.onSurfaceVariant),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            if (_errorMessage != null) ...[
              SizedBox(height: 12.w),
              Text(
                _errorMessage!,
                style: TextStyle(color: colors.error),
                textAlign: TextAlign.center,
              ),
            ],
            SizedBox(height: 24.w),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitRating,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: colors.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isSubmitting
                    ? CircularProgressIndicator(color: colors.onPrimary)
                    : Text(
                        'Gửi đánh giá',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 32.w),
          ],
        ),
      ),
    );
  }
}
