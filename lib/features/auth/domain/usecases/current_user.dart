import 'package:bloc_app/core/failure/failure.dart';
import 'package:bloc_app/core/usecase/usecase.dart';
import 'package:bloc_app/core/common/entities/user.dart';
import 'package:bloc_app/features/auth/domain/repostiory/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<User , NoParams>{

  final AuthRepository authRepository;
  CurrentUser(this.authRepository);
  @override
  Future<Either<Failure, User>> call(NoParams Params) async {
    // TODO: implement call
    return await authRepository.currentUser();
  }
}


