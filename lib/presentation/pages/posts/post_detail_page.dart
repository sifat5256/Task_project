import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_project/core/theme/app_theme.dart';
import 'package:task_project/domain/entities/post_entity.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final post = Get.arguments as PostEntity;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) =>
              AppTheme.primaryGradient.createShader(bounds),
          child: Text(
            'Post Detail',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              duration: const Duration(milliseconds: 400),
              from: 20,
              child: Text(
                post.title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            SizedBox(height: 16.h),

            // Reactions row
            FadeInUp(
              delay: const Duration(milliseconds: 280),
              duration: const Duration(milliseconds: 400),
              from: 20,
              child: Row(
                children: [
                  _ReactionChip(
                    icon: Icons.thumb_up_rounded,
                    label: '${post.reactions.likes}',
                    color: colorScheme.primary,
                  ),
                  SizedBox(width: 12.w),
                  _ReactionChip(
                    icon: Icons.thumb_down_rounded,
                    label: '${post.reactions.dislikes}',
                    color: colorScheme.error,
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.onSurfaceVariant.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 14.sp,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'User ${post.userId}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Gradient divider
            FadeInUp(
              delay: const Duration(milliseconds: 360),
              duration: const Duration(milliseconds: 400),
              from: 20,
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.outline.withValues(alpha: 0.0),
                      colorScheme.outline.withValues(alpha: 0.3),
                      colorScheme.outline.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Body content in a card
            FadeInUp(
              delay: const Duration(milliseconds: 440),
              duration: const Duration(milliseconds: 400),
              from: 20,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                  border: Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.15),
                  ),
                  boxShadow: [AppTheme.softShadow],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 4.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                            gradient: AppTheme.primaryGradient,
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Content',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      post.body,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(height: 1.7),
                    ),
                  ],
                ),
              ),
            ),

            // Tags section
            if (post.tags.isNotEmpty) ...[
              SizedBox(height: 24.h),
              FadeInUp(
                delay: const Duration(milliseconds: 520),
                duration: const Duration(milliseconds: 400),
                from: 20,
                child: Row(
                  children: [
                    Container(
                      width: 4.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        gradient: AppTheme.primaryGradient,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Tags',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              FadeInUp(
                delay: const Duration(milliseconds: 600),
                duration: const Duration(milliseconds: 400),
                from: 20,
                child: Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: post.tags.map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 7.h,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            colorScheme.primary.withValues(alpha: 0.1),
                            colorScheme.secondary.withValues(alpha: 0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: colorScheme.primary.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Text(
                        '#$tag',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.primary,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }
}

class _ReactionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _ReactionChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18.sp, color: color),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
