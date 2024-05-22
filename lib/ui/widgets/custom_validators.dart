
String? emailValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Introduce tu email, el campo está vacío';
  }
  if (value.trim().isEmpty || !value.contains('@gmail.com') || !value.contains('@hotmail.com') || !value.contains('@outlook.com')){
    return 'Por favor, introduce un email válido, verifica que contenga @gmail.com, @hotmail.com o @outlook.com';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Introduce tu contraseña, el campo está vacío';
  }
  if (value.trim().length < 6) {
    return 'La contraseña debe tener al menos 6 caracteres';
  }
  bool hasNumber = value.contains(RegExp(r'\d'));
  bool hasUpperCase = value.contains(RegExp(r'[A-Z]'));
  bool hasSymbol = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  if (!hasUpperCase || !hasNumber || !hasSymbol) {
    return 'La contraseña debe contener al menos una letra mayúscula, un número y un símbolo';
  }
  return null;
}

String? nameValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Introduce tu nombre';
  }
  if (value.trim().length < 3) {
    return 'El nombre debe tener al menos 3 caracteres';
  }
  if (RegExp(r'\d').hasMatch(value)) {
    return 'El nombre no puede contener números';
  }
  return null;
}
