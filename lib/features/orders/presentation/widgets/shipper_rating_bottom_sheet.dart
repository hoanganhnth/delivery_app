import 'package:delivery_app/core/theme/theme_extensions.dart';
import 'package:delivery_app/core/utils/screen_util_extensions.dart';
import 'package:delivery_app/features/orders/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShipperRatingBottomSheet extends ConsumerStatefulWidget {
  final int orderId;
  final int shipperId;

  const ShipperRatingBottomSheet({
    super.key,
    required this.orderId,
    required this.shipperId,
  });

  @override
  ConsumerState<ShipperRatingBottomSheet> createState() => _ShipperRatingBottomSheetState();
}

class _ShipperRatingBottomSheetState extends ConsumerState<ShipperRatingBottomSheet> {
  double _rating = 5.0;
  final _commentController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submitRating() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final repository = ref.read(orderRepositoryProvider);
      final result = await repository.rateShipper(
        widget.shipperId,
        widget.orderId,
        _rating.toInt(),
        _commentController.text,
      );

      result.fold(
        (failure) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(failure.message),
                backgroundColor: Colors.red,
              ),
            );
            setState(() {
              _isLoading = false;
            });
          }
        },
        (success) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Cảm ơn bạn đã đánh giá!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context, true); // Return true indicating success
          }
        },
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Có lỗi xảy ra: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = ref.colors;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: ResponsiveSize.m,
        right: ResponsiveSize.m,
        top: ResponsiveSize.m,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: colors.border,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: ResponsiveSize.m),
            Text(
              'Đánh giá Shipper',
              style: TextStyle(
                fontSize: ResponsiveSize.fontL,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
            SizedBox(height: ResponsiveSize.m),
            RatingBar.builder(
              initialRating: 5,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            SizedBox(height: ResponsiveSize.l),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Nhận xét của bạn (không bắt buộc)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ResponsiveSize.radiusM),
                ),
                contentPadding: EdgeInsets.all(ResponsiveSize.m),
              ),
              maxLines: 3,
            ),
            SizedBox(height: ResponsiveSize.l),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submitRating,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  padding: EdgeInsets.symmetric(vertical: ResponsiveSize.m),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ResponsiveSize.radiusM),
                  ),
                ),
                child: _isLoading
                    ? SizedBox(
                        height: 20.h,
                        width: 20.h,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Gửi đánh giá',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            SizedBox(height: ResponsiveSize.xl),
          ],
        ),
      ),
    );
  }
}
