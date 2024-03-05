import '../../data/models/user.dart';
import '../../data/repositories/user_repository.dart';

/// Use case for user login.
class LoginUseCase {
  final UserRepository userRepository;

  /// Constructor for the use case.
  LoginUseCase(this.userRepository);

  /// Executes the use case by attempting to log in the user with the provided username and password.
  Future<User?> execute(String username, String password) async {
    return await userRepository.loginUser(username, password);
  }
}
