import 'package:get/get.dart';
import 'package:task_project/domain/usecases/auth/get_cached_user_usecase.dart';
import 'package:task_project/domain/usecases/auth/login_usecase.dart';
import 'package:task_project/domain/usecases/auth/logout_usecase.dart';
import 'package:task_project/presentation/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(
        Get.find<LoginUseCase>(),
        Get.find<LogoutUseCase>(),
        Get.find<GetCachedUserUseCase>(),
      ),
      fenix: true,
    );
  }
}
