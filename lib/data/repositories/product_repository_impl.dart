import 'package:dartz/dartz.dart';
import 'package:task_project/core/errors/exceptions.dart';
import 'package:task_project/core/errors/failures.dart';
import 'package:task_project/core/network/network_info.dart';
import 'package:task_project/data/datasources/remote/product_remote_datasource.dart';
import 'package:task_project/domain/entities/product_entity.dart';
import 'package:task_project/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  ProductRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts(
    int limit,
    int skip,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }
    try {
      final products = await _remoteDataSource.getProducts(limit, skip);
      return Right(products);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
