
String? emailValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Introduce tu email, el campo está vacío';
  }
  // Verifica que el email tenga el formato correcto
  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
    return 'Por favor, introduce un email válido';
  }
  // Verifica que el email contenga uno de los dominios permitidos
  if (!value.contains('@gmail.com') && !value.contains('@hotmail.com') && !value.contains('@outlook.com')) {
    return 'El email debe ser de dominio @gmail.com, @hotmail.com o @outlook.com';
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
  if (!hasUpperCase) {
    return 'La contraseña debe contener una letra mayúscula';
  }
  if (!hasNumber) {
    return 'La contraseña debe contener un número';
  }
  if (!hasSymbol) {
    return 'La contraseña debe contener un símbolo';
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
