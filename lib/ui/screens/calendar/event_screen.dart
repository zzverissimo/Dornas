import 'package:dornas_app/model/event_model.dart';
import 'package:dornas_app/viewmodel/calendar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Pantalla para crear un evento
class CreateEventScreen extends StatelessWidget {
  final DateTime? selectedDay;
  CreateEventScreen({super.key, this.selectedDay});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _maxAttendeesController = TextEditingController();
  final TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final calendarViewModel = Provider.of<CalendarViewModel>(context);
    final DateTime eventDate = selectedDay ?? DateTime.now();

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
            TextField(
              controller: _maxAttendeesController,
              decoration: const InputDecoration(labelText: 'Número máximo de asistentes'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: _selectedTime,
                );

                if (pickedTime != null) {
                  final eventDateTime = DateTime(eventDate.year, eventDate.month, eventDate.day, pickedTime.hour, pickedTime.minute);
                  final event = Event(
                    id: DateTime.now().toString(),
                    title: _titleController.text,
                    date: eventDateTime,
                    maxAttendees: int.parse(_maxAttendeesController.text),
                    attendees: [],
                  );
                  await calendarViewModel.addEvent(event);
                  if (context.mounted){
                  Navigator.pop(context);
                  }
                }
              },
              child: const Text('Crear Evento'),
            ),
          ],
        ),
      ),
    );
  }
}
