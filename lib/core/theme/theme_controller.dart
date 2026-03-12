import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_project/core/constants/storage_keys.dart';
import 'package:task_project/core/storage/local_storage_service.dart';

class ThemeController extends GetxController {
  final LocalStorageService _storageService;

  ThemeController(this._storageService);

  final _themeMode = ThemeMode.light.obs;
  ThemeMode get themeMode => _themeMode.value;

  bool get isDarkMode => _themeMode.value == ThemeMode.dark;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  void _loadTheme() {
    final saved = _storageService.read(StorageKeys.themeMode);
    if (saved != null) {
      _themeMode.value = saved == ThemeMode.dark.name
          ? ThemeMode.dark
          : ThemeMode.light;
    }
  }

  Future<void> toggleTheme() async {
    final newMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    _themeMode.value = newMode;
    Get.changeThemeMode(newMode);
    await _storageService.write(StorageKeys.themeMode, newMode.name);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode.value = mode;
    Get.changeThemeMode(mode);
    await _storageService.write(StorageKeys.themeMode, mode.name);
  }
}
