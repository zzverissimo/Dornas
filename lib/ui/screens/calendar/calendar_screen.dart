import 'package:dornas_app/model/event_model.dart';
import 'package:dornas_app/ui/screens/calendar/allevents_screen.dart';
import 'package:dornas_app/ui/screens/calendar/event_screen.dart';
import 'package:dornas_app/ui/screens/calendar/userlist_screen.dart';
import 'package:dornas_app/viewmodel/auth_view_model.dart';
import 'package:dornas_app/viewmodel/calendar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() {
    return _CalendarScreenState();
  }
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
        backgroundColor: const Color.fromARGB(255, 144, 184, 253),
        titleTextStyle: const TextStyle(
          color: Colors.white ,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Georgia'
          ),
        title: const Text('Calendario'),
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.list),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AllEventsScreen()),
            );
          },
        ),
      ),
      body: StreamBuilder<List<Event>>(
        stream: eventViewModel.getEventsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final events = snapshot.data ?? [];

          return Column(
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
                    eventViewModel.setSelectedDay(selectedDay);
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
                eventLoader: (day) {
                  return events.where((event) => isSameDay(event.date, day)).toList();
                },
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, day, events) {
                    if (events.isNotEmpty) {
                      return Positioned(
                        bottom: 4.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(events.length > 3 ? 3 : events.length, (index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 1.5),
                              width: 5.0,
                              height: 5.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                            );
                          }),
                        ),
                      );
                    }
                    return null;
                  },
                ),
                calendarStyle: const CalendarStyle(
                // Cambia el estilo de los días seleccionados
                selectedDecoration: BoxDecoration(
                  color: Color.fromARGB(255, 144, 184, 253), // Cambia este color al que desees
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(
                  color: Colors.white, // Color del texto del día seleccionado
                ),
                // Cambia el estilo de los días actuales
                todayDecoration: BoxDecoration(
                  color: Color.fromARGB(255, 182, 208, 254), // Cambia este color al que desees
                  shape: BoxShape.circle,
                ),
                todayTextStyle: TextStyle(
                  color: Colors.white, // Color del texto del día actual
                ),
              ),
              ),
              if (events.isEmpty)
                const Center(child: Text('No hay eventos')),
              Expanded(
                child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    if (!isSameDay(event.date, _selectedDay)) return Container();
                    return Dismissible(
                      key: Key(event.id),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) async {
                        bool canDeleteEvent = authViewModel.currentUser?.canCreateEvents ?? false;
                        if (canDeleteEvent) {
                          await eventViewModel.deleteEvent(event.id);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${event.title} eliminado')),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('No tienes permisos para eliminar eventos')),
                          );
                          setState(() {});
                        }
                      },
                      confirmDismiss: (direction) async {
                        bool canDeleteEvent = authViewModel.currentUser?.canCreateEvents ?? false;
                        if (!canDeleteEvent) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('No tienes permisos para eliminar eventos')),
                          );
                        }
                        return canDeleteEvent;
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
                          titleTextStyle: const TextStyle(
                            color: Color.fromARGB(255, 88, 123, 182),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter'
                          ),
                          subtitle: Text(
                            style: const TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter'),
                            'Fecha: ${event.date.day}/${event.date.month}/${event.date.year}\nHora: ${event.date.hour}:${event.date.minute.toString().padLeft(2, '0')}\nMáximo de asistentes: ${event.maxAttendees}\nAsistentes actuales: ${event.attendees.length}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  String userId = authViewModel.currentUser?.id ?? '';
                                  if (event.attendees.contains(userId)) {
                                    event.attendees.remove(userId);
                                    await eventViewModel.updateEvent(event);
                                    setState(() {});
                                  } else {
                                    if (event.attendees.length < event.maxAttendees) {
                                      event.attendees.add(userId);
                                      await eventViewModel.updateEvent(event);
                                      setState(() {});
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('El evento está completo')),
                                      );
                                    }
                                  }
                                },
                                child: Text(event.attendees.contains(authViewModel.currentUser?.id ?? '') ? 'Desanotarse' : 'Anotarse', style: const TextStyle( fontFamily: 'Inter',fontWeight: FontWeight.bold,color: Color.fromARGB(255, 88, 123, 182))),
                              ),
                              IconButton(
                                icon: const Icon(Icons.people),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => UserListScreen(eventId: event.id)),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool canCreateEvent = authViewModel.currentUser?.canCreateEvents ?? false;
          if (canCreateEvent) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateEventScreen(selectedDay: _selectedDay)),
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
