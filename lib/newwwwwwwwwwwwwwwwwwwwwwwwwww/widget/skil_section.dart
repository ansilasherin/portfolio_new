import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_portfolio/newwwwwwwwwwwwwwwwwwwwwwwwwww/model/portmodel.dart';
import 'package:flutter_portfolio/newwwwwwwwwwwwwwwwwwwwwwwwwww/widget/shared_widget.dart';
import '../theme/app_theme.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

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
                  const SectionLabel('Technical Skills'),
                  const SizedBox(height: 16),
                  Text('The tools I work with', style: AppTextStyles.displayMedium),
                  const SizedBox(height: 12),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: Text(
                      'A focused set of technologies I use to build production-quality Flutter applications.',
                      style: AppTextStyles.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),

            // Grid
            _SkillsGrid(isWide: isWide, isMed: isMed),
          ],
        ),
      ),
    );
  }
}

class _SkillsGrid extends StatelessWidget {
  final bool isWide;
  final bool isMed;

  const _SkillsGrid({required this.isWide, required this.isMed});

  @override
  Widget build(BuildContext context) {
    final cols = isWide ? 3 : (isMed ? 2 : 1);

    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: PortfolioData.skillGroups.asMap().entries.map((entry) {
        final idx = entry.key;
        final group = entry.value;
        final cardWidth = isWide
            ? (AppSizes.maxWidth - 104) / 3
            : isMed
                ? (MediaQuery.of(context).size.width - 104) / 2
                : double.infinity;

        return FadeInUp(
          delay: Duration(milliseconds: idx * 100),
          duration: const Duration(milliseconds: 600),
          child: SizedBox(
            width: cols == 1 ? double.infinity : cardWidth,
            child: _SkillGroupCard(group: group),
          ),
        );
      }).toList(),
    );
  }
}

class _SkillGroupCard extends StatefulWidget {
  final SkillGroup group;
  const _SkillGroupCard({required this.group});

  @override
  State<_SkillGroupCard> createState() => _SkillGroupCardState();
}

class _SkillGroupCardState extends State<_SkillGroupCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(28),
        transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered ? AppColors.accent.withOpacity(0.25) : AppColors.border,
          ),
          boxShadow: _hovered
              ? [BoxShadow(color: AppColors.accent.withOpacity(0.05), blurRadius: 24, offset: const Offset(0, 8))]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(child: Text(widget.group.icon, style: const TextStyle(fontSize: 16))),
                ),
                const SizedBox(width: 12),
                Text(widget.group.title, style: AppTextStyles.headingSmall),
              ],
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.group.skills.map((s) => SkillTag(s)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
