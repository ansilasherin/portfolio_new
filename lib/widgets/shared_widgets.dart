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
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 28),
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
    final accent = AppColors.accent(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 2,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(text.toUpperCase(), style: AppTextStyles.label(context)),
      ],
    );
  }
}

// ── Theme Mode Toggle Button (Sun/Moon with Glow & Animation) ──
class ThemeToggleButton extends StatefulWidget {
  final bool compact;
  const ThemeToggleButton({super.key, this.compact = false});

  @override
  State<ThemeToggleButton> createState() => _ThemeToggleButtonState();
}

class _ThemeToggleButtonState extends State<ThemeToggleButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeMode,
      builder: (context, mode, _) {
        final isDark = mode == ThemeMode.dark;
        final border = AppColors.border(context);
        final surface = AppColors.surface2(context);
        final accent = AppColors.accent(context);
        final text = AppColors.text(context);

        return MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => ThemeController.toggleTheme(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: EdgeInsets.symmetric(
                horizontal: widget.compact ? 10 : 14,
                vertical: widget.compact ? 8 : 10,
              ),
              decoration: BoxDecoration(
                color: _hovered ? surface : surface.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: _hovered ? accent.withValues(alpha: 0.5) : border,
                  width: 1.2,
                ),
                boxShadow: _hovered
                    ? [
                        BoxShadow(
                          color: accent.withValues(alpha: 0.18),
                          blurRadius: 14,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) =>
                        RotationTransition(
                      turns: animation,
                      child: FadeTransition(opacity: animation, child: child),
                    ),
                    child: Icon(
                      isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                      key: ValueKey<bool>(isDark),
                      size: widget.compact ? 17 : 19,
                      color: isDark ? const Color(0xFFFACC15) : const Color(0xFF6366F1),
                    ),
                  ),
                  if (!widget.compact) ...[
                    const SizedBox(width: 8),
                    Text(
                      isDark ? 'LIGHT' : 'DARK',
                      style: GoogleFonts.dmSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                        color: text,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
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
    final isDark = AppColors.isDarkMode(context);
    final accent = AppColors.accent(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
          padding: EdgeInsets.symmetric(
            horizontal: widget.small ? 16 : 24,
            vertical: widget.small ? 10 : 14,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? (_hovered
                      ? [const Color(0xFF14FFE9), const Color(0xFF00D4B1)]
                      : [const Color(0xFF00D4B1), const Color(0xFF00B295)])
                  : (_hovered
                      ? [const Color(0xFF059669), const Color(0xFF047857)]
                      : [const Color(0xFF00A88F), const Color(0xFF02826F)]),
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: accent.withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: accent.withValues(alpha: 0.18),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.dmSans(
                  fontSize: widget.small ? 13 : 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              ),
              if (widget.icon != null) ...[
                const SizedBox(width: 8),
                Icon(widget.icon, size: widget.small ? 15 : 17, color: Colors.white),
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
    final accent = AppColors.accent(context);
    final border = AppColors.border(context);
    final surface = AppColors.surface(context);
    final textMuted = AppColors.textMuted(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
          padding: EdgeInsets.symmetric(
            horizontal: widget.small ? 16 : 22,
            vertical: widget.small ? 10 : 14,
          ),
          decoration: BoxDecoration(
            color: _hovered ? accent.withValues(alpha: 0.08) : surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _hovered ? accent : border,
              width: 1.2,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: accent.withValues(alpha: 0.12),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  size: widget.small ? 15 : 17,
                  color: _hovered ? accent : textMuted,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                widget.label,
                style: GoogleFonts.dmSans(
                  fontSize: widget.small ? 13 : 14,
                  fontWeight: FontWeight.w600,
                  color: _hovered ? accent : textMuted,
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

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    this.subtitle,
  });

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final surface = AppColors.surface(context);
    final border = AppColors.border(context);
    final accent = AppColors.accent(context);
    final textDim = AppColors.textDim(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _hovered ? accent.withValues(alpha: 0.4) : border,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? accent.withValues(alpha: 0.12)
                  : AppColors.cardShadow(context),
              blurRadius: _hovered ? 24 : 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label.toUpperCase(),
              style: AppTextStyles.label(context).copyWith(
                color: textDim,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.value,
              style: AppTextStyles.headingLarge(context).copyWith(fontSize: 26),
            ),
            if (widget.subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                widget.subtitle!,
                style: AppTextStyles.bodySmall(context),
              ),
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
    final surface2 = AppColors.surface2(context);
    final border = AppColors.border(context);
    final accent = AppColors.accent(context);
    final textMuted = AppColors.textMuted(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: _hovered ? accent.withValues(alpha: 0.1) : surface2,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _hovered ? accent.withValues(alpha: 0.4) : border,
            width: 1.1,
          ),
        ),
        child: Text(
          widget.label,
          style: AppTextStyles.bodySmall(context).copyWith(
            color: _hovered ? accent : textMuted,
            fontWeight: _hovered ? FontWeight.w600 : FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

// ── Tech Tag (for projects) ──
class TechTag extends StatelessWidget {
  final String label;
  final Color? customColor;
  const TechTag(this.label, {super.key, this.customColor});

  @override
  Widget build(BuildContext context) {
    final color = customColor ?? AppColors.accent(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Text(
        label,
        style: AppTextStyles.bodySmall(context).copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}

// ── Divider ──
class AppDivider extends StatelessWidget {
  const AppDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: AppColors.border(context).withValues(alpha: 0.8),
    );
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
    final surface2 = AppColors.surface2(context);
    final border = AppColors.border(context);
    final accent = AppColors.accent(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(_hovered ? 6 : 0, 0, 0),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: surface2,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered ? accent.withValues(alpha: 0.4) : border,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? accent.withValues(alpha: 0.08)
                  : AppColors.cardShadow(context),
              blurRadius: _hovered ? 18 : 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(widget.icon, style: const TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: AppTextStyles.headingSmall(context).copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.description,
                    style: AppTextStyles.bodySmall(context).copyWith(
                      height: 1.6,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
