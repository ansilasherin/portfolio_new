import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/portfolio_model.dart';
import '../theme/app_theme.dart';
import '../utils/launcher.dart';
import 'shared_widgets.dart';

class MobileDrawer extends StatelessWidget {
  final ScrollController scrollController;
  final Map<String, GlobalKey> sectionKeys;

  const MobileDrawer({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
  });

  void _scrollTo(BuildContext context, GlobalKey key) {
    Navigator.of(context).pop();
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bg = AppColors.surface(context);
    final border = AppColors.border(context);
    final text = AppColors.text(context);
    final textMuted = AppColors.textMuted(context);

    return Drawer(
      backgroundColor: bg,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    PortfolioData.name,
                    style: GoogleFonts.syne(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: text,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close_rounded, color: textMuted),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const AppDivider(),
              const SizedBox(height: 24),

              // Navigation Links
              _DrawerItem(
                title: 'About Me',
                icon: Icons.person_outline_rounded,
                onTap: () => _scrollTo(context, sectionKeys['about']!),
              ),
              _DrawerItem(
                title: 'Technical Skills',
                icon: Icons.code_rounded,
                onTap: () => _scrollTo(context, sectionKeys['skills']!),
              ),
              _DrawerItem(
                title: 'Featured Projects',
                icon: Icons.layers_outlined,
                onTap: () => _scrollTo(context, sectionKeys['projects']!),
              ),
              _DrawerItem(
                title: 'Technical Articles',
                icon: Icons.article_outlined,
                onTap: () => _scrollTo(context, sectionKeys['blog']!),
              ),
              _DrawerItem(
                title: 'Get In Touch',
                icon: Icons.mail_outline_rounded,
                onTap: () => _scrollTo(context, sectionKeys['contact']!),
              ),

              const SizedBox(height: 24),
              const AppDivider(),
              const SizedBox(height: 24),

              // Theme Mode switch row
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.surface2(context),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: border),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Appearance',
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: text,
                      ),
                    ),
                    const ThemeToggleButton(),
                  ],
                ),
              ),

              const Spacer(),

              // Resume Button
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  label: 'Download Resume',
                  onTap: () {
                    Navigator.of(context).pop();
                    AppLauncher.open(PortfolioData.resumeUrl);
                  },
                  icon: Icons.download_rounded,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final text = AppColors.text(context);
    final accent = AppColors.accent(context);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      leading: Icon(icon, color: accent, size: 22),
      title: Text(
        title,
        style: GoogleFonts.dmSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: text,
        ),
      ),
      trailing:
          Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textDim(context)),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
