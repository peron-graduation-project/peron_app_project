class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "البريد الإلكتروني مطلوب";
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
      return "البريد الإلكتروني غير صالح";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.length < 6) return "كلمة المرور يجب أن تكون 6 أحرف على الأقل";
    return null;
  }
}
