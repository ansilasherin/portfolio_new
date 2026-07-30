import 'package:flutter/material.dart';
import 'package:flutter_portfolio/newwwwwwwwwwwwwwwwwwwwwwwwwww/theme/app_theme.dart';
import 'package:flutter_portfolio/newwwwwwwwwwwwwwwwwwwwwwwwwww/widget/about_section.dart';
import 'package:flutter_portfolio/newwwwwwwwwwwwwwwwwwwwwwwwwww/widget/blog_contact_section.dart';
import 'package:flutter_portfolio/newwwwwwwwwwwwwwwwwwwwwwwwwww/widget/hero_section.dart';
import 'package:flutter_portfolio/newwwwwwwwwwwwwwwwwwwwwwwwwww/widget/navbar.dart';
import 'package:flutter_portfolio/newwwwwwwwwwwwwwwwwwwwwwwwwww/widget/project_section.dart';
import 'package:flutter_portfolio/newwwwwwwwwwwwwwwwwwwwwwwwwww/widget/shared_widget.dart';
import 'package:flutter_portfolio/newwwwwwwwwwwwwwwwwwwwwwwwwww/widget/skil_section.dart';


class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final _scrollController = ScrollController();
  double _scrollProgress = 0;

  final Map<String, GlobalKey> _sectionKeys = {
    'hero': GlobalKey(),
    'about': GlobalKey(),
    'skills': GlobalKey(),
    'projects': GlobalKey(),
    'blog': GlobalKey(),
    'contact': GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final max = _scrollController.position.maxScrollExtent;
    final current = _scrollController.offset;
    setState(() => _scrollProgress = max > 0 ? current / max : 0);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // Main scrollable content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Nav bar
              SliverPersistentHeader(
                pinned: true,
                delegate: _NavDelegate(
                  scrollController: _scrollController,
                  sectionKeys: _sectionKeys,
                ),
              ),

              // Content sections
              SliverList(
                delegate: SliverChildListDelegate([
                  KeyedSubtree(
                    key: _sectionKeys['hero'],
                    child: const HeroSection(),
                  ),
                  const AppDivider(),
                  KeyedSubtree(
                    key: _sectionKeys['about'],
                    child: const AboutSection(),
                  ),
                  const AppDivider(),
                  KeyedSubtree(
                    key: _sectionKeys['skills'],
                    child: const SkillsSection(),
                  ),
                  const AppDivider(),
                  KeyedSubtree(
                    key: _sectionKeys['projects'],
                    child: const ProjectsSection(),
                  ),
                  const AppDivider(),
                  KeyedSubtree(
                    key: _sectionKeys['blog'],
                    child: const BlogSection(),
                  ),
                  const AppDivider(),
                  KeyedSubtree(
                    key: _sectionKeys['contact'],
                    child: const ContactSection(),
                  ),
                  const PortfolioFooter(),
                ]),
              ),
            ],
          ),

          // Scroll progress bar
          Positioned(
            top: 0, left: 0, right: 0,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  height: 2,
                  alignment: Alignment.centerLeft,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    width: constraints.maxWidth * _scrollProgress,
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.accent, AppColors.accent2],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accent.withOpacity(0.5),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NavDelegate extends SliverPersistentHeaderDelegate {
  final ScrollController scrollController;
  final Map<String, GlobalKey> sectionKeys;

  _NavDelegate({required this.scrollController, required this.sectionKeys});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return PortfolioNavBar(
      scrollController: scrollController,
      sectionKeys: sectionKeys,
    );
  }

  @override
  double get maxExtent => AppSizes.navHeight;
  @override
  double get minExtent => AppSizes.navHeight;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
