import 'package:equatable/equatable.dart';

/// Public campaign data returned by the Flash Sale service.
///
/// The backend currently exposes a recurring time window rather than a full
/// timestamp. Consumers must derive the local end instant instead of parsing
/// the wire value as an arbitrary DateTime.
final class FlashSaleCampaignEntity extends Equatable {
  const FlashSaleCampaignEntity({
    required this.id,
    required this.name,
    required this.isRecurring,
    required this.startTime,
    required this.endTime,
    required this.status,
  });

  final int id;
  final String name;
  final bool isRecurring;
  final String startTime;
  final String endTime;
  final String status;

  bool get isActive => status.toUpperCase() == 'ACTIVE';

  /// Resolves the end of the current occurrence in local time.
  DateTime? endAt([DateTime? now]) {
    final reference = now ?? DateTime.now();
    final fullDate = DateTime.tryParse(endTime)?.toLocal();
    if (fullDate != null) return fullDate;

    final parts = endTime.split(':');
    if (parts.length < 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    final second = parts.length > 2 ? int.tryParse(parts[2]) : 0;
    if (hour == null ||
        minute == null ||
        second == null ||
        hour < 0 ||
        hour > 23 ||
        minute < 0 ||
        minute > 59 ||
        second < 0 ||
        second > 59) {
      return null;
    }

    var resolved = DateTime(
      reference.year,
      reference.month,
      reference.day,
      hour,
      minute,
      second,
    );
    if (isRecurring && !resolved.isAfter(reference)) {
      resolved = resolved.add(const Duration(days: 1));
    }
    return resolved;
  }

  @override
  List<Object?> get props => [
    id,
    name,
    isRecurring,
    startTime,
    endTime,
    status,
  ];
}
