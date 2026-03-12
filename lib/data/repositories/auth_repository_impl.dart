import 'package:dartz/dartz.dart';
import 'package:task_project/core/errors/exceptions.dart';
import 'package:task_project/core/errors/failures.dart';
import 'package:task_project/core/network/network_info.dart';
import 'package:task_project/data/datasources/local/auth_local_datasource.dart';
import 'package:task_project/data/datasources/remote/auth_remote_datasource.dart';
import 'package:task_project/domain/entities/user_entity.dart';
import 'package:task_project/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  AuthRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, UserEntity>> login(
    String username,
    String password,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }
    try {
      final user = await _remoteDataSource.login(username, password);
      await _localDataSource.cacheUser(user);
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCachedUser() async {
    try {
      final user = _localDataSource.getCachedUser();
      return Right(user);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _localDataSource.clearCache();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }
}
