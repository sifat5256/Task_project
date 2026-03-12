import 'package:dartz/dartz.dart';
import 'package:task_project/core/errors/failures.dart';
import 'package:task_project/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(String username, String password);
  Future<Either<Failure, UserEntity>> getCachedUser();
  Future<Either<Failure, void>> logout();
}
