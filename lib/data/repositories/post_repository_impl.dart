import 'package:dartz/dartz.dart';
import 'package:task_project/core/errors/exceptions.dart';
import 'package:task_project/core/errors/failures.dart';
import 'package:task_project/core/network/network_info.dart';
import 'package:task_project/data/datasources/remote/post_remote_datasource.dart';
import 'package:task_project/domain/entities/post_entity.dart';
import 'package:task_project/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  PostRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<PostEntity>>> getPosts(
    int limit,
    int skip,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }
    try {
      final posts = await _remoteDataSource.getPosts(limit, skip);
      return Right(posts);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
