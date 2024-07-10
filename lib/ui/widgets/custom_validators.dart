String? emailValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Introduce tu email, el campo está vacío';
  }
  // Verifica que el email tenga el formato correcto
  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
    return 'Por favor, introduce un email válido';
  }
  // Verifica que el email termine con uno de los dominios permitidos
  if (!value.endsWith('@gmail.com') && !value.endsWith('@hotmail.com')) {
    return 'El email no termina en @gmail.com, @hotmail.com';
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

String? confirmPasswordValidator(String? value, String password) {
  if (value == null || value.trim().isEmpty) {
    return 'Introduce tu contraseña, el campo está vacío';
  }
  if (value != password) {
    return 'Las contraseñas no coinciden';
  }
  return null;
}
