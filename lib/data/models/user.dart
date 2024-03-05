/// Represents a User in the system.
class User {
  /// Username of the user.
  final String username;

  /// Password of the user.
  final String password;

  /// Email of the user (optional).
  final String? email;

  /// Confirmation password (optional).
  final String? confirmPassword;

  /// Constructor for creating a User object.
  User({
    required this.username,
    required this.password,
    this.email,
    this.confirmPassword,
  });

  /// Converts the User object to a Map.
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'email': email,
      'confirmPassword': confirmPassword,
    };
  }

  /// Factory constructor for creating a User object from a Map.
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      password: map['password'],
      email: map['email'],
      confirmPassword: map['confirmPassword'],
    );
  }
}
