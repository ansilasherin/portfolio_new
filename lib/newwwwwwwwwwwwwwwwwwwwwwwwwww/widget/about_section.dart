import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_portfolio/newwwwwwwwwwwwwwwwwwwwwwwwwww/model/portmodel.dart';
import 'package:flutter_portfolio/newwwwwwwwwwwwwwwwwwwwwwwwwww/widget/shared_widget.dart';
import '../theme/app_theme.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(vertical: AppSizes.sectionPadding),
      child: MaxWidthBox(
        child: isWide
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 5, child: _AboutText()),
                  const SizedBox(width: 64),
                  Expanded(flex: 5, child: _HighlightsList()),
                ],
              )
            : Column(
                children: [
                  _AboutText(),
                  const SizedBox(height: 40),
                  _HighlightsList(),
                ],
              ),
      ),
    );
  }
}

class _AboutText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 700),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionLabel('About Me'),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              style: AppTextStyles.displayMedium.copyWith(height: 1.15),
              children: const [
                TextSpan(text: 'Building apps that\n'),
                TextSpan(
                  text: 'scale in production',
                  style: TextStyle(color: AppColors.accent),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          _AboutParagraph(
            text: 'I am a ',
            boldParts: {
              'BCA graduate': false,
              'passionate Flutter developer': false,
            },
            body:
                'I am a BCA graduate and passionate Flutter developer with a strong understanding of MVVM architecture, state management using Provider, and RESTful API integration. I focus on writing clean, maintainable, and scalable code.',
          ),
          const SizedBox(height: 16),
          Text(
            'My approach to development prioritizes structured thinking — from token-based authentication and secure session persistence to clean separation of concerns across data, domain, and presentation layers.',
            style: AppTextStyles.bodyLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'I am comfortable working with Firebase, Hive, and SharedPreferences for local and cloud data solutions, and I use Postman to validate and debug API integrations before implementing them in code.',
            style: AppTextStyles.bodyLarge,
          ),
          const SizedBox(height: 28),
          _SeeWorkButton(),
        ],
      ),
    );
  }
}

class _AboutParagraph extends StatelessWidget {
  final String body;
  final String text;
  final Map<String, bool> boldParts;

  const _AboutParagraph({
    required this.body,
    required this.text,
    required this.boldParts,
  });

  @override
  Widget build(BuildContext context) {
    // Simple highlighted version
    return RichText(
      text: TextSpan(
        style: AppTextStyles.bodyLarge,
        children: [
          TextSpan(text: 'I am a '),
          TextSpan(
            text: 'BCA graduate',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.text,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(text: ' and passionate Flutter developer with a strong understanding of '),
          TextSpan(
            text: 'MVVM architecture',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.text,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text:
                ', state management using Provider, and RESTful API integration. I focus on writing clean, maintainable, and scalable code.',
          ),
        ],
      ),
    );
  }
}

class _SeeWorkButton extends StatefulWidget {
  @override
  State<_SeeWorkButton> createState() => _SeeWorkButtonState();
}

class _SeeWorkButtonState extends State<_SeeWorkButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: AppTextStyles.bodyMedium.copyWith(
                color: _hovered ? AppColors.accent : AppColors.textMuted,
                fontWeight: FontWeight.w500,
              ),
              child: const Text('See my work'),
            ),
            const SizedBox(width: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: Matrix4.translationValues(_hovered ? 4 : 0, 0, 0),
              child: Icon(
                Icons.arrow_forward_rounded,
                size: 16,
                color: _hovered ? AppColors.accent : AppColors.textMuted,
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
                padding: const EdgeInsets.only(bottom: 12),
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
