import 'package:cloud_firestore/cloud_firestore.dart'; // Importa el paquete de Cloud Firestore

// Define la clase Message para modelar mensajes
class Message {
  // Identificador único del mensaje
  final String id;
  // Identificador del usuario que envía el mensaje
  final String senderId;
  // Texto del mensaje
  final String text;
  // Fecha y hora de envío del mensaje
  final DateTime timestamp;
  // Nombre de usuario del remitente
  final String username;
  // URL de la imagen del usuario
  final String userImage;
  // Lista de identificadores de usuarios que han eliminado el mensaje
  final List<String> deletedBy; // Nueva propiedad

  // Constructor de la clase Message, inicializa todas las propiedades
  Message({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.username,
    required this.userImage,
    required this.deletedBy, // Inicializar en el constructor
  });

  // Fábrica para crear una instancia de Message a partir de un mapa de datos de Firestore
  factory Message.fromFirestore(Map<String, dynamic> data) {
    return Message(
      id: data['id'] as String, // Asigna el valor de 'id'
      senderId: data['senderId'] as String, // Asigna el valor de 'senderId'
      text: data['text'] as String, // Asigna el valor de 'text'
      timestamp: (data['timestamp'] as Timestamp)
          .toDate(), // Convierte Timestamp a DateTime
      username: data['username'] as String, // Asigna el valor de 'username'
      userImage: data['userImage'] as String, // Asigna el valor de 'userImage'
      deletedBy: List<String>.from(data['deletedBy'] ??
          []), // Inicializa 'deletedBy', con valor por defecto si es nulo
    );
  }

  // Método para convertir la instancia de Message en un mapa de datos, útil para guardar en Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id, // Incluye el 'id' del mensaje
      'senderId': senderId, // Incluye el 'senderId'
      'text': text, // Incluye el 'text' del mensaje
      'timestamp': timestamp, // Incluye el 'timestamp' del mensaje
      'username': username, // Incluye el 'username' del remitente
      'userImage': userImage, // Incluye el 'userImage' del remitente
      'deletedBy': deletedBy, // Añade la lista 'deletedBy' al mapa
    };
  }
}
