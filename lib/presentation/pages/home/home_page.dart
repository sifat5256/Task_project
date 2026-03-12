import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_project/core/theme/app_theme.dart';
import 'package:task_project/presentation/controllers/home_controller.dart';
import 'package:task_project/presentation/pages/posts/posts_page.dart';
import 'package:task_project/presentation/pages/products/products_page.dart';
import 'package:task_project/presentation/pages/settings/settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const _pages = <Widget>[
    ProductsPage(),
    PostsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBody: true,
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: _pages,
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          margin: EdgeInsets.fromLTRB(
            16.w, 0, 16.w, 16.h + MediaQuery.of(context).padding.bottom,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppTheme.radiusXL),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 24.r,
                offset: Offset(0, 8.h),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppTheme.radiusXL),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: colorScheme.surface.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(AppTheme.radiusXL),
                  border: Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _NavItem(
                      icon: Icons.shopping_bag_outlined,
                      activeIcon: Icons.shopping_bag_rounded,
                      label: 'Products',
                      isActive: controller.currentIndex.value == 0,
                      onTap: () => controller.changePage(0),
                      color: colorScheme.primary,
                      inactiveColor: colorScheme.onSurfaceVariant,
                    ),
                    _NavItem(
                      icon: Icons.article_outlined,
                      activeIcon: Icons.article_rounded,
                      label: 'Posts',
                      isActive: controller.currentIndex.value == 1,
                      onTap: () => controller.changePage(1),
                      color: colorScheme.primary,
                      inactiveColor: colorScheme.onSurfaceVariant,
                    ),
                    _NavItem(
                      icon: Icons.settings_outlined,
                      activeIcon: Icons.settings_rounded,
                      label: 'Settings',
                      isActive: controller.currentIndex.value == 2,
                      onTap: () => controller.changePage(2),
                      color: colorScheme.primary,
                      inactiveColor: colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final Color color;
  final Color inactiveColor;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
    required this.color,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 16.w : 12.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: isActive ? color.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: isActive ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isActive ? activeIcon : icon,
                color: isActive ? color : inactiveColor,
                size: 24.sp,
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: isActive
                  ? Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Text(
                        label,
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w600,
                          fontSize: 13.sp,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
