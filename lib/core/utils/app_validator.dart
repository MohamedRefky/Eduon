class AppValidator {
  // ================= EMAIL =================
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please Enter Email';
    }

    final email = value.trim();

    if (!email.contains('@')) {
      return "Mast contain @ in email address";
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return 'Enter valid email (name@email.com)';
    }

    return null;
  }

  // ================= PASSWORD =================
  static String? password(String? value) {
    final v = value;

    if (v == null || v.trim().isEmpty) {
      return 'Please enter password';
    }

    if (v.contains(' ')) {
      return 'Password must not contain spaces';
    }

    if (v.trim().length < 6) {
      return 'Password at least 6 characters';
    }

    if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)').hasMatch(v)) {
      return 'Weak password. Use letters & numbers.';
    }

    return null;
  }

  // ================= FULL NAME =================
  static String? fullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter full name';
    }

    final name = value.trim();

    if (name.length < 3) {
      return 'Name is too short';
    }

    if (!RegExp(r"^[a-zA-Z\u0600-\u06FF\s]+$").hasMatch(name)) {
      return 'Name must contain letters only';
    }

    if (name.split(' ').where((e) => e.isNotEmpty).length < 2) {
      return 'Enter first & last name';
    }

    return null;
  }
}
