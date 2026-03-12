import 'package:dartz/dartz.dart';
import 'package:task_project/core/errors/failures.dart';
import 'package:task_project/domain/entities/post_entity.dart';

abstract class PostRepository {
  Future<Either<Failure, List<PostEntity>>> getPosts(int limit, int skip);
}
