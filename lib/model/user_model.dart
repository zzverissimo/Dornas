class AppUser {

  final String id;
  final String email;
  final String? displayName;
  // final String? photoUrl;
  // final bool canCreateEvents;

  AppUser({
    required this.id,
    required this.email,
    this.displayName,
    // this.photoUrl,
    // required this.canCreateEvents,
  });



  factory AppUser.fromFirestore(Map<String, dynamic> data) {
    return AppUser(
      id: data['id'] as String,
      email: data['email'] as String,
      displayName: data['displayName'] as String?,
      // photoUrl: data['photoUrl'] as String?,
      // canCreateEvents: data['canCreateEvents'] as bool,
    );
  }



  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      // 'photoUrl': photoUrl,
      // 'canCreateEvents': canCreateEvents,
    };
  }
}
