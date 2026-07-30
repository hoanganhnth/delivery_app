import 'package:delivery_app/features/orders/data/dtos/restaurant_rating_request_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/core/widgets/amber_widgets.dart';
import 'package:delivery_app/features/orders/domain/entities/order_entity.dart';
import 'package:delivery_app/features/orders/presentation/providers/ratings/restaurant_rating_submission_provider.dart';

class RestaurantRatingBottomSheet extends ConsumerStatefulWidget {
  final OrderEntity order;

  const RestaurantRatingBottomSheet({super.key, required this.order});

  @override
  ConsumerState<RestaurantRatingBottomSheet> createState() =>
      _RestaurantRatingBottomSheetState();
}

class _RestaurantRatingBottomSheetState
    extends ConsumerState<RestaurantRatingBottomSheet> {
  int _rating = 5;
  final TextEditingController _commentController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submitRating() async {
    if (_isSubmitting) return;
    final restaurantId = widget.order.restaurantId;
    final orderId = widget.order.id;
    if (restaurantId == null || orderId == null) {
      ToastUtils.showError(
        context,
        title: 'Lỗi',
        message: 'Không thể xác định đơn hàng cần đánh giá.',
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final request = RestaurantRatingRequestDto(
        orderId: orderId,
        rating: _rating,
        comment: _commentController.text.trim(),
      );

      await ref
          .read(restaurantRatingSubmissionProvider)
          .submit(restaurantId: restaurantId, request: request);

      if (mounted) {
        ToastUtils.showSuccess(
          context,
          title: 'Đánh giá',
          message:
              'Cảm ơn bạn đã đánh giá! Đánh giá sẽ được hiển thị sau khi được kiểm duyệt.',
        );
        Navigator.pop(context, true); // Return true indicating success
      }
    } catch (e) {
      if (mounted) {
        ToastUtils.showError(
          context,
          title: 'Lỗi',
          message: 'Đánh giá thất bại: ${e.toString()}',
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16.w,
        right: 16.w,
        top: 24.w,
      ),
      decoration: BoxDecoration(
        color: ref.colors.surface,
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
                color: ref.colors.textPrimary,
              ),
            ),
            SizedBox(height: 8.w),
            Text(
              widget.order.restaurantName ?? 'Nhà hàng',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: ref.colors.primary,
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
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating.toInt();
                });
              },
            ),
            SizedBox(height: 24.w),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Nhà hàng chuẩn bị món có ngon không?',
                hintStyle: TextStyle(color: ref.colors.textSecondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: ref.colors.primary),
                ),
              ),
            ),
            SizedBox(height: 24.w),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitRating,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ref.colors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isSubmitting
                    ? const CircularProgressIndicator(color: Colors.white)
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
