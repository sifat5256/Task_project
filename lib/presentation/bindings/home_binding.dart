import 'package:get/get.dart';
import 'package:task_project/domain/usecases/auth/get_cached_user_usecase.dart';
import 'package:task_project/domain/usecases/auth/login_usecase.dart';
import 'package:task_project/domain/usecases/auth/logout_usecase.dart';
import 'package:task_project/domain/usecases/posts/get_posts_usecase.dart';
import 'package:task_project/domain/usecases/products/get_products_usecase.dart';
import 'package:task_project/presentation/controllers/auth_controller.dart';
import 'package:task_project/presentation/controllers/home_controller.dart';
import 'package:task_project/presentation/controllers/post_controller.dart';
import 'package:task_project/presentation/controllers/product_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AuthController>(
      () => AuthController(
        Get.find<LoginUseCase>(),
        Get.find<LogoutUseCase>(),
        Get.find<GetCachedUserUseCase>(),
      ),
    );
    Get.lazyPut<ProductController>(
      () => ProductController(Get.find<GetProductsUseCase>()),
    );
    Get.lazyPut<PostController>(
      () => PostController(Get.find<GetPostsUseCase>()),
    );
  }
}
