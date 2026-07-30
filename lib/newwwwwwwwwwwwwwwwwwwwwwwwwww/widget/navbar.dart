import 'package:flutter/material.dart';
import 'package:flutter_portfolio/newwwwwwwwwwwwwwwwwwwwwwwwwww/model/portmodel.dart';
import 'package:flutter_portfolio/newwwwwwwwwwwwwwwwwwwwwwwwwww/utils/lanchure.dart';
import 'package:flutter_portfolio/newwwwwwwwwwwwwwwwwwwwwwwwwww/widget/shared_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class PortfolioNavBar extends StatelessWidget {
  final ScrollController scrollController;
  final Map<String, GlobalKey> sectionKeys;

  const PortfolioNavBar({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
  });

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;

    return Container(
      height: AppSizes.navHeight,
      decoration: BoxDecoration(
        color: AppColors.bg.withOpacity(0.9),
        border: const Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: BackdropFilter(
        filter: const ColorFilter.matrix([
          1, 0, 0, 0, 0,
          0, 1, 0, 0, 0,
          0, 0, 1, 0, 0,
          0, 0, 0, 0.92, 0,
        ]),
        child: MaxWidthBox(
          child: Row(
            children: [
              // Logo
              Text(
                'Ansila Sherin Np',
                style: GoogleFonts.syne(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.accent,
                  letterSpacing: 0.3,
                ),
              ),
              const Spacer(),

              // Nav Links (desktop only)
              if (isWide) ...[
                _NavLink('About', onTap: () => _scrollTo(sectionKeys['about']!)),
                _NavLink('Skills', onTap: () => _scrollTo(sectionKeys['skills']!)),
                _NavLink('Projects', onTap: () => _scrollTo(sectionKeys['projects']!)),
                _NavLink('Articles', onTap: () => _scrollTo(sectionKeys['blog']!)),
                _NavLink('Contact', onTap: () => _scrollTo(sectionKeys['contact']!)),
                const SizedBox(width: 24),
              ],

              PrimaryButton(
                label: 'Resume',
                onTap: () => AppLauncher.open(PortfolioData.resumeUrl),
                icon: Icons.download_rounded,
                small: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavLink(this.label, {required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: AppTextStyles.navLink.copyWith(
              color: _hovered ? AppColors.accent : AppColors.textMuted,
            ),
            child: Text(widget.label.toUpperCase()),
          ),
        ),
      ),
    );
  }
}
