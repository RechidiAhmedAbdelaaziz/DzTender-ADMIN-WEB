extension Validators on String? {
  bool get isEmpty => this == null || this!.isEmpty;

  bool get isValidEmail {
    if (this == null) return false;
    final RegExp emailRegex =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(this!);
  }

  bool get isValidPassword {
    if (this == null) return false;
    // min = 8 , at least one uppercase letter, one lowercase letter, one number and one special character
    final RegExp passwordRegex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    return passwordRegex.hasMatch(this!);
  }

  bool get isValidPhoneNumber {
    if (this == null) return false;
    final RegExp phoneRegex = RegExp(r'^\d{11}$');
    return phoneRegex.hasMatch(this!);
  }

  bool get isValidLogin => isValidEmail || isValidPhoneNumber;
}