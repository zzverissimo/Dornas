import 'package:dornas_app/model/event_model.dart';
import 'package:dornas_app/services/event_service.dart';
import 'package:flutter/material.dart';

class CalendarViewModel extends ChangeNotifier {
  final EventService _eventService = EventService();

  List<Event> _events = [];
  List<Event> get events => _events;

  DateTime _selectedDay = DateTime.now();
  DateTime get selectedDay => _selectedDay;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void setSelectedDay(DateTime selectedDay) {
    _selectedDay = selectedDay;
    notifyListeners();
  }

  Future<void> fetchEvents() async {
    setLoading(true);
    setMessage(null);

    try {
      _events = await _eventService.getEvents();
      notifyListeners();
    } catch (e) {
      setMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Stream<List<Event>> getEventsStream() {
    return _eventService.getEventsStream().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Event.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<void> addEvent(Event event) async {
    setLoading(true);
    setMessage(null);

    try {
      await _eventService.addEvent(event);
    } catch (e) {
      setMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateEvent(Event event) async {
    setLoading(true);
    setMessage(null);

    try {
      await _eventService.updateEvent(event);
    } catch (e) {
      setMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteEvent(String eventId) async {
    setLoading(true);
    setMessage(null);

    try {
      await _eventService.deleteEvent(eventId);
    } catch (e) {
      setMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }
}
