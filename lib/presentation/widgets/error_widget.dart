import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const AppErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: ShakeX(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Container(
            padding: EdgeInsets.all(32.w),
            decoration: BoxDecoration(
              color: colorScheme.error.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(
                color: colorScheme.error.withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Pulse(
                  infinite: true,
                  duration: const Duration(seconds: 2),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    size: 64.sp,
                    color: colorScheme.error,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: colorScheme.error,
                      ),
                ),
                SizedBox(height: 24.h),
                OutlinedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colorScheme.error,
                    side: BorderSide(color: colorScheme.error),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 12.h,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
