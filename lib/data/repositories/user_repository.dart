import '../models/user.dart';

/// An abstract class defining the interface for interacting with users in a repository.
abstract class UserRepository {
  /// Asynchronously registers a user.
  Future<void> registerUser(User user);

  /// Asynchronously logs in a user with the given username and password.
  /// Returns the logged-in user if successful, otherwise returns null.
  Future<User?> loginUser(String username, String password);

  /// Asynchronously logs out the current user.
  Future<void> logout();
}
