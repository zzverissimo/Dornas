import 'package:dornas_app/model/event_model.dart';
import 'package:dornas_app/viewmodel/calendar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateEventScreen extends StatelessWidget {
  CreateEventScreen({super.key});

  final TextEditingController _titleController = TextEditingController();
  final DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final calendarViewModel = Provider.of<CalendarViewModel>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Evento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título del Evento'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final event = Event(
                  id: DateTime.now().toString(),
                  title: _titleController.text,
                  date: _selectedDate,
                );
                await calendarViewModel.addEvent(event);
                Navigator.pop(context);
              },
              child: const Text('Crear Evento'),
            ),
          ],
        ),
      ),
    );
  }
}
