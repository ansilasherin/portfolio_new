import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_portfolio/newwwwwwwwwwwwwwwwwwwwwwwwwww/model/portmodel.dart';
import 'package:flutter_portfolio/newwwwwwwwwwwwwwwwwwwwwwwwwww/utils/lanchure.dart';
import 'package:flutter_portfolio/newwwwwwwwwwwwwwwwwwwwwwwwwww/widget/shared_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(vertical: AppSizes.sectionPadding),
      child: MaxWidthBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionLabel('Projects'),
                  const SizedBox(height: 16),
                  Text('Production-ready work', style: AppTextStyles.displayMedium),
                  const SizedBox(height: 12),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: Text(
                      'Each project is built with structured architecture, clean code practices, and real-world use cases in mind.',
                      style: AppTextStyles.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),

            // Project cards
            ...PortfolioData.projects.asMap().entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
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
    final isWide = MediaQuery.of(context).size.width > 900;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
        decoration: BoxDecoration(
          color: AppColors.bg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered ? widget.project.accentColor.withOpacity(0.3) : AppColors.border,
          ),
          boxShadow: _hovered
              ? [BoxShadow(color: widget.project.accentColor.withOpacity(0.06), blurRadius: 32)]
              : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 6, child: _ProjectInfo(project: widget.project)),
                    Expanded(flex: 4, child: _ProjectVisual(project: widget.project)),
                  ],
                )
              : Column(
                  children: [
                    _ProjectInfo(project: widget.project),
                    _ProjectVisual(project: widget.project),
                  ],
                ),
        ),
      ),
    );
  }
}

class _ProjectInfo extends StatelessWidget {
  final Project project;
  const _ProjectInfo({required this.project});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Number + featured badge
          Row(
            children: [
              Text(
                project.number.toUpperCase(),
                style: AppTextStyles.label.copyWith(color: AppColors.textDim, letterSpacing: 1.8),
              ),
              if (project.isFeatured) ...[
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: project.accentColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: project.accentColor.withOpacity(0.25)),
                  ),
                  child: Text(
                    'FEATURED',
                    style: AppTextStyles.label.copyWith(
                      color: project.accentColor,
                      fontSize: 9,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),

          Text(
            project.name,
            style: AppTextStyles.headingLarge.copyWith(fontSize: 26, height: 1.2),
          ),
          const SizedBox(height: 16),

          Text(project.description, style: AppTextStyles.bodyMedium),
          const SizedBox(height: 20),

          // Features
          ...project.features.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '→  ',
                    style: TextStyle(
                      color: project.accentColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: Text(f, style: AppTextStyles.bodySmall.copyWith(height: 1.55)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Tech stack
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: project.techStack.map((t) => _ColoredTechTag(t, color: project.accentColor)).toList(),
          ),
          const SizedBox(height: 24),

          // GitHub button
          GhostButton(
            label: 'View on GitHub',
            onTap: () => AppLauncher.open(project.githubUrl),
            icon: Icons.code_rounded,
            small: true,
          ),
        ],
      ),
    );
  }
}

class _ColoredTechTag extends StatelessWidget {
  final String label;
  final Color color;
  const _ColoredTechTag(this.label, {required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.07),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(
        label,
        style: AppTextStyles.bodySmall.copyWith(color: color, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _ProjectVisual extends StatelessWidget {
  final Project project;
  const _ProjectVisual({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface.withOpacity(0.5),
      padding: const EdgeInsets.all(36),
      child: Column(
        children: [
          PhoneMockup(project: project),
          const SizedBox(height: 20),
          _ArchNote(note: project.architectureNote, color: project.accentColor),
        ],
      ),
    );
  }
}

class PhoneMockup extends StatelessWidget {
  final Project project;
  const PhoneMockup({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 180, height: 340,
        decoration: BoxDecoration(
          color: AppColors.surface2,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: AppColors.border, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 40,
              offset: const Offset(0, 16),
            ),
            BoxShadow(
              color: project.accentColor.withOpacity(0.06),
              blurRadius: 30,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: Stack(
            children: [
              // Notch
              Positioned(
                top: 10, left: 0, right: 0,
                child: Center(
                  child: Container(
                    width: 56, height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              // Screen content
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 28, 12, 14),
                child: _MockScreen(project: project),
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
  const _MockScreen({required this.project});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header bar
        Container(
          height: 26,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [project.accentColor.withOpacity(0.3), project.accentColor.withOpacity(0.1)],
            ),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 8),

        // Mock list items
        ...List.generate(3, (i) => _MockListItem(color: project.accentColor, index: i)),

        const SizedBox(height: 6),
        // CTA button
        Container(
          height: 24,
          decoration: BoxDecoration(
            color: project.accentColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: project.accentColor.withOpacity(0.25)),
          ),
        ),
      ],
    );
  }
}

class _MockListItem extends StatelessWidget {
  final Color color;
  final int index;
  const _MockListItem({required this.color, required this.index});

  final List<Color> statusColors = const [
    Color(0xFFF6C90E),
    AppColors.accent,
    Color(0xFF7C8098),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 22, height: 22,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: color.withOpacity(0.25)),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 5, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(3))),
                const SizedBox(height: 4),
                Container(width: 55, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2))),
              ],
            ),
          ),
          Container(
            width: 5, height: 5,
            decoration: BoxDecoration(color: statusColors[index % 3], shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }
}

class _ArchNote extends StatelessWidget {
  final String note;
  final Color color;
  const _ArchNote({required this.note, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface2,
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(color: color, width: 3)),
        boxShadow: [BoxShadow(color: AppColors.bg.withOpacity(0.3), blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ARCHITECTURE NOTE',
            style: AppTextStyles.label.copyWith(color: color, fontSize: 9, letterSpacing: 1.5),
          ),
          const SizedBox(height: 6),
          Text(
            note,
            style: AppTextStyles.bodySmall.copyWith(
              fontStyle: FontStyle.italic,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}
