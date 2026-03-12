import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
            expandedHeight: 300,
            pinned: true,
            stretch: true,
            backgroundColor: colorScheme.surface,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 18),
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
                        child: const Icon(Icons.broken_image, size: 48),
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
                    bottom: 16,
                    right: 16,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: AnimatedBuilder(
                          animation: _priceAnimation,
                          builder: (context, child) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              '\$${_priceAnimation.value.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
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
              padding: const EdgeInsets.all(20),
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
                  const SizedBox(height: 12),

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
                            size: 16,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            product.brand,
                            style:
                                Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          const SizedBox(width: 16),
                        ],
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            gradient: AppTheme.primaryGradient,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            product.category,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

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
                  const SizedBox(height: 24),

                  // Description header
                  FadeInUp(
                    delay: const Duration(milliseconds: 440),
                    duration: const Duration(milliseconds: 400),
                    from: 20,
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 20,
                          decoration: BoxDecoration(
                            gradient: AppTheme.primaryGradient,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Description',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Description body
                  FadeInUp(
                    delay: const Duration(milliseconds: 520),
                    duration: const Duration(milliseconds: 400),
                    from: 20,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
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
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
