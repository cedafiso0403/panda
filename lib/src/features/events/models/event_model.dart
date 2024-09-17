import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String location;
  final String organizer;
  final String eventType;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.organizer,
    required this.eventType,
  });

  // Factory constructor to convert JSON into EventModel
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        // Convert Firestore-style timestamp to DateTime
        date: json['date'] != null
            ? (json['date'] is Timestamp)
                ? (json['date'] as Timestamp).toDate()
                : (json['date'] is Map && json['date']['_seconds'] != null)
                    ? DateTime.fromMillisecondsSinceEpoch(
                        json['date']['_seconds'] * 1000)
                    : DateTime.now()
            : DateTime.now(),
        location: json['location'],
        organizer: json['organizer'],
        eventType: json['eventType']);
  }

  // Convert EventModel to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toString(),
      'location': location,
      'organizer': organizer,
      'eventType': eventType,
    };
  }
}
