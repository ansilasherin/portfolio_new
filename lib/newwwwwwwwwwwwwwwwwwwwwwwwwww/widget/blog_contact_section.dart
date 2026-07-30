import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_portfolio/newwwwwwwwwwwwwwwwwwwwwwwwwww/model/portmodel.dart';
import 'package:flutter_portfolio/newwwwwwwwwwwwwwwwwwwwwwwwwww/utils/lanchure.dart';
import 'package:flutter_portfolio/newwwwwwwwwwwwwwwwwwwwwwwwwww/widget/shared_widget.dart';
import '../theme/app_theme.dart';


// ── Blog Section ──
class BlogSection extends StatelessWidget {
  const BlogSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w > 900;
    final isMed = w > 600;

    return Container(
      color: AppColors.bg,
      padding: const EdgeInsets.symmetric(vertical: AppSizes.sectionPadding),
      child: MaxWidthBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionLabel('Technical Articles'),
                  const SizedBox(height: 16),
                  Text('Writing on Flutter', style: AppTextStyles.displayMedium),
                  const SizedBox(height: 12),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: Text(
                      'In-depth articles on architecture patterns, state management, and real-world Flutter development challenges.',
                      style: AppTextStyles.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),

            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: PortfolioData.blogPosts.asMap().entries.map((e) {
                final cardWidth = isWide
                    ? (AppSizes.maxWidth - 104) / 3
                    : isMed
                        ? (w - 104) / 2
                        : double.infinity;

                return FadeInUp(
                  delay: Duration(milliseconds: e.key * 100),
                  child: SizedBox(
                    width: isWide || isMed ? cardWidth : double.infinity,
                    child: BlogCard(post: e.value),
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
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => AppLauncher.open(widget.post.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered ? AppColors.accent2.withOpacity(0.3) : AppColors.border,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category chip
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accent2.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.accent2.withOpacity(0.2)),
                ),
                child: Text(
                  widget.post.category.toUpperCase(),
                  style: AppTextStyles.label.copyWith(
                    color: const Color(0xFFA29BFE),
                    fontSize: 9,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Text(widget.post.title, style: AppTextStyles.headingSmall.copyWith(height: 1.4)),
              const SizedBox(height: 10),

              Text(widget.post.excerpt, style: AppTextStyles.bodySmall.copyWith(height: 1.65)),
              const SizedBox(height: 20),

              Row(
                children: [
                  Text(
                    'Read article',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 6),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    transform: Matrix4.translationValues(_hovered ? 4 : 0, 0, 0),
                    child: const Icon(Icons.arrow_forward_rounded, size: 14, color: AppColors.accent),
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

// ── Contact Section ──
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(vertical: AppSizes.sectionPadding),
      child: MaxWidthBox(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: FadeInUp(
              child: Column(
                children: [
                  const SectionLabel('Contact'),
                  const SizedBox(height: 16),
                  Text(
                    "Let's work together",
                    style: AppTextStyles.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Open to Flutter developer roles, internships, and freelance projects. Reach out through any of the channels below.',
                    style: AppTextStyles.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      _ContactLink(
                        label: PortfolioData.email,
                        icon: Icons.email_outlined,
                        onTap: () => AppLauncher.email(PortfolioData.email),
                      ),
                      _ContactLink(
                        label: 'GitHub',
                        icon: Icons.code_rounded,
                        onTap: () => AppLauncher.open(PortfolioData.githubUrl),
                      ),
                      _ContactLink(
                        label: 'LinkedIn',
                        icon: Icons.link_rounded,
                        onTap: () => AppLauncher.open(PortfolioData.linkedinUrl),
                      ),
                      _ContactLink(
                        label: 'Resume PDF',
                        icon: Icons.download_rounded,
                        onTap: () => AppLauncher.open(PortfolioData.resumeUrl),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ContactLink extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _ContactLink({required this.label, required this.icon, required this.onTap});

  @override
  State<_ContactLink> createState() => _ContactLinkState();
}

class _ContactLinkState extends State<_ContactLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.surface2,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovered ? AppColors.accent : AppColors.border,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 16,
                color: _hovered ? AppColors.accent : AppColors.textMuted,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: _hovered ? AppColors.accent : AppColors.textMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Footer ──
class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Center(
        child: Text.rich(
          TextSpan(
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textDim),
            children: [
              TextSpan(text: 'Designed & developed by '),
              TextSpan(
                text: PortfolioData.name,
                style: const TextStyle(color: AppColors.textMuted, fontWeight: FontWeight.w500),
              ),
              TextSpan(text: '  ·  Flutter Developer  ·  '),
              TextSpan(
                text: '2025',
                style: const TextStyle(color: AppColors.accent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
