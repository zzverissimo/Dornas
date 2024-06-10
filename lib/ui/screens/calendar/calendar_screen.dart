import 'package:dornas_app/ui/screens/calendar/event_screen.dart';
import 'package:dornas_app/viewmodel/auth_view_model.dart';
import 'package:dornas_app/viewmodel/calendar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CalendarViewModel>(context, listen: false).fetchEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final eventViewModel = Provider.of<CalendarViewModel>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario'),
        leading: const SizedBox.shrink(),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: eventViewModel.events.length,
              itemBuilder: (context, index) {
                final event = eventViewModel.events[index];
                return Dismissible(
                  key: Key(event.id),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) async {
                    bool canDelete = authViewModel.currentUser?.canCreateEvents ?? false;
                    if (!canDelete) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No tienes permisos para eliminar eventos')),
                      );
                      return false;
                    }
                    return true;
                  },
                  onDismissed: (direction) async {
                    await eventViewModel.deleteEvent(event.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${event.title} eliminado')),
                    );
                    setState(() {
                      eventViewModel.events.removeAt(index); // Eliminar el evento de la lista
                    });
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Card(
                    child: ListTile(
                      title: Text(event.title),
                      subtitle: Text(event.date.toString()),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool canCreateEvent = authViewModel.currentUser?.canCreateEvents ?? false;
          print(authViewModel.currentUser?.canCreateEvents);
          print("Esto es $canCreateEvent");
          print(authViewModel.getUserSession());
          if (canCreateEvent) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateEventScreen()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No tienes permisos para crear eventos')),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
