import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../models/portfolio_model.dart';
import '../theme/app_theme.dart';
import 'shared_widgets.dart';

class AboutSection extends StatelessWidget {
  final VoidCallback? onSeeWorkTap;
  const AboutSection({super.key, this.onSeeWorkTap});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 920;
    final surface = AppColors.surface(context);

    return Container(
      color: surface,
      padding: const EdgeInsets.symmetric(vertical: AppSizes.sectionPadding),
      child: MaxWidthBox(
        child: isWide
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: _AboutText(onSeeWorkTap: onSeeWorkTap),
                  ),
                  const SizedBox(width: 56),
                  Expanded(
                    flex: 5,
                    child: _HighlightsList(),
                  ),
                ],
              )
            : Column(
                children: [
                  _AboutText(onSeeWorkTap: onSeeWorkTap),
                  const SizedBox(height: 48),
                  _HighlightsList(),
                ],
              ),
      ),
    );
  }
}

class _AboutText extends StatelessWidget {
  final VoidCallback? onSeeWorkTap;
  const _AboutText({this.onSeeWorkTap});

  @override
  Widget build(BuildContext context) {
    final accent = AppColors.accent(context);
    final text = AppColors.text(context);

    return FadeInLeft(
      duration: const Duration(milliseconds: 700),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionLabel('About Me'),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              style: AppTextStyles.displayMedium(context).copyWith(height: 1.15),
              children: [
                TextSpan(
                  text: 'Building apps that\n',
                  style: TextStyle(color: text),
                ),
                TextSpan(
                  text: 'scale in production',
                  style: TextStyle(color: accent),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          _AboutParagraph(),
          const SizedBox(height: 16),
          Text(
            'My approach to development prioritizes structured thinking — from token-based authentication and secure session persistence to clean separation of concerns across data, domain, and presentation layers.',
            style: AppTextStyles.bodyLarge(context),
          ),
          const SizedBox(height: 16),
          Text(
            'I am comfortable working with Firebase, Hive, and SharedPreferences for local and cloud data solutions, and I use Postman to validate and debug API integrations before implementing them in code.',
            style: AppTextStyles.bodyLarge(context),
          ),
          if (onSeeWorkTap != null) ...[
            const SizedBox(height: 28),
            _SeeWorkButton(onTap: onSeeWorkTap!),
          ],
        ],
      ),
    );
  }
}

class _AboutParagraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final text = AppColors.text(context);
    final accent = AppColors.accent(context);

    return RichText(
      text: TextSpan(
        style: AppTextStyles.bodyLarge(context),
        children: [
          const TextSpan(text: 'I am a '),
          TextSpan(
            text: 'BCA graduate',
            style: AppTextStyles.bodyLarge(context).copyWith(
              color: text,
              fontWeight: FontWeight.w700,
            ),
          ),
          const TextSpan(
              text: ' and passionate Flutter developer with a strong understanding of '),
          TextSpan(
            text: 'MVVM architecture',
            style: AppTextStyles.bodyLarge(context).copyWith(
              color: accent,
              fontWeight: FontWeight.w700,
            ),
          ),
          const TextSpan(
            text:
                ', state management using Provider, and RESTful API integration. I focus on writing clean, maintainable, and scalable code.',
          ),
        ],
      ),
    );
  }
}

class _SeeWorkButton extends StatefulWidget {
  final VoidCallback onTap;
  const _SeeWorkButton({required this.onTap});

  @override
  State<_SeeWorkButton> createState() => _SeeWorkButtonState();
}

class _SeeWorkButtonState extends State<_SeeWorkButton> {
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: AppTextStyles.bodyMedium(context).copyWith(
                color: _hovered ? accent : textMuted,
                fontWeight: FontWeight.w600,
              ),
              child: const Text('Explore my projects'),
            ),
            const SizedBox(width: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: Matrix4.translationValues(_hovered ? 6 : 0, 0, 0),
              child: Icon(
                Icons.arrow_forward_rounded,
                size: 16,
                color: _hovered ? accent : textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HighlightsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      duration: const Duration(milliseconds: 700),
      child: Column(
        children: PortfolioData.highlights
            .map(
              (h) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: HighlightCard(
                  icon: h.icon,
                  title: h.title,
                  description: h.description,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
