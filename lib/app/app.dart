import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_project/app/routes/app_pages.dart';
import 'package:task_project/app/routes/app_routes.dart';
import 'package:task_project/core/storage/local_storage_service.dart';
import 'package:task_project/core/theme/app_theme.dart';
import 'package:task_project/core/theme/theme_controller.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    _setupErrorWidget();

    final themeController = Get.put(
      ThemeController(Get.find<LocalStorageService>()),
    );

    return Obx(
      () => GetMaterialApp(
        title: 'Task Project',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.themeMode,
        initialRoute: AppRoutes.splash,
        getPages: AppPages.pages,
      ),
    );
  }

  void _setupErrorWidget() {
    if (kReleaseMode) {
      ErrorWidget.builder = (FlutterErrorDetails details) {
        return Material(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    size: 64,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Something went wrong',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    details.exceptionAsString(),
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      };
    }
  }
}
