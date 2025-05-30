import 'package:bloc_app/core/failure/failure.dart';
import 'package:bloc_app/core/usecase/usecase.dart';
import 'package:bloc_app/core/common/entities/user.dart';
import 'package:bloc_app/features/auth/domain/repostiory/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements UseCase<User , UserLoginParams>{
  final AuthRepository authRepository;
  const UserLogin(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await authRepository.loginWithEmailPassword(email: params.email, password: params.password);
  }
}

class UserLoginParams{
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}