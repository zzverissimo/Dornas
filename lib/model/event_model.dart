import 'package:cloud_firestore/cloud_firestore.dart';

// Modelo para representar un evento
class Event {
  // Identificador único del evento
  final String id;
  // Título del evento
  final String title;
  // Fecha y hora del evento
  final DateTime date;
  // Número máximo de asistentes permitidos
  final int maxAttendees;
  // Lista de identificadores de los usuarios que asisten al evento
  final List<String> attendees;

  // Constructor de la clase Event, requiere todos los campos como parámetros
  Event({
    required this.id,
    required this.title,
    required this.date,
    required this.maxAttendees,
    required this.attendees,
  });

  // Fábrica para crear una instancia de Event a partir de un mapa de datos obtenido de Firestore
  factory Event.fromFirestore(Map<String, dynamic> data) {
    return Event(
      id: data['id'] as String, // Asigna el valor de 'id' desde los datos
      title:
          data['title'] as String, // Asigna el valor de 'title' desde los datos
      date: (data['date'] as Timestamp)
          .toDate(), // Convierte el Timestamp a DateTime
      maxAttendees: data['maxAttendees']
          as int, // Asigna el valor de 'maxAttendees' desde los datos
      attendees: List<String>.from(
          data['attendees']), // Crea una lista de 'attendees' desde los datos
    );
  }

  // Método para convertir la instancia de Event en un mapa de datos, útil para guardar en Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id, // Incluye el id del evento
      'title': title, // Incluye el título del evento
      'date': date, // Incluye la fecha del evento
      'maxAttendees': maxAttendees, // Incluye el número máximo de asistentes
      'attendees': attendees, // Incluye la lista de asistentes
    };
  }
}
