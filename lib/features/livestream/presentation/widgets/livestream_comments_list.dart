import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../providers/interaction/livestream_interaction_state.dart';
import 'livestream_comment_item.dart';

class LivestreamCommentsList extends StatelessWidget {
  final LivestreamInteractionState interactionState;
  final ScrollController scrollController;

  const LivestreamCommentsList({
    super.key,
    required this.interactionState,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black,
              Colors.black,
            ],
            stops: const [0.0, 0.15, 1.0],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: interactionState.comments.isEmpty
            ? const SizedBox.shrink()
            : ListView.builder(
                controller: scrollController,
                itemCount: interactionState.comments.length,
                itemBuilder: (context, index) {
                  final comment = interactionState.comments[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: LivestreamCommentItem(comment: comment),
                  );
                },
              ),
      ),
    );
  }
}
