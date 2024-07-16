import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dornas_app/model/event_model.dart';

class EventService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Añade un evento a Firestore
  Future<void> addEvent(Event event) async {
    await _firestore.collection('events').doc(event.id).set(event.toMap());
  }

  // Obtiene una lista de eventos desde Firestore
  Future<List<Event>> getEvents() async {
    QuerySnapshot snapshot = await _firestore.collection('events').get();
    return snapshot.docs
        .map((doc) => Event.fromFirestore(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Obtiene un evento por su identificador
  Stream<QuerySnapshot> getEventsStream() {
    return _firestore.collection('events').snapshots();
  }

  // Actualiza un evento en Firestore
  Future<void> updateEvent(Event event) async {
    await _firestore.collection('events').doc(event.id).update(event.toMap());
  }

  // Elimina un evento de Firestore
  Future<void> deleteEvent(String eventId) async {
    await _firestore.collection('events').doc(eventId).delete();
  }

  // Elimina un usuario de todos los eventos
  Future<void> removeUserFromAllEvents(String userId) async {
    QuerySnapshot snapshot = await _firestore.collection('events').get();
    for (var doc in snapshot.docs) {
      Event event = Event.fromFirestore(doc.data() as Map<String, dynamic>);
      event.attendees.remove(userId);
      await updateEvent(event);
    }
  }
}
