import 'package:dio/dio.dart';
import 'package:task_project/core/constants/api_constants.dart';
import 'package:task_project/core/errors/exceptions.dart';
import 'package:task_project/core/network/dio_client.dart';
import 'package:task_project/data/models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getPosts(int limit, int skip);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final DioClient _dioClient;

  PostRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<PostModel>> getPosts(int limit, int skip) async {
    try {
      final response = await _dioClient.get(
        ApiConstants.posts,
        queryParameters: {
          'limit': limit,
          'skip': skip,
        },
      );
      final data = response.data as Map<String, dynamic>;
      final postsJson = data['posts'] as List<dynamic>;
      return postsJson
          .map((json) => PostModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] as String? ??
            'Failed to fetch posts',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
