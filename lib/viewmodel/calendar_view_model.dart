import 'package:dornas_app/model/event_model.dart';
import 'package:dornas_app/services/event_service.dart';
import 'package:flutter/material.dart';

// ViewModel para el calendario
class CalendarViewModel extends ChangeNotifier {
  final EventService _eventService = EventService();

  List<Event> _events = [];
  List<Event> get events => _events;

  DateTime _selectedDay = DateTime.now();
  DateTime get selectedDay => _selectedDay;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void setMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void setSelectedDay(DateTime selectedDay) {
    _selectedDay = selectedDay;
    notifyListeners();
  }

  // Obtiene una lista de eventos
  Future<void> fetchEvents() async {
    try {
      _events = await _eventService.getEvents();
      notifyListeners();
    } catch (e) {
      setMessage(e.toString());
    }
  }

  // Obtiene una transmisión de eventos
  Stream<List<Event>> getEventsStream() {
    return _eventService.getEventsStream().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Event.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Añade un evento
  Future<void> addEvent(Event event) async {
    try {
      await _eventService.addEvent(event);
      _events.add(event);
      notifyListeners();
    } catch (e) {
      setMessage(e.toString());
    }
  }

  // Actualiza un evento
  Future<void> updateEvent(Event event) async {
    try {
      await _eventService.updateEvent(event);
      final index = _events.indexWhere((e) => e.id == event.id);
      if (index != -1) {
        _events[index] = event;
        notifyListeners();
      }
    } catch (e) {
      setMessage(e.toString());
    }
  }

  // Elimina un evento
  Future<void> deleteEvent(String eventId) async {
    try {
      await _eventService.deleteEvent(eventId);
      _events.removeWhere((event) => event.id == eventId);
      notifyListeners();
    } catch (e) {
      setMessage(e.toString());
    }
  }

  // Elimina un usuario de todos los eventos
  Future<void> removeUserFromAllEvents(String userId) async {
    try {
      await _eventService.removeUserFromAllEvents(userId);
      _events = await _eventService.getEvents();
      notifyListeners();
    } catch (e) {
      setMessage(e.toString());
    }
  }
}
