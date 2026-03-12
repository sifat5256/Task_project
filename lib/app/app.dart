import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => Obx(
        () => GetMaterialApp(
          title: 'Task Project',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.themeMode,
          initialRoute: AppRoutes.splash,
          getPages: AppPages.pages,
        ),
      ),
    );
  }

  void _setupErrorWidget() {
    if (kReleaseMode) {
      ErrorWidget.builder = (FlutterErrorDetails details) {
        return Material(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    size: 64.sp,
                    color: Colors.orange,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Something went wrong',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    details.exceptionAsString(),
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
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
