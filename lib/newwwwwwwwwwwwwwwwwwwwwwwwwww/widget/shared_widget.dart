import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

// ── Constrained Content Width ──
class MaxWidthBox extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const MaxWidthBox({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppSizes.maxWidth),
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 32),
          child: child,
        ),
      ),
    );
  }
}

// ── Section Label ──
class SectionLabel extends StatelessWidget {
  final String text;
  const SectionLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 32, height: 1, color: AppColors.accent),
        const SizedBox(width: 12),
        Text(text.toUpperCase(), style: AppTextStyles.label),
      ],
    );
  }
}

// ── Primary Button ──
class PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final bool small;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.small = false,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: widget.small ? 16 : 24,
            vertical: widget.small ? 10 : 14,
          ),
          decoration: BoxDecoration(
            color: _hovered ? const Color(0xFF00FFE6) : AppColors.accent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: _hovered
                ? [BoxShadow(color: AppColors.accent.withOpacity(0.35), blurRadius: 24, offset: const Offset(0, 8))]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.dmSans(
                  fontSize: widget.small ? 13 : 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.bg,
                  letterSpacing: 0.3,
                ),
              ),
              if (widget.icon != null) ...[
                const SizedBox(width: 8),
                Icon(widget.icon, size: widget.small ? 14 : 16, color: AppColors.bg),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ── Ghost Button ──
class GhostButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final bool small;

  const GhostButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.small = false,
  });

  @override
  State<GhostButton> createState() => _GhostButtonState();
}

class _GhostButtonState extends State<GhostButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: widget.small ? 14 : 20,
            vertical: widget.small ? 9 : 13,
          ),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _hovered ? AppColors.accent : AppColors.border,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: widget.small ? 14 : 16,
                    color: _hovered ? AppColors.accent : AppColors.textMuted),
                const SizedBox(width: 8),
              ],
              Text(
                widget.label,
                style: GoogleFonts.dmSans(
                  fontSize: widget.small ? 13 : 14,
                  fontWeight: FontWeight.w500,
                  color: _hovered ? AppColors.accent : AppColors.textMuted,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Glowing Stat Card ──
class StatCard extends StatefulWidget {
  final String label;
  final String value;
  final String? subtitle;

  const StatCard({super.key, required this.label, required this.value, this.subtitle});

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered ? AppColors.accent.withOpacity(0.35) : AppColors.border,
          ),
          boxShadow: _hovered
              ? [BoxShadow(color: AppColors.accent.withOpacity(0.06), blurRadius: 20)]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.label.toUpperCase(), style: AppTextStyles.label.copyWith(color: AppColors.textDim)),
            const SizedBox(height: 6),
            Text(widget.value, style: AppTextStyles.headingLarge),
            if (widget.subtitle != null) ...[
              const SizedBox(height: 4),
              Text(widget.subtitle!, style: AppTextStyles.bodySmall),
            ],
          ],
        ),
      ),
    );
  }
}

// ── Skill Tag ──
class SkillTag extends StatefulWidget {
  final String label;
  const SkillTag(this.label, {super.key});

  @override
  State<SkillTag> createState() => _SkillTagState();
}

class _SkillTagState extends State<SkillTag> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.accent.withOpacity(0.08) : AppColors.surface2,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: _hovered ? AppColors.accent.withOpacity(0.3) : AppColors.border,
          ),
        ),
        child: Text(
          widget.label,
          style: AppTextStyles.bodySmall.copyWith(
            color: _hovered ? AppColors.accent : AppColors.textMuted,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

// ── Tech Tag (for projects) ──
class TechTag extends StatelessWidget {
  final String label;
  const TechTag(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.07),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.accent.withOpacity(0.18)),
      ),
      child: Text(
        label,
        style: AppTextStyles.bodySmall.copyWith(color: AppColors.accent, fontWeight: FontWeight.w500),
      ),
    );
  }
}

// ── Divider ──
class AppDivider extends StatelessWidget {
  const AppDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(height: 1, color: AppColors.border);
  }
}

// ── Highlight Item Card ──
class HighlightCard extends StatefulWidget {
  final String icon;
  final String title;
  final String description;

  const HighlightCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  State<HighlightCard> createState() => _HighlightCardState();
}

class _HighlightCardState extends State<HighlightCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(_hovered ? 4 : 0, 0, 0),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface2,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hovered ? AppColors.accent.withOpacity(0.25) : AppColors.border,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Text(widget.icon, style: const TextStyle(fontSize: 18))),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: AppTextStyles.headingSmall),
                  const SizedBox(height: 4),
                  Text(widget.description, style: AppTextStyles.bodySmall.copyWith(height: 1.55)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
