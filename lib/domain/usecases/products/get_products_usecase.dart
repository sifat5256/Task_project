import 'package:dartz/dartz.dart';
import 'package:task_project/core/errors/failures.dart';
import 'package:task_project/domain/entities/product_entity.dart';
import 'package:task_project/domain/repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository _repository;

  GetProductsUseCase(this._repository);

  Future<Either<Failure, List<ProductEntity>>> call(int limit, int skip) {
    return _repository.getProducts(limit, skip);
  }
}
