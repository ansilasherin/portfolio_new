import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_portfolio/newwwwwwwwwwwwwwwwwwwwwwwwwww/model/portmodel.dart';
import 'package:flutter_portfolio/newwwwwwwwwwwwwwwwwwwwwwwwwww/utils/lanchure.dart';
import 'package:flutter_portfolio/newwwwwwwwwwwwwwwwwwwwwwwwwww/widget/shared_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulse = Tween(begin: 1.0, end: 0.4).animate(
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
    final w = MediaQuery.of(context).size.width;
    final isWide = w > 900;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 700),
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0.6, -0.4),
          radius: 1.2,
          colors: [Color(0xFF0F1A16), AppColors.bg],
        ),
      ),
      child: Stack(
        children: [
          // Background glows
          Positioned(
            top: -80, right: -80,
            child: Container(
              width: 500, height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [
                  AppColors.accent.withOpacity(0.06),
                  Colors.transparent,
                ]),
              ),
            ),
          ),
          Positioned(
            bottom: 80, left: -60,
            child: Container(
              width: 300, height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [
                  AppColors.accent2.withOpacity(0.06),
                  Colors.transparent,
                ]),
              ),
            ),
          ),

          // Content
          MaxWidthBox(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 80),
            child: isWide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 6, child: _HeroLeft(pulse: _pulse)),
                      const SizedBox(width: 64),
                      Expanded(flex: 4, child: const _HeroRight()),
                    ],
                  )
                : _HeroLeft(pulse: _pulse),
          ),
        ],
      ),
    );
  }
}

// ── Left Column ──
class _HeroLeft extends StatelessWidget {
  final Animation<double> pulse;
  const _HeroLeft({required this.pulse});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Available badge
        FadeInDown(
          duration: const Duration(milliseconds: 600),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.08),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: AppColors.accent.withOpacity(0.25)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: pulse,
                  builder: (_, __) => Opacity(
                    opacity: pulse.value,
                    child: Container(
                      width: 6, height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Available for opportunities',
                  style: AppTextStyles.label.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Name
        FadeInDown(
          delay: const Duration(milliseconds: 100),
          duration: const Duration(milliseconds: 600),
          child: Text(PortfolioData.name, style: AppTextStyles.displayLarge),
        ),
        const SizedBox(height: 10),

        // Title
        FadeInDown(
          delay: const Duration(milliseconds: 200),
          duration: const Duration(milliseconds: 600),
          child: Text(
            'Flutter Developer · Clean Architecture · REST API',
            style: GoogleFonts.syne(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.accent,
              letterSpacing: 0.2,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Tagline
        FadeInDown(
          delay: const Duration(milliseconds: 300),
          duration: const Duration(milliseconds: 600),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Text(PortfolioData.tagline, style: AppTextStyles.bodyLarge),
          ),
        ),
        const SizedBox(height: 36),

        // CTA Buttons
        FadeInDown(
          delay: const Duration(milliseconds: 400),
          duration: const Duration(milliseconds: 600),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              PrimaryButton(
                label: 'View Projects',
                onTap: () {},
                icon: Icons.arrow_forward_rounded,
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
      child: Column(
        children: [
          const StatCard(
            label: 'Primary Focus',
            value: 'Flutter',
            subtitle: 'MVVM · Provider · REST API',
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: StatCard(
                  label: 'Architecture',
                  value: 'Clean',
                  subtitle: 'MVVM Pattern',
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: StatCard(
                  label: 'Projects',
                  value: '3+',
                  subtitle: 'Production ready',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const StatCard(
            label: 'Education',
            value: 'BCA Graduate',
            subtitle: 'Computer Applications',
          ),
        ],
      ),
    );
  }
}
