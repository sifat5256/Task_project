import 'package:task_project/core/constants/storage_keys.dart';
import 'package:task_project/core/errors/exceptions.dart';
import 'package:task_project/core/storage/local_storage_service.dart';
import 'package:task_project/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  UserModel getCachedUser();
  Future<void> clearCache();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final LocalStorageService _storageService;

  AuthLocalDataSourceImpl(this._storageService);

  @override
  Future<void> cacheUser(UserModel user) async {
    await _storageService.write(StorageKeys.user, user.toJsonString());
    await _storageService.write(StorageKeys.token, user.token);
  }

  @override
  UserModel getCachedUser() {
    final jsonString = _storageService.read(StorageKeys.user);
    if (jsonString == null) {
      throw const CacheException(message: 'No cached user found');
    }
    return UserModel.fromJsonString(jsonString);
  }

  @override
  Future<void> clearCache() async {
    await _storageService.delete(StorageKeys.user);
    await _storageService.delete(StorageKeys.token);
  }
}
