import 'package:dartz/dartz.dart';
import 'package:task_project/core/errors/failures.dart';
import 'package:task_project/domain/entities/post_entity.dart';
import 'package:task_project/domain/repositories/post_repository.dart';

class GetPostsUseCase {
  final PostRepository _repository;

  GetPostsUseCase(this._repository);

  Future<Either<Failure, List<PostEntity>>> call(int limit, int skip) {
    return _repository.getPosts(limit, skip);
  }
}
