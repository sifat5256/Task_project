import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_project/app/routes/app_routes.dart';
import 'package:task_project/domain/entities/user_entity.dart';
import 'package:task_project/domain/usecases/auth/get_cached_user_usecase.dart';
import 'package:task_project/domain/usecases/auth/login_usecase.dart';
import 'package:task_project/domain/usecases/auth/logout_usecase.dart';

class AuthController extends GetxController {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCachedUserUseCase _getCachedUserUseCase;

  AuthController(
    this._loginUseCase,
    this._logoutUseCase,
    this._getCachedUserUseCase,
  );

  late TextEditingController usernameController;
  late TextEditingController passwordController;

  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final Rxn<UserEntity> user = Rxn<UserEntity>();

  @override
  void onInit() {
    super.onInit();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    loadCachedUser();
  }

  Future<void> loadCachedUser() async {
    final result = await _getCachedUserUseCase();
    result.fold(
      (_) {},
      (cachedUser) => user.value = cachedUser,
    );
  }

  void resetFields() {
    usernameController.clear();
    passwordController.clear();
    errorMessage.value = '';
  }

  Future<void> login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      errorMessage.value = 'Username and password are required';
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();
    errorMessage.value = '';
    isLoading.value = true;

    final result = await _loginUseCase(username, password);
    result.fold(
      (failure) {
        errorMessage.value = failure.message;
      },
      (_) {
        Get.offAllNamed(AppRoutes.home);
      },
    );

    isLoading.value = false;
  }

  Future<void> logout() async {
    final result = await _logoutUseCase();
    result.fold(
      (failure) {
        errorMessage.value = failure.message;
      },
      (_) {
        Get.offAllNamed(AppRoutes.login);
      },
    );
  }
}
