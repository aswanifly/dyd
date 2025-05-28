import 'package:intl/intl.dart';

class TrackOrderModel {
  final String currentStatus;
  final String bookingId;
  final String orderId;
  final List<TimelineEntry> timeline;

  TrackOrderModel({
    required this.currentStatus,
    required this.bookingId,
    required this.orderId,
    required this.timeline,
  });

  factory TrackOrderModel.fromJson(Map<String, dynamic> json) {
    return TrackOrderModel(
      currentStatus: json['currentStatus'] ?? 'Unknown',
      bookingId: json['bookingId'] ?? 'N/A',
      orderId: json['orderId'] ?? 'N/A',
      timeline: (json['timeline'] as List<dynamic>?)
              ?.map((item) => TimelineEntry.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class TimelineEntry {
  final String title;
  final String status;
  final DateTime? date;

  TimelineEntry({
    required this.title,
    required this.status,
    this.date,
  });

  factory TimelineEntry.fromJson(Map<String, dynamic> json) {
    return TimelineEntry(
      title: json['title'] ?? 'Unknown',
      status: json['status'] ?? 'Unknown',
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
    );
  }

  String get formattedDate => date != null
      ? DateFormat('MMM dd, yyyy HH:mm').format(date!.toLocal())
      : 'N/A';
}
