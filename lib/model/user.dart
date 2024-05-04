class User {
  final String id;
  final String email;
  final password;
  final String? displayName;
  final String? photoUrl;

  User({
    required this.id,
    required this.email,
    required this.password,
    this.displayName,
    this.photoUrl,
  });

  // Constructor que permite crear un objeto User desde un documento de Firestore
  factory User.fromFirestore(Map<String, dynamic> firestore) {
    return User(
      id: firestore['id'] as String,
      email: firestore['email'] as String,
      password: firestore['password'] as String,
      displayName: firestore['displayName'] as String?,
      photoUrl: firestore['photoUrl'] as String?,
    );
  }

  // Método para convertir un objeto User a un Map, útil para enviar datos a Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'displayName': displayName,
      'photoUrl': photoUrl,
    };
  }
}