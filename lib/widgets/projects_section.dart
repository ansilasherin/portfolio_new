import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../models/portfolio_model.dart';
import '../theme/app_theme.dart';
import '../utils/launcher.dart';
import 'shared_widgets.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final surface = AppColors.surface(context);

    return Container(
      color: surface,
      padding: const EdgeInsets.symmetric(vertical: AppSizes.sectionPadding),
      child: MaxWidthBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionLabel('Featured Projects'),
                  const SizedBox(height: 16),
                  Text('Production-ready mobile applications',
                      style: AppTextStyles.displayMedium(context)),
                  const SizedBox(height: 12),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 580),
                    child: Text(
                      'Each project is built with structured MVVM architecture, clean state management, and real-world backend API workflows.',
                      style: AppTextStyles.bodyLarge(context),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 52),

            // Project cards list
            ...PortfolioData.projects.asMap().entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: FadeInUp(
                  delay: Duration(milliseconds: entry.key * 150),
                  duration: const Duration(milliseconds: 700),
                  child: ProjectCard(project: entry.value),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final Project project;
  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDarkMode(context);
    final isWide = MediaQuery.of(context).size.width > 920;
    final projectColor = widget.project.getAccentColor(isDark);
    final cardBg = AppColors.bg(context);
    final border = AppColors.border(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _hovered ? projectColor.withValues(alpha: 0.45) : border,
            width: 1.3,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? projectColor.withValues(alpha: 0.12)
                  : AppColors.cardShadow(context),
              blurRadius: _hovered ? 36 : 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: _ProjectInfo(
                        project: widget.project,
                        accentColor: projectColor,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: _ProjectVisual(
                        project: widget.project,
                        accentColor: projectColor,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _ProjectInfo(
                      project: widget.project,
                      accentColor: projectColor,
                    ),
                    _ProjectVisual(
                      project: widget.project,
                      accentColor: projectColor,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _ProjectInfo extends StatelessWidget {
  final Project project;
  final Color accentColor;

  const _ProjectInfo({
    required this.project,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final text = AppColors.text(context);
    final textDim = AppColors.textDim(context);

    return Padding(
      padding: const EdgeInsets.all(36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Number & Featured badge
          Row(
            children: [
              Text(
                project.number.toUpperCase(),
                style: AppTextStyles.label(context).copyWith(
                  color: textDim,
                  letterSpacing: 1.6,
                ),
              ),
              if (project.isFeatured) ...[
                const SizedBox(width: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: accentColor.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    'FEATURED APP',
                    style: AppTextStyles.label(context).copyWith(
                      color: accentColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 14),

          Text(
            project.name,
            style: AppTextStyles.headingLarge(context).copyWith(
              fontSize: 26,
              height: 1.2,
              color: text,
            ),
          ),
          const SizedBox(height: 16),

          Text(
            project.description,
            style: AppTextStyles.bodyMedium(context).copyWith(height: 1.65),
          ),
          const SizedBox(height: 22),

          // Key features list
          ...project.features.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Icon(
                      Icons.arrow_right_alt_rounded,
                      color: accentColor,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      feature,
                      style: AppTextStyles.bodySmall(context).copyWith(
                        height: 1.55,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 22),

          // Tech stack chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: project.techStack
                .map((tech) => TechTag(tech, customColor: accentColor))
                .toList(),
          ),
          const SizedBox(height: 28),

          // Action button
          GhostButton(
            label: 'View Source on GitHub',
            onTap: () => AppLauncher.open(project.githubUrl),
            icon: Icons.code_rounded,
            small: true,
          ),
        ],
      ),
    );
  }
}

class _ProjectVisual extends StatelessWidget {
  final Project project;
  final Color accentColor;

  const _ProjectVisual({
    required this.project,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final surface2 = AppColors.surface2(context);

    return Container(
      color: surface2.withValues(alpha: 0.55),
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PhoneMockup(project: project, accentColor: accentColor),
          const SizedBox(height: 24),
          _ArchNote(
            note: project.architectureNote,
            accentColor: accentColor,
          ),
        ],
      ),
    );
  }
}

class PhoneMockup extends StatelessWidget {
  final Project project;
  final Color accentColor;

  const PhoneMockup({
    super.key,
    required this.project,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDarkMode(context);
    final surface = AppColors.surface(context);
    final border = AppColors.border(context);

    return Center(
      child: Container(
        width: 190,
        height: 350,
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isDark ? const Color(0xFF2E334D) : const Color(0xFFCBD5E1),
            width: 2.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.45 : 0.12),
              blurRadius: 36,
              offset: const Offset(0, 14),
            ),
            BoxShadow(
              color: accentColor.withValues(alpha: 0.08),
              blurRadius: 24,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(27),
          child: Stack(
            children: [
              // Notch speaker
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 54,
                    height: 4,
                    decoration: BoxDecoration(
                      color: border,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),

              // Mock screen content
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 28, 14, 14),
                child: _MockScreen(
                  project: project,
                  accentColor: accentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MockScreen extends StatelessWidget {
  final Project project;
  final Color accentColor;

  const _MockScreen({
    required this.project,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // App header bar
        Container(
          height: 28,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                accentColor.withValues(alpha: 0.35),
                accentColor.withValues(alpha: 0.12)
              ],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: accentColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 24,
                  height: 4,
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Mock UI cards
        ...List.generate(
          3,
          (i) => _MockListItem(
            accentColor: accentColor,
            index: i,
          ),
        ),

        const Spacer(),

        // Primary action mock button
        Container(
          height: 26,
          decoration: BoxDecoration(
            color: accentColor.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: accentColor.withValues(alpha: 0.3)),
          ),
          child: Center(
            child: Container(
              width: 50,
              height: 4,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MockListItem extends StatelessWidget {
  final Color accentColor;
  final int index;

  const _MockListItem({
    required this.accentColor,
    required this.index,
  });

  static const List<Color> statusColors = [
    Color(0xFFF6C90E),
    Color(0xFF10B981),
    Color(0xFF6C63FF),
  ];

  @override
  Widget build(BuildContext context) {
    final surface = AppColors.surface(context);
    final border = AppColors.border(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 7),
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Icon(
                Icons.folder_outlined,
                size: 13,
                color: accentColor,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 5,
                  decoration: BoxDecoration(
                    color: border,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 48,
                  height: 4,
                  decoration: BoxDecoration(
                    color: border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: statusColors[index % 3],
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}

class _ArchNote extends StatelessWidget {
  final String note;
  final Color accentColor;

  const _ArchNote({
    required this.note,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final surface = AppColors.surface(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: accentColor, width: 3.5)),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow(context),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ARCHITECTURE & IMPLEMENTATION NOTE',
            style: AppTextStyles.label(context).copyWith(
              color: accentColor,
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.3,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            note,
            style: AppTextStyles.bodySmall(context).copyWith(
              fontStyle: FontStyle.italic,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}
