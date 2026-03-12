import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_project/core/theme/app_theme.dart';
import 'package:task_project/domain/entities/product_entity.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with SingleTickerProviderStateMixin {
  late final ProductEntity product;
  late final AnimationController _priceController;
  late final Animation<double> _priceAnimation;

  @override
  void initState() {
    super.initState();
    product = Get.arguments as ProductEntity;
    _priceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _priceAnimation = Tween<double>(begin: 0, end: product.price).animate(
      CurvedAnimation(parent: _priceController, curve: Curves.easeOutCubic),
    );
    // Start price count-up after hero animation settles
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _priceController.forward();
    });
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ─── Collapsing Image App Bar ──────────────────
          SliverAppBar(
            expandedHeight: 300.h,
            pinned: true,
            stretch: true,
            backgroundColor: colorScheme.surface,
            leading: Padding(
              padding: EdgeInsets.all(8.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_new, size: 18.sp),
                      color: Colors.white,
                      onPressed: () => Get.back(),
                    ),
                  ),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'product_${product.id}',
                    child: CachedNetworkImage(
                      imageUrl: product.thumbnail,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(
                        color: colorScheme.surfaceContainerHighest,
                      ),
                      errorWidget: (_, __, ___) => Container(
                        color: colorScheme.surfaceContainerHighest,
                        child: Icon(Icons.broken_image, size: 48.sp),
                      ),
                    ),
                  ),
                  // Gradient overlay
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.6),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Price badge
                  Positioned(
                    bottom: 16.h,
                    right: 16.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: AnimatedBuilder(
                          animation: _priceAnimation,
                          builder: (context, child) => Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              '\$${_priceAnimation.value.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 22.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ─── Content ──────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
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
                      product.title,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Brand & Category row
                  FadeInUp(
                    delay: const Duration(milliseconds: 280),
                    duration: const Duration(milliseconds: 400),
                    from: 20,
                    child: Row(
                      children: [
                        if (product.brand.isNotEmpty) ...[
                          Icon(
                            Icons.storefront_outlined,
                            size: 16.sp,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            product.brand,
                            style:
                                Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          SizedBox(width: 16.w),
                        ],
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            gradient: AppTheme.primaryGradient,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            product.category,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Divider
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

                  // Description header
                  FadeInUp(
                    delay: const Duration(milliseconds: 440),
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
                          'Description',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Description body
                  FadeInUp(
                    delay: const Duration(milliseconds: 520),
                    duration: const Duration(milliseconds: 400),
                    from: 20,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusLarge),
                        border: Border.all(
                          color: colorScheme.outline.withValues(alpha: 0.15),
                        ),
                        boxShadow: [AppTheme.softShadow],
                      ),
                      child: Text(
                        product.description,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(height: 1.7),
                      ),
                    ),
                  ),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
