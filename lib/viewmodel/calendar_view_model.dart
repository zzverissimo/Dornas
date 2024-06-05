


import 'package:dornas_app/model/event_model.dart';
import 'package:dornas_app/services/event_service.dart';
import 'package:flutter/material.dart';

class CalendarViewModel extends ChangeNotifier {
  final EventService _eventService = EventService();

  List<Event> _events = [];
  List<Event> get events => _events;

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

  Future<void> addEvent(Event event) async {
    setLoading(true);
    setMessage(null);

    try {
      await _eventService.addEvent(event);
      _events.add(event);
      notifyListeners();
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
      _events.removeWhere((event) => event.id == eventId);
      notifyListeners();
    } catch (e) {
      setMessage(e.toString());
    } finally {
      setLoading(false);
    }
  }
}
