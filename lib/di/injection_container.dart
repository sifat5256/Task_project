import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_project/core/network/dio_client.dart';
import 'package:task_project/core/network/network_info.dart';
import 'package:task_project/core/storage/local_storage_service.dart';
import 'package:task_project/data/datasources/local/auth_local_datasource.dart';
import 'package:task_project/data/datasources/remote/auth_remote_datasource.dart';
import 'package:task_project/data/datasources/remote/post_remote_datasource.dart';
import 'package:task_project/data/datasources/remote/product_remote_datasource.dart';
import 'package:task_project/data/repositories/auth_repository_impl.dart';
import 'package:task_project/data/repositories/post_repository_impl.dart';
import 'package:task_project/data/repositories/product_repository_impl.dart';
import 'package:task_project/domain/repositories/auth_repository.dart';
import 'package:task_project/domain/repositories/post_repository.dart';
import 'package:task_project/domain/repositories/product_repository.dart';
import 'package:task_project/domain/usecases/auth/get_cached_user_usecase.dart';
import 'package:task_project/domain/usecases/auth/login_usecase.dart';
import 'package:task_project/domain/usecases/auth/logout_usecase.dart';
import 'package:task_project/domain/usecases/posts/get_posts_usecase.dart';
import 'package:task_project/domain/usecases/products/get_products_usecase.dart';

Future<void> initDependencies() async {
  // ─── Core ────────────────────────────────────────────────
  final prefs = await SharedPreferences.getInstance();
  Get.put(LocalStorageService(prefs), permanent: true);

  Get.lazyPut<Connectivity>(() => Connectivity(), fenix: true);
  Get.lazyPut<NetworkInfo>(
    () => NetworkInfoImpl(Get.find<Connectivity>()),
    fenix: true,
  );
  Get.lazyPut<DioClient>(
    () => DioClient(Get.find<LocalStorageService>()),
    fenix: true,
  );

  // ─── Auth ────────────────────────────────────────────────
  Get.lazyPut<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(Get.find<DioClient>()),
    fenix: true,
  );
  Get.lazyPut<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(Get.find<LocalStorageService>()),
    fenix: true,
  );
  Get.lazyPut<AuthRepository>(
    () => AuthRepositoryImpl(
      Get.find<AuthRemoteDataSource>(),
      Get.find<AuthLocalDataSource>(),
      Get.find<NetworkInfo>(),
    ),
    fenix: true,
  );
  Get.lazyPut<LoginUseCase>(
    () => LoginUseCase(Get.find<AuthRepository>()),
    fenix: true,
  );
  Get.lazyPut<LogoutUseCase>(
    () => LogoutUseCase(Get.find<AuthRepository>()),
    fenix: true,
  );
  Get.lazyPut<GetCachedUserUseCase>(
    () => GetCachedUserUseCase(Get.find<AuthRepository>()),
    fenix: true,
  );

  // ─── Products ────────────────────────────────────────────
  Get.lazyPut<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(Get.find<DioClient>()),
    fenix: true,
  );
  Get.lazyPut<ProductRepository>(
    () => ProductRepositoryImpl(
      Get.find<ProductRemoteDataSource>(),
      Get.find<NetworkInfo>(),
    ),
    fenix: true,
  );
  Get.lazyPut<GetProductsUseCase>(
    () => GetProductsUseCase(Get.find<ProductRepository>()),
    fenix: true,
  );

  // ─── Posts ───────────────────────────────────────────────
  Get.lazyPut<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(Get.find<DioClient>()),
    fenix: true,
  );
  Get.lazyPut<PostRepository>(
    () => PostRepositoryImpl(
      Get.find<PostRemoteDataSource>(),
      Get.find<NetworkInfo>(),
    ),
    fenix: true,
  );
  Get.lazyPut<GetPostsUseCase>(
    () => GetPostsUseCase(Get.find<PostRepository>()),
    fenix: true,
  );
}
