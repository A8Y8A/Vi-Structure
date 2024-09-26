// validators.dart
String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Name is required';
  } else if (value.length < 3) {
    return 'Name must be at least 3 characters long';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  } else if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  // else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$')
  //     .hasMatch(value)) {
  //   return 'Password must contain at least one letter and one number';
  // }
  return null;
}
