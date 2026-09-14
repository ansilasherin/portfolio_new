import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animate_do/animate_do.dart';
import '../models/portfolio_model.dart';
import '../theme/app_theme.dart';
import '../utils/launcher.dart';
import 'shared_widgets.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final surface = AppColors.surface(context);

    return Container(
      color: surface,
      padding: const EdgeInsets.symmetric(vertical: AppSizes.sectionPadding),
      child: MaxWidthBox(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: FadeInUp(
              child: Column(
                children: [
                  const SectionLabel('Get In Touch'),
                  const SizedBox(height: 16),
                  Text(
                    "Let's build something exceptional",
                    style: AppTextStyles.displayMedium(context).copyWith(
                      fontSize:
                          MediaQuery.of(context).size.width < 600 ? 30 : 38,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: Text(
                      'I am currently open to Flutter developer positions, internships, and freelance collaborations. Feel free to connect or drop a message!',
                      style: AppTextStyles.bodyLarge(context),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 44),

                  // Interactive Contact Links Grid
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: [
                      _ContactLink(
                        label: PortfolioData.email,
                        subLabel: 'Email me directly',
                        icon: Icons.email_outlined,
                        onTap: () => AppLauncher.email(PortfolioData.email),
                        onCopy: () {
                          Clipboard.setData(
                              const ClipboardData(text: PortfolioData.email));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Email copied to clipboard!'),
                              behavior: SnackBarBehavior.floating,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                      _ContactLink(
                        label: 'GitHub Profile',
                        subLabel: 'Explore repositories',
                        icon: Icons.code_rounded,
                        onTap: () => AppLauncher.open(PortfolioData.githubUrl),
                      ),
                      _ContactLink(
                        label: 'LinkedIn Profile',
                        subLabel: "Let's connect",
                        icon: Icons.link_rounded,
                        onTap: () => AppLauncher.open(PortfolioData.linkedinUrl),
                      ),
                      _ContactLink(
                        label: 'Resume PDF',
                        subLabel: 'Download full CV',
                        icon: Icons.download_rounded,
                        onTap: () => AppLauncher.open(PortfolioData.resumeUrl),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ContactLink extends StatefulWidget {
  final String label;
  final String subLabel;
  final IconData icon;
  final VoidCallback onTap;
  final VoidCallback? onCopy;

  const _ContactLink({
    required this.label,
    required this.subLabel,
    required this.icon,
    required this.onTap,
    this.onCopy,
  });

  @override
  State<_ContactLink> createState() => _ContactLinkState();
}

class _ContactLinkState extends State<_ContactLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final surface2 = AppColors.surface2(context);
    final border = AppColors.border(context);
    final accent = AppColors.accent(context);
    final text = AppColors.text(context);
    final textDim = AppColors.textDim(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
          width: 320,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: surface2,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered ? accent.withValues(alpha: 0.5) : border,
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: _hovered
                    ? accent.withValues(alpha: 0.1)
                    : AppColors.cardShadow(context),
                blurRadius: _hovered ? 20 : 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(widget.icon, size: 20, color: accent),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: AppTextStyles.headingSmall(context).copyWith(
                        fontSize: 15,
                        color: _hovered ? accent : text,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.subLabel,
                      style: AppTextStyles.bodySmall(context).copyWith(
                        color: textDim,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.onCopy != null) ...[
                IconButton(
                  onPressed: widget.onCopy,
                  icon: Icon(Icons.copy_rounded, size: 16, color: textDim),
                  tooltip: 'Copy',
                ),
              ] else ...[
                Icon(
                  Icons.arrow_outward_rounded,
                  size: 16,
                  color: _hovered ? accent : textDim,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
