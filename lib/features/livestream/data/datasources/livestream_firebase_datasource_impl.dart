import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import '../dtos/livestream_comment_dto.dart';

/// Firebase datasource for livestream interactions
abstract class LivestreamFirebaseDataSource {
  /// Send comment to Firebase
  Future<Either<Exception, Unit>> sendComment(LivestreamCommentDto comment);

  /// Stream comments from Firebase
  Stream<Either<Exception, List<LivestreamCommentDto>>> streamComments(
    num livestreamId,
  );

  /// Send like to Firebase
  Future<Either<Exception, Unit>> sendLike(LivestreamLikeDto like);

  /// Stream likes from Firebase
  Stream<Either<Exception, List<LivestreamLikeDto>>> streamLikes(
    num livestreamId,
  );

  /// Get like count
  Future<Either<Exception, int>> getLikeCount(num livestreamId);
}

/// Firebase datasource implementation
class LivestreamFirebaseDataSourceImpl implements LivestreamFirebaseDataSource {
  final FirebaseFirestore _firestore;

  LivestreamFirebaseDataSourceImpl(this._firestore);

  @override
  Future<Either<Exception, Unit>> sendComment(LivestreamCommentDto comment) async {
    try {
      await _firestore
          .collection('livestreams')
          .doc(comment.livestreamId.toString())
          .collection('comments')
          .doc(comment.id)
          .set(comment.toJson());

      return right(unit);
    } catch (e) {
      return left(Exception('Failed to send comment: ${e.toString()}'));
    }
  }

  @override
  Stream<Either<Exception, List<LivestreamCommentDto>>> streamComments(
    num livestreamId,
  ) {
    try {
      return _firestore
          .collection('livestreams')
          .doc(livestreamId.toString())
          .collection('comments')
          .orderBy('timestamp', descending: false)
          .limit(100) // Limit to last 100 comments
          .snapshots()
          .map((snapshot) {
        try {
          final comments = snapshot.docs
              .map((doc) => LivestreamCommentDto.fromJson(doc.data()))
              .toList();
          return right<Exception, List<LivestreamCommentDto>>(comments);
        } catch (e) {
          return left<Exception, List<LivestreamCommentDto>>(
            Exception('Failed to parse comments: ${e.toString()}'),
          );
        }
      });
    } catch (e) {
      return Stream.value(
        left<Exception, List<LivestreamCommentDto>>(
          Exception('Failed to stream comments: ${e.toString()}'),
        ),
      );
    }
  }

  @override
  Future<Either<Exception, Unit>> sendLike(LivestreamLikeDto like) async {
    try {
      await _firestore
          .collection('livestreams')
          .doc(like.livestreamId.toString())
          .collection('likes')
          .doc(like.id)
          .set(like.toJson());

      return right(unit);
    } catch (e) {
      return left(Exception('Failed to send like: ${e.toString()}'));
    }
  }

  @override
  Stream<Either<Exception, List<LivestreamLikeDto>>> streamLikes(
    num livestreamId,
  ) {
    try {
      return _firestore
          .collection('livestreams')
          .doc(livestreamId.toString())
          .collection('likes')
          .orderBy('timestamp', descending: true)
          .limit(50) // Limit to last 50 likes
          .snapshots()
          .map((snapshot) {
        try {
          final likes = snapshot.docs
              .map((doc) => LivestreamLikeDto.fromJson(doc.data()))
              .toList();
          return right<Exception, List<LivestreamLikeDto>>(likes);
        } catch (e) {
          return left<Exception, List<LivestreamLikeDto>>(
            Exception('Failed to parse likes: ${e.toString()}'),
          );
        }
      });
    } catch (e) {
      return Stream.value(
        left<Exception, List<LivestreamLikeDto>>(
          Exception('Failed to stream likes: ${e.toString()}'),
        ),
      );
    }
  }

  @override
  Future<Either<Exception, int>> getLikeCount(num livestreamId) async {
    try {
      final snapshot = await _firestore
          .collection('livestreams')
          .doc(livestreamId.toString())
          .collection('likes')
          .count()
          .get();

      return right(snapshot.count ?? 0);
    } catch (e) {
      return left(Exception('Failed to get like count: ${e.toString()}'));
    }
  }
}
