import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_project/core/theme/app_theme.dart';
import 'package:task_project/domain/entities/user_entity.dart';
import 'package:task_project/presentation/controllers/auth_controller.dart';
import 'package:task_project/core/theme/theme_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final themeController = Get.find<ThemeController>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) =>
              AppTheme.primaryGradient.createShader(bounds),
          child: Text(
            'Settings',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 100.h),
        children: [
          // ─── User Info Card ──────────────────────────
          Obx(() {
            final user = authController.user.value;
            if (user == null) return const SizedBox.shrink();
            return FadeInUp(
              duration: const Duration(milliseconds: 400),
              from: 20,
              child: _UserInfoCard(user: user),
            );
          }),
          SizedBox(height: 24.h),

          // ─── Theme Toggle ────────────────────────────
          FadeInRight(
            delay: const Duration(milliseconds: 100),
            duration: const Duration(milliseconds: 400),
            from: 30,
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                border: Border.all(
                  color: colorScheme.outline.withValues(alpha: 0.15),
                ),
                boxShadow: [AppTheme.softShadow],
              ),
              child: Obx(
                () {
                  final isDark = themeController.isDarkMode;
                  return InkWell(
                    borderRadius:
                        BorderRadius.circular(AppTheme.radiusLarge),
                    onTap: () => themeController.toggleTheme(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 16.h,
                      ),
                      child: Row(
                        children: [
                          // Icon
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            switchInCurve: Curves.easeOutBack,
                            switchOutCurve: Curves.easeIn,
                            transitionBuilder: (child, animation) =>
                                ScaleTransition(
                              scale: animation,
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            ),
                            child: Icon(
                              isDark
                                  ? Icons.dark_mode_rounded
                                  : Icons.light_mode_rounded,
                              key: ValueKey(isDark),
                              color: isDark
                                  ? const Color(0xFF94A3B8)
                                  : const Color(0xFFF59E0B),
                              size: 26.sp,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          // Text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isDark ? 'Dark Mode' : 'Light Mode',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium,
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  isDark
                                      ? 'Easier on the eyes'
                                      : 'Bright and clear',
                                  style:
                                      Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                          // Custom toggle track
                          _ThemeToggle(isDark: isDark),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // ─── App Info ────────────────────────────────
          FadeInRight(
            delay: const Duration(milliseconds: 200),
            duration: const Duration(milliseconds: 400),
            from: 30,
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                border: Border.all(
                  color: colorScheme.outline.withValues(alpha: 0.15),
                ),
                boxShadow: [AppTheme.softShadow],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 8.h,
                ),
                leading: Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.info_outline_rounded,
                    color: Colors.white,
                    size: 22.sp,
                  ),
                ),
                title: Text(
                  'App Version',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(
                  '1.0.0',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ),
          SizedBox(height: 32.h),

          // ─── Logout Button ───────────────────────────
          FadeInUp(
            delay: const Duration(milliseconds: 300),
            duration: const Duration(milliseconds: 400),
            from: 20,
            child: GestureDetector(
              onTap: () => _showLogoutDialog(context, authController),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                  border: Border.all(
                    color: colorScheme.error.withValues(alpha: 0.3),
                  ),
                  color: colorScheme.error.withValues(alpha: 0.05),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout_rounded,
                      color: colorScheme.error,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: colorScheme.error,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthController controller) {
    final colorScheme = Theme.of(context).colorScheme;

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusXL),
        ),
        title: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: colorScheme.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.logout_rounded,
                color: colorScheme.error,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            const Text('Logout'),
          ],
        ),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.logout();
            },
            style: TextButton.styleFrom(
              foregroundColor: colorScheme.error,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

class _UserInfoCard extends StatelessWidget {
  final UserEntity user;

  const _UserInfoCard({required this.user});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusXL),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.15),
        ),
        boxShadow: [AppTheme.softShadow],
      ),
      child: Column(
        children: [
          // Avatar with gradient ring
          Hero(
            tag: 'user_avatar',
            child: Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppTheme.primaryGradient,
              ),
              child: Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.surface,
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: user.image,
                    width: 80.w,
                    height: 80.w,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      width: 80.w,
                      height: 80.w,
                      color: colorScheme.surfaceContainerHighest,
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      width: 80.w,
                      height: 80.w,
                      color: colorScheme.surfaceContainerHighest,
                      child: Icon(
                        Icons.person,
                        size: 40.sp,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Name
          Text(
            '${user.firstName} ${user.lastName}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 4.h),

          // Username with gradient
          ShaderMask(
            shaderCallback: (bounds) =>
                AppTheme.primaryGradient.createShader(bounds),
            child: Text(
              '@${user.username}',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 4.h),

          // Email
          Text(
            user.email,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  final bool isDark;

  const _ThemeToggle({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: 56.w,
      height: 30.h,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        gradient: isDark
            ? const LinearGradient(
                colors: [Color(0xFF1E293B), Color(0xFF475569)],
              )
            : const LinearGradient(
                colors: [Color(0xFF93C5FD), Color(0xFF3B82F6)],
              ),
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 24.w,
          height: 24.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                key: ValueKey(isDark),
                size: 14.sp,
                color: isDark ? const Color(0xFF475569) : const Color(0xFFF59E0B),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
