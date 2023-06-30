class FieldValidators {
  String? emailValidate(String? value) {
    if (value?.isEmpty ?? true) {
      return "Email is required";
    }
    if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!)) {
      return "Invalid email address";
    }
    return null;
  }

  String? passwordValidate(String? value) {
    if (value?.isEmpty ?? true) {
      return "Password is required";
    }
    if (value!.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null;
  }
}
