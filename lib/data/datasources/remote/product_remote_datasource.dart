import 'package:dio/dio.dart';
import 'package:task_project/core/constants/api_constants.dart';
import 'package:task_project/core/errors/exceptions.dart';
import 'package:task_project/core/network/dio_client.dart';
import 'package:task_project/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts(int limit, int skip);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final DioClient _dioClient;

  ProductRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<ProductModel>> getProducts(int limit, int skip) async {
    try {
      final response = await _dioClient.get(
        ApiConstants.products,
        queryParameters: {
          'limit': limit,
          'skip': skip,
        },
      );
      final data = response.data as Map<String, dynamic>;
      final productsJson = data['products'] as List<dynamic>;
      return productsJson
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] as String? ??
            'Failed to fetch products',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
