import 'package:dio/dio.dart';
import 'package:task_project/core/constants/api_constants.dart';
import 'package:task_project/core/errors/exceptions.dart';
import 'package:task_project/core/network/dio_client.dart';
import 'package:task_project/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String username, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _dioClient;

  AuthRemoteDataSourceImpl(this._dioClient);

  @override
  Future<UserModel> login(String username, String password) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.login,
        data: {
          'username': username,
          'password': password,
          'expiresInMins': 30,
        },
      );
      return UserModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data?['message'] as String? ??
            'An unexpected error occurred',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
