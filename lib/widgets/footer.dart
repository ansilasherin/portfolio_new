import 'package:flutter/material.dart';
import '../models/portfolio_model.dart';
import '../theme/app_theme.dart';
import 'shared_widgets.dart';

class PortfolioFooter extends StatelessWidget {
  final VoidCallback? onBackToTop;

  const PortfolioFooter({super.key, this.onBackToTop});

  @override
  Widget build(BuildContext context) {
    final border = AppColors.border(context);
    final accent = AppColors.accent(context);
    final textMuted = AppColors.textMuted(context);
    final textDim = AppColors.textDim(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.bg(context),
        border: Border(top: BorderSide(color: border, width: 1)),
      ),
      child: MaxWidthBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Attribution
            Expanded(
              child: Text.rich(
                TextSpan(
                  style: AppTextStyles.bodySmall(context).copyWith(
                    color: textDim,
                    fontSize: 13,
                  ),
                  children: [
                    const TextSpan(text: 'Designed & crafted by '),
                    TextSpan(
                      text: PortfolioData.name,
                      style: TextStyle(
                        color: textMuted,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const TextSpan(text: '  ·  Flutter Developer  ·  '),
                    TextSpan(
                      text: '2025',
                      style: TextStyle(
                        color: accent,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Back to top button
            if (onBackToTop != null)
              IconButton(
                onPressed: onBackToTop,
                icon: Icon(Icons.arrow_upward_rounded, color: accent, size: 20),
                tooltip: 'Back to top',
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.surface2(context),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: border),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
