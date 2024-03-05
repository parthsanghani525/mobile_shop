import 'package:mobile_store/data/repositories/user_repository.dart';

/// Use case for user logout.
class LogoutUseCase {
  final UserRepository userRepository;

  /// Constructor for the use case.
  LogoutUseCase(this.userRepository);

  /// Executes the use case by logging out the current user.
  Future<void> execute() async {
    return await userRepository.logout();
  }
}
