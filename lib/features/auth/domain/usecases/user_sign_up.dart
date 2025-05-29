import 'package:bloc_app/core/failure/failure.dart';
import 'package:bloc_app/core/usecase/usecase.dart';
import 'package:bloc_app/core/common/entities/user.dart';
import 'package:bloc_app/features/auth/domain/repostiory/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;
  UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams Params) async {
    // TODO: implement call
    return await authRepository.signUpWithEmailPassword(
      name: Params.name,
      email: Params.email,
      password: Params.password,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;

  UserSignUpParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
