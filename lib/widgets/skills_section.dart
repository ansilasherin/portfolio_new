import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../models/portfolio_model.dart';
import '../theme/app_theme.dart';
import 'shared_widgets.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

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
                  const SectionLabel('Technical Stack'),
                  const SizedBox(height: 16),
                  Text('The tools & technologies I master',
                      style: AppTextStyles.displayMedium(context)),
                  const SizedBox(height: 12),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 580),
                    child: Text(
                      'A focused set of technologies, architectural patterns, and workflows I leverage to build production-quality Flutter applications.',
                      style: AppTextStyles.bodyLarge(context),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),

            // Skills Grid
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
      spacing: 24,
      runSpacing: 24,
      children: PortfolioData.skillGroups.asMap().entries.map((entry) {
        final idx = entry.key;
        final group = entry.value;
        final cardWidth = isWide
            ? (AppSizes.maxWidth - 104) / 3
            : isMed
                ? (MediaQuery.of(context).size.width - 96) / 2
                : double.infinity;

        return FadeInUp(
          delay: Duration(milliseconds: idx * 120),
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
    final surface = AppColors.surface(context);
    final border = AppColors.border(context);
    final accent = AppColors.accent(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(28),
        transform: Matrix4.translationValues(0, _hovered ? -5 : 0, 0),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered ? accent.withValues(alpha: 0.4) : border,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? accent.withValues(alpha: 0.1)
                  : AppColors.cardShadow(context),
              blurRadius: _hovered ? 28 : 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(widget.group.icon,
                        style: const TextStyle(fontSize: 20)),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    widget.group.title,
                    style: AppTextStyles.headingSmall(context).copyWith(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              runSpacing: 10,
              children: widget.group.skills.map((s) => SkillTag(s)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
