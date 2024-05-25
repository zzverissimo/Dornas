import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String id;
  final String title;
  final DateTime date;

  Event({required this.id, required this.title, required this.date});

  factory Event.fromFirestore(Map<String, dynamic> data) {

    return Event(
      id: data['id'] as String,
      title: data['title'] as String,
      date: (data['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
    };
  }
}
