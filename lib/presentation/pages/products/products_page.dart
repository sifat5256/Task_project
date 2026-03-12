import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_project/app/routes/app_routes.dart';
import 'package:task_project/core/theme/app_theme.dart';
import 'package:task_project/domain/entities/product_entity.dart';
import 'package:task_project/presentation/controllers/product_controller.dart';
import 'package:task_project/presentation/widgets/empty_widget.dart';
import 'package:task_project/presentation/widgets/error_widget.dart';
import 'package:task_project/presentation/widgets/loading_widget.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();

    return Scaffold(
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) =>
              AppTheme.primaryGradient.createShader(bounds),
          child: Text(
            'Products',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const LoadingWidget(type: ShimmerType.product);
        }

        if (controller.hasError.value && controller.products.isEmpty) {
          return AppErrorWidget(
            message: controller.errorMessage.value,
            onRetry: controller.fetchProducts,
          );
        }

        if (controller.products.isEmpty) {
          return const EmptyWidget(
            message: 'No products found',
            icon: Icons.shopping_bag_outlined,
          );
        }

        return RefreshIndicator(
          onRefresh: controller.fetchProducts,
          child: ListView.builder(
            controller: controller.scrollController,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
            itemCount: controller.products.length + 1,
            itemBuilder: (context, index) {
              if (index == controller.products.length) {
                return _BottomLoader(
                  isPaginating: controller.isPaginating.value,
                  hasReachedMax: controller.hasReachedMax.value,
                );
              }

              final product = controller.products[index];
              return FadeInUp(
                delay: Duration(milliseconds: index < 10 ? index * 80 : 0),
                duration: const Duration(milliseconds: 400),
                from: 30,
                child: _ProductCard(
                  product: product,
                  onTap: () => Get.toNamed(
                    AppRoutes.productDetail,
                    arguments: product,
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

class _ProductCard extends StatefulWidget {
  final ProductEntity product;
  final VoidCallback onTap;

  const _ProductCard({required this.product, required this.onTap});

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
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
              // Image section
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppTheme.radiusLarge),
                ),
                child: Stack(
                  children: [
                    Hero(
                      tag: 'product_${widget.product.id}',
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: CachedNetworkImage(
                          imageUrl: widget.product.thumbnail,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Container(
                            color: colorScheme.surfaceContainerHighest,
                          ),
                          errorWidget: (_, __, ___) => Container(
                            color: colorScheme.surfaceContainerHighest,
                            child: const Icon(Icons.broken_image, size: 32),
                          ),
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
                              Colors.black.withValues(alpha: 0.4),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Price badge
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              '\$${widget.product.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Info section
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    if (widget.product.brand.isNotEmpty)
                      Text(
                        widget.product.brand,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomLoader extends StatelessWidget {
  final bool isPaginating;
  final bool hasReachedMax;

  const _BottomLoader({
    required this.isPaginating,
    required this.hasReachedMax,
  });

  @override
  Widget build(BuildContext context) {
    if (hasReachedMax) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Text(
            'All products loaded',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }

    if (isPaginating) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    return const SizedBox.shrink();
  }
}
