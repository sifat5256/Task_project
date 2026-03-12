import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
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
                post.title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            const SizedBox(height: 16),

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
                  const SizedBox(width: 12),
                  _ReactionChip(
                    icon: Icons.thumb_down_rounded,
                    label: '${post.reactions.dislikes}',
                    color: colorScheme.error,
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.onSurfaceVariant.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 14,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'User ${post.userId}',
                          style: TextStyle(
                            fontSize: 12,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

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
            const SizedBox(height: 24),

            // Body content in a card
            FadeInUp(
              delay: const Duration(milliseconds: 440),
              duration: const Duration(milliseconds: 400),
              from: 20,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
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
                          width: 4,
                          height: 20,
                          decoration: BoxDecoration(
                            gradient: AppTheme.primaryGradient,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Content',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
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
              const SizedBox(height: 24),
              FadeInUp(
                delay: const Duration(milliseconds: 520),
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
                      'Tags',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              FadeInUp(
                delay: const Duration(milliseconds: 600),
                duration: const Duration(milliseconds: 400),
                from: 20,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: post.tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            colorScheme.primary.withValues(alpha: 0.1),
                            colorScheme.secondary.withValues(alpha: 0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: colorScheme.primary.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Text(
                        '#$tag',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.primary,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
            const SizedBox(height: 100),
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
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
