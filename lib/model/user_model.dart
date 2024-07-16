// Define la clase AppUser para modelar usuarios de la aplicación
class AppUser {
  // Identificador único del usuario
  final String id;
  // Dirección de correo electrónico del usuario
  final String email;
  // Nombre para mostrar del usuario, puede ser nulo
  final String? displayName;
  // URL de la foto de perfil del usuario, puede ser nulo
  final String? photoUrl;
  // Indica si el usuario puede crear eventos, puede ser nulo
  final bool? canCreateEvents;

  // Constructor de la clase AppUser, inicializa todas las propiedades
  // Las propiedades displayName, photoUrl y canCreateEvents son opcionales
  AppUser({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.canCreateEvents,
  });

  // Método factory que crea una instancia de AppUser a partir de un mapa de datos
  // Este método se utiliza para crear un objeto AppUser a partir de los datos obtenidos de Firestore
  factory AppUser.fromFirestore(Map<String, dynamic> data) {
    return AppUser(
      id: data['id']
          as String, // Asigna el valor de 'id' desde el mapa de datos
      email: data['email']
          as String, // Asigna el valor de 'email' desde el mapa de datos
      displayName: data['displayName']
          as String?, // Asigna el valor de 'displayName' desde el mapa de datos, puede ser nulo
      photoUrl: data['photoUrl']
          as String?, // Asigna el valor de 'photoUrl' desde el mapa de datos, puede ser nulo
      canCreateEvents: data['canCreateEvents']
          as bool?, // Asigna el valor de 'canCreateEvents' desde el mapa de datos, puede ser nulo
    );
  }

  // Método que convierte un objeto AppUser en un mapa de datos
  // Este método se utiliza para guardar los datos del usuario en Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id, // Incluye el 'id' del usuario
      'email': email, // Incluye el 'email' del usuario
      'displayName':
          displayName, // Incluye el 'displayName' del usuario, puede ser nulo
      'photoUrl': photoUrl, // Incluye el 'photoUrl' del usuario, puede ser nulo
      'canCreateEvents':
          canCreateEvents, // Incluye el 'canCreateEvents' del usuario, puede ser nulo
    };
  }
}
