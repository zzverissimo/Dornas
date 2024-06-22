import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String id;
  final String title;
  final DateTime date;
  final int maxAttendees;
  final List<String> attendees;

  Event({
    required this.id,
    required this.title,
    required this.date,
    required this.maxAttendees,
    required this.attendees,
  });

  factory Event.fromFirestore(Map<String, dynamic> data) {
    return Event(
      id: data['id'] as String,
      title: data['title'] as String,
      date: (data['date'] as Timestamp).toDate(),
      maxAttendees: data['maxAttendees'] as int,
      attendees: List<String>.from(data['attendees']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'maxAttendees': maxAttendees,
      'attendees': attendees,
    };
  }
}
