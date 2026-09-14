import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/portfolio_model.dart';
import '../theme/app_theme.dart';
import '../utils/launcher.dart';
import 'shared_widgets.dart';

class PortfolioNavBar extends StatelessWidget {
  final ScrollController scrollController;
  final Map<String, GlobalKey> sectionKeys;
  final VoidCallback onMenuTap;

  const PortfolioNavBar({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
    required this.onMenuTap,
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
    final isWide = MediaQuery.of(context).size.width > 860;
    final bg = AppColors.bg(context);
    final border = AppColors.border(context);
    final accent = AppColors.accent(context);
    final text = AppColors.text(context);

    return Container(
      height: AppSizes.navHeight,
      decoration: BoxDecoration(
        color: bg.withValues(alpha: 0.88),
        border: Border(bottom: BorderSide(color: border, width: 1)),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: MaxWidthBox(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                // Logo & Status Dot
                InkWell(
                  onTap: () {
                    scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOutCubic,
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: accent,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: accent.withValues(alpha: 0.6),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          PortfolioData.name,
                          style: GoogleFonts.syne(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: text,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                // Desktop Nav Links
                if (isWide) ...[
                  _NavLink('About',
                      onTap: () => _scrollTo(sectionKeys['about']!)),
                  _NavLink('Skills',
                      onTap: () => _scrollTo(sectionKeys['skills']!)),
                  _NavLink('Projects',
                      onTap: () => _scrollTo(sectionKeys['projects']!)),
                  _NavLink('Articles',
                      onTap: () => _scrollTo(sectionKeys['blog']!)),
                  _NavLink('Contact',
                      onTap: () => _scrollTo(sectionKeys['contact']!)),
                  const SizedBox(width: 12),
                ],

                // Theme Mode Switcher
                const ThemeToggleButton(),
                const SizedBox(width: 12),

                // Resume button on desktop
                if (isWide) ...[
                  PrimaryButton(
                    label: 'Resume',
                    onTap: () => AppLauncher.open(PortfolioData.resumeUrl),
                    icon: Icons.download_rounded,
                    small: true,
                  ),
                ] else ...[
                  // Mobile hamburger button
                  IconButton(
                    onPressed: onMenuTap,
                    icon: Icon(Icons.menu_rounded, color: text, size: 26),
                    tooltip: 'Menu',
                  ),
                ],
              ],
            ),
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
    final accent = AppColors.accent(context);
    final textMuted = AppColors.textMuted(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: AppTextStyles.navLink(context).copyWith(
              color: _hovered ? accent : textMuted,
            ),
            child: Text(widget.label.toUpperCase()),
          ),
        ),
      ),
    );
  }
}
