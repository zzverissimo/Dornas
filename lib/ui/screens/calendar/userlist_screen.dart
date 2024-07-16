import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dornas_app/model/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

// Muestra la lista de usuarios anotados en un evento
class UserListScreen extends StatelessWidget {
  final String eventId;
  const UserListScreen({super.key, required this.eventId});

  Future<List<AppUser>> _fetchUsers(List<String> userIds) async {
    List<AppUser> users = [];
    for (String userId in userIds) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (userSnapshot.exists) {
        users.add(AppUser.fromFirestore(userSnapshot.data() as Map<String, dynamic>));
      }
    }
    return users;
  }

  Future<String> _getUserPhotoUrl(String userId) async {
    return await FirebaseStorage.instance.ref('user_images/$userId.jpg').getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios anotados'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontFamily: 'Inter',
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('events').doc(eventId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('No hay usuarios anotados'));
          }
          List<String> userIds = List<String>.from(snapshot.data!['attendees']);
          return FutureBuilder<List<AppUser>>(
            future: _fetchUsers(userIds),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!userSnapshot.hasData || userSnapshot.data!.isEmpty) {
                return const Center(child: Text('No hay usuarios anotados'));
              }
              List<AppUser> users = userSnapshot.data!;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  AppUser user = users[index];
                  return FutureBuilder<String>(
                    future: _getUserPhotoUrl(user.id),
                    builder: (context, photoSnapshot) {
                      if (photoSnapshot.connectionState == ConnectionState.waiting) {
                        return ListTile(
                          title: Text(user.displayName ?? 'Usuario'),
                          leading: const CircularProgressIndicator(),
                        );
                      }
                      return ListTile(
                        title: Text(user.displayName ?? 'Usuario'),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(photoSnapshot.data ?? ''),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
