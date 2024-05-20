
String? emailValidator(String? value) {
  if (value == null || value.trim().isEmpty || !value.contains('@')) {
    return 'Por favor, introduce un email válido';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Introduce tu contraseña';
  }
  if (value.trim().length < 6) {
    return 'La contraseña debe tener al menos 6 caracteres';
  }
  bool hasNumber = value.contains(RegExp(r'\d'));
  bool hasUpperCase = value.contains(RegExp(r'[A-Z]'));
  bool hasSymbol = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  if (!hasUpperCase) {
    return 'La contraseña debe contener al menos una letra mayúscula';
  }
  if (!hasNumber) {
    return 'La contraseña debe contener al menos un número';
  }
  if (!hasSymbol) {
    return 'La contraseña debe contener al menos un símbolo';
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
