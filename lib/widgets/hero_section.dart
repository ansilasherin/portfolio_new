import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/portfolio_model.dart';
import '../theme/app_theme.dart';
import '../utils/launcher.dart';
import 'shared_widgets.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback? onViewProjectsTap;
  const HeroSection({super.key, this.onViewProjectsTap});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulse = Tween(begin: 1.0, end: 0.35).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDarkMode(context);
    final w = MediaQuery.of(context).size.width;
    final isWide = w > 940;
    final bg = AppColors.bg(context);
    final accent = AppColors.accent(context);
    final accent2 = AppColors.accent2(context);

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 700),
      decoration: BoxDecoration(
        color: bg,
        gradient: isDark
            ? const RadialGradient(
                center: Alignment(0.65, -0.3),
                radius: 1.25,
                colors: [Color(0xFF0F1C18), Color(0xFF0C0D10)],
              )
            : const RadialGradient(
                center: Alignment(0.65, -0.3),
                radius: 1.25,
                colors: [Color(0xFFE6F7F3), Color(0xFFF8FAFC)],
              ),
      ),
      child: Stack(
        children: [
          // Background ambient light glow 1
          Positioned(
            top: -100,
            right: -100,
            child: IgnorePointer(
              child: Container(
                width: 550,
                height: 550,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      accent.withValues(alpha: isDark ? 0.08 : 0.12),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Background ambient light glow 2
          Positioned(
            bottom: 60,
            left: -80,
            child: IgnorePointer(
              child: Container(
                width: 380,
                height: 380,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      accent2.withValues(alpha: isDark ? 0.07 : 0.09),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Content
          MaxWidthBox(
            padding: EdgeInsets.symmetric(
              horizontal: 28,
              vertical: isWide ? 90 : 60,
            ),
            child: isWide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 6,
                        child: _HeroLeft(
                          pulse: _pulse,
                          onViewProjectsTap: widget.onViewProjectsTap,
                        ),
                      ),
                      const SizedBox(width: 56),
                      const Expanded(
                        flex: 4,
                        child: _HeroRight(),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _HeroLeft(
                        pulse: _pulse,
                        onViewProjectsTap: widget.onViewProjectsTap,
                      ),
                      const SizedBox(height: 48),
                      const _HeroRight(),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

// ── Left Column ──
class _HeroLeft extends StatelessWidget {
  final Animation<double> pulse;
  final VoidCallback? onViewProjectsTap;

  const _HeroLeft({
    required this.pulse,
    this.onViewProjectsTap,
  });

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accent(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Available for work badge
        FadeInDown(
          duration: const Duration(milliseconds: 600),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: accent.withValues(alpha: 0.3), width: 1.1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: pulse,
                  builder: (_, __) => Opacity(
                    opacity: pulse.value,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: accent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: accent.withValues(alpha: 0.8),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 9),
                Text(
                  'AVAILABLE FOR OPPORTUNITIES',
                  style: AppTextStyles.label(context).copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Name
        FadeInDown(
          delay: const Duration(milliseconds: 120),
          duration: const Duration(milliseconds: 600),
          child: Text(
            PortfolioData.name,
            style: AppTextStyles.displayLarge(context).copyWith(
              fontSize: MediaQuery.of(context).size.width < 600 ? 40 : 54,
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Title / Role
        FadeInDown(
          delay: const Duration(milliseconds: 220),
          duration: const Duration(milliseconds: 600),
          child: Text(
            PortfolioData.title,
            style: GoogleFonts.syne(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: accent,
              letterSpacing: 0.2,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Tagline
        FadeInDown(
          delay: const Duration(milliseconds: 320),
          duration: const Duration(milliseconds: 600),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 540),
            child: Text(
              PortfolioData.tagline,
              style: AppTextStyles.bodyLarge(context).copyWith(
                fontSize: 16,
                height: 1.7,
              ),
            ),
          ),
        ),
        const SizedBox(height: 36),

        // CTA Buttons
        FadeInDown(
          delay: const Duration(milliseconds: 420),
          duration: const Duration(milliseconds: 600),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (onViewProjectsTap != null)
                PrimaryButton(
                  label: 'View Projects',
                  onTap: onViewProjectsTap!,
                  icon: Icons.arrow_downward_rounded,
                ),
              GhostButton(
                label: 'GitHub',
                onTap: () => AppLauncher.open(PortfolioData.githubUrl),
                icon: Icons.code_rounded,
              ),
              GhostButton(
                label: 'LinkedIn',
                onTap: () => AppLauncher.open(PortfolioData.linkedinUrl),
                icon: Icons.link_rounded,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Right Column - Stat Cards ──
class _HeroRight extends StatelessWidget {
  const _HeroRight();

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      duration: const Duration(milliseconds: 700),
      child: const Column(
        children: [
          StatCard(
            label: 'Core Expertise',
            value: 'Flutter & Dart',
            subtitle: 'MVVM · Provider · REST API · Firebase',
          ),
          SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: StatCard(
                  label: 'Architecture',
                  value: 'Clean / MVVM',
                  subtitle: 'Separation of concerns',
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: StatCard(
                  label: 'Experience',
                  value: '3+ Apps',
                  subtitle: 'Production standard',
                ),
              ),
            ],
          ),
          SizedBox(height: 14),
          StatCard(
            label: 'Education',
            value: 'BCA Graduate',
            subtitle: 'Bachelor of Computer Applications',
          ),
        ],
      ),
    );
  }
}
