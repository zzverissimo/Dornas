import 'package:dornas_app/model/event_model.dart';
import 'package:dornas_app/viewmodel/calendar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllEventsScreen extends StatelessWidget {
  const AllEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final eventViewModel = Provider.of<CalendarViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontFamily: 'Inter',
        )
      ),
      body: StreamBuilder<List<Event>>(
        stream: eventViewModel.getEventsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay eventos'));
          }
          final events = snapshot.data!;
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return Card(
                child: ListTile(
                  titleTextStyle: const TextStyle(
                            color: Color.fromARGB(255, 88, 123, 182),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter'
                          ),
                  title: Text(event.title),
                  subtitle: Text(
                      style: const TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter'),
                    'Fecha: ${event.date.day}/${event.date.month}/${event.date.year}\nHora: ${event.date.hour}:${event.date.minute.toString().padLeft(2, '0')}\nMáximo de asistentes: ${event.maxAttendees}\nAsistentes actuales: ${event.attendees.length}',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
