import 'package:bloc_app/core/failure/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase <SuccessType , Params>{
 Future<Either<Failure,SuccessType >> call(Params Params); 
}


class NoParams{

}