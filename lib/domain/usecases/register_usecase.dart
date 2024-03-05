import '../../data/models/user.dart';
import '../../data/repositories/user_repository.dart';

/// Use case for user registration.
class RegisterUseCase {
  final UserRepository userRepository;

  /// Constructor for the use case.
  RegisterUseCase(this.userRepository);

  /// Executes the use case by registering the provided user.
  Future<void> execute(User user) async {
    await userRepository.registerUser(user);
  }
}
