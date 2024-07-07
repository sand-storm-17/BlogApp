
import 'package:blog_app/core/errors/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignup implements UseCase<String, UserSignupParams> {
  final AuthRepository authRepository;
  const UserSignup(this.authRepository);
  @override
  Future<Either<Failure, String>> call(UserSignupParams params) async {
    return await authRepository.signupWithEmailPassword(
        name: params.name, email: params.email, password: params.password);
  }
}

class UserSignupParams {
  final String email;
  final String name;
  final String password;
  UserSignupParams(
      {required this.email, required this.name, required this.password});
}
