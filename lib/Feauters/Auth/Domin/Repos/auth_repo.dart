import 'package:dartz/dartz.dart';
import 'package:fruits_app/Core/Errors/failure.dart';
import 'package:fruits_app/Feauters/Auth/Entity/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      String email, String password, String name);
}