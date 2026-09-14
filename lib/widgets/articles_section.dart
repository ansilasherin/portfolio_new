import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../models/portfolio_model.dart';
import '../theme/app_theme.dart';
import '../utils/launcher.dart';
import 'shared_widgets.dart';

class ArticlesSection extends StatelessWidget {
  const ArticlesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w > 960;
    final isMed = w > 640;
    final bg = AppColors.bg(context);

    return Container(
      color: bg,
      padding: const EdgeInsets.symmetric(vertical: AppSizes.sectionPadding),
      child: MaxWidthBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionLabel('Technical Articles & Writing'),
                  const SizedBox(height: 16),
                  Text('Writing on Flutter & Architecture',
                      style: AppTextStyles.displayMedium(context)),
                  const SizedBox(height: 12),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 580),
                    child: Text(
                      'Practical articles exploring clean architecture patterns, state management benchmarks, and real-world Flutter development solutions.',
                      style: AppTextStyles.bodyLarge(context),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),

            Wrap(
              spacing: 24,
              runSpacing: 24,
              children: PortfolioData.blogPosts.asMap().entries.map((entry) {
                final cardWidth = isWide
                    ? (AppSizes.maxWidth - 104) / 3
                    : isMed
                        ? (w - 96) / 2
                        : double.infinity;

                return FadeInUp(
                  delay: Duration(milliseconds: entry.key * 120),
                  child: SizedBox(
                    width: isWide || isMed ? cardWidth : double.infinity,
                    child: BlogCard(post: entry.value),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogCard extends StatefulWidget {
  final BlogPost post;
  const BlogCard({super.key, required this.post});

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final surface = AppColors.surface(context);
    final border = AppColors.border(context);
    final accent = AppColors.accent(context);
    final accent2 = AppColors.accent2(context);
    final text = AppColors.text(context);
    final textDim = AppColors.textDim(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => AppLauncher.open(widget.post.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: Matrix4.translationValues(0, _hovered ? -5 : 0, 0),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _hovered ? accent2.withValues(alpha: 0.4) : border,
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: _hovered
                    ? accent2.withValues(alpha: 0.12)
                    : AppColors.cardShadow(context),
                blurRadius: _hovered ? 28 : 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category tag & read time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: accent2.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                      border:
                          Border.all(color: accent2.withValues(alpha: 0.25)),
                    ),
                    child: Text(
                      widget.post.category.toUpperCase(),
                      style: AppTextStyles.label(context).copyWith(
                        color: accent2,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  Text(
                    widget.post.readTime,
                    style: AppTextStyles.bodySmall(context).copyWith(
                      color: textDim,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              Text(
                widget.post.title,
                style: AppTextStyles.headingSmall(context).copyWith(
                  height: 1.35,
                  fontSize: 16,
                  color: text,
                ),
              ),
              const SizedBox(height: 12),

              Text(
                widget.post.excerpt,
                style: AppTextStyles.bodySmall(context).copyWith(
                  height: 1.65,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 22),

              Row(
                children: [
                  Text(
                    'Read full article',
                    style: AppTextStyles.bodySmall(context).copyWith(
                      color: accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    transform:
                        Matrix4.translationValues(_hovered ? 5 : 0, 0, 0),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      size: 15,
                      color: accent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
