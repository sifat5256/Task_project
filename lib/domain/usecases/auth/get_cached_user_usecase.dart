import 'package:dartz/dartz.dart';
import 'package:task_project/core/errors/failures.dart';
import 'package:task_project/domain/entities/user_entity.dart';
import 'package:task_project/domain/repositories/auth_repository.dart';

class GetCachedUserUseCase {
  final AuthRepository _repository;

  GetCachedUserUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call() {
    return _repository.getCachedUser();
  }
}
