import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_project/app/routes/app_routes.dart';
import 'package:task_project/core/theme/app_theme.dart';
import 'package:task_project/domain/entities/post_entity.dart';
import 'package:task_project/presentation/controllers/post_controller.dart';
import 'package:task_project/presentation/widgets/empty_widget.dart';
import 'package:task_project/presentation/widgets/error_widget.dart';
import 'package:task_project/presentation/widgets/loading_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PostController>();

    return Scaffold(
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) =>
              AppTheme.primaryGradient.createShader(bounds),
          child: Text(
            'Posts',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const LoadingWidget(type: ShimmerType.post);
        }

        if (controller.hasError.value && controller.posts.isEmpty) {
          return AppErrorWidget(
            message: controller.errorMessage.value,
            onRetry: controller.fetchPosts,
          );
        }

        if (controller.posts.isEmpty) {
          return const EmptyWidget(
            message: 'No posts found',
            icon: Icons.article_outlined,
          );
        }

        return RefreshIndicator(
          onRefresh: controller.fetchPosts,
          child: ListView.builder(
            controller: controller.scrollController,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
            itemCount: controller.posts.length + 1,
            itemBuilder: (context, index) {
              if (index == controller.posts.length) {
                return _BottomLoader(
                  isPaginating: controller.isPaginating.value,
                  hasReachedMax: controller.hasReachedMax.value,
                );
              }

              final post = controller.posts[index];
              return FadeInUp(
                delay: Duration(milliseconds: index < 10 ? index * 80 : 0),
                duration: const Duration(milliseconds: 400),
                from: 30,
                child: _PostCard(
                  post: post,
                  onTap: () => Get.toNamed(
                    AppRoutes.postDetail,
                    arguments: post,
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

class _PostCard extends StatefulWidget {
  final PostEntity post;
  final VoidCallback onTap;

  const _PostCard({required this.post, required this.onTap});

  @override
  State<_PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<_PostCard> {
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
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.15),
            ),
            boxShadow: [AppTheme.softShadow],
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                // Left accent border
                Container(
                  width: 4,
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(AppTheme.radiusLarge),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.post.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.post.body,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            // Tags
                            if (widget.post.tags.isNotEmpty)
                              ...widget.post.tags.take(2).map(
                                    (tag) => Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: colorScheme.primary
                                            .withValues(alpha: 0.08),
                                        borderRadius:
                                            BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        tag,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          color: colorScheme.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                            const Spacer(),
                            // Reactions
                            Icon(
                              Icons.thumb_up_outlined,
                              size: 14,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.post.reactions.likes}',
                              style: TextStyle(
                                fontSize: 12,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Icon(
                              Icons.thumb_down_outlined,
                              size: 14,
                              color: colorScheme.error,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.post.reactions.dislikes}',
                              style: TextStyle(
                                fontSize: 12,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
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
            'All posts loaded',
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
