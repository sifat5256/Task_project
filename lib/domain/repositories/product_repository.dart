import 'package:dartz/dartz.dart';
import 'package:task_project/core/errors/failures.dart';
import 'package:task_project/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts(int limit, int skip);
}
