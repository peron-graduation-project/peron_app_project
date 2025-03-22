class UserModel {
  final String? message;
  final String phoneNumber;
  final bool isAuthenticated;
  final String username;
  final String email;
  final List<String> roles;
  final String token;
  final List<String> errors;
  final String expiresOn;
  final String refreshTokenExpiration;

  UserModel({
    this.message,
    required this.phoneNumber,
    required this.isAuthenticated,
    required this.username,
    required this.email,
    required this.roles,
    required this.token,
    required this.errors,
    required this.expiresOn,
    required this.refreshTokenExpiration,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      message: json["message"],
      phoneNumber: json["phoneNumber"] ?? "",
      isAuthenticated: json["isAuthenticated"] ?? false,
      username: json["username"] ?? "",
      email: json["email"] ?? "",
      roles: _convertToListOfStrings(json["roles"]),
      token: json["token"] ?? "",
      errors: _convertToListOfStrings(json["errors"]),
      expiresOn: json["expiresOn"] ?? "",
      refreshTokenExpiration: json["refreshTokenExpiration"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "phoneNumber": phoneNumber,
      "isAuthenticated": isAuthenticated,
      "username": username,
      "email": email,
      "roles": roles,
      "token": token,
      "errors": errors,
      "expiresOn": expiresOn,
      "refreshTokenExpiration": refreshTokenExpiration,
    };
  }

  static List<String> _convertToListOfStrings(dynamic value) {
    if (value == null) return [];
    if (value is List) return value.map((e) => e.toString()).toList();
    if (value is String) return [value];
    if (value is Map) {
      return value.values
          .expand((e) => e is List ? e.map((x) => x.toString()) : [e.toString()])
          .toList();
    }
    return ["حدث خطأ غير متوقع"];
  }

  @override
  String toString() {
    return 'UserModel('
        'message: $message, '
        'phoneNumber: $phoneNumber, '
        'isAuthenticated: $isAuthenticated, '
        'username: $username, '
        'email: $email, '
        'roles: $roles, '
        'token: $token, '
        'errors: $errors, '
        'expiresOn: $expiresOn, '
        'refreshTokenExpiration: $refreshTokenExpiration)';
  }
}
