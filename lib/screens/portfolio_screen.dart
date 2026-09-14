import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/about_section.dart';
import '../widgets/articles_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/footer.dart';
import '../widgets/hero_section.dart';
import '../widgets/mobile_drawer.dart';
import '../widgets/navbar.dart';
import '../widgets/projects_section.dart';
import '../widgets/shared_widgets.dart';
import '../widgets/skills_section.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double _scrollProgress = 0.0;

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
    if (!_scrollController.hasClients) return;
    final max = _scrollController.position.maxScrollExtent;
    final current = _scrollController.offset;
    setState(() => _scrollProgress = max > 0 ? (current / max).clamp(0.0, 1.0) : 0.0);
  }

  void _scrollToSection(String sectionKey) {
    final key = _sectionKeys[sectionKey];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bg = AppColors.bg(context);
    final accent = AppColors.accent(context);
    final accent2 = AppColors.accent2(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: bg,
      endDrawer: MobileDrawer(
        scrollController: _scrollController,
        sectionKeys: _sectionKeys,
      ),
      body: Stack(
        children: [
          // Main scrollable content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Pinned navigation bar header
              SliverPersistentHeader(
                pinned: true,
                delegate: _NavDelegate(
                  scrollController: _scrollController,
                  sectionKeys: _sectionKeys,
                  onMenuTap: () => _scaffoldKey.currentState?.openEndDrawer(),
                ),
              ),

              // Content Sections
              SliverList(
                delegate: SliverChildListDelegate([
                  KeyedSubtree(
                    key: _sectionKeys['hero'],
                    child: HeroSection(
                      onViewProjectsTap: () => _scrollToSection('projects'),
                    ),
                  ),
                  const AppDivider(),
                  KeyedSubtree(
                    key: _sectionKeys['about'],
                    child: AboutSection(
                      onSeeWorkTap: () => _scrollToSection('projects'),
                    ),
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
                    child: const ArticlesSection(),
                  ),
                  const AppDivider(),
                  KeyedSubtree(
                    key: _sectionKeys['contact'],
                    child: const ContactSection(),
                  ),
                  PortfolioFooter(
                    onBackToTop: _scrollToTop,
                  ),
                ]),
              ),
            ],
          ),

          // Top reading scroll progress bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  height: 3,
                  alignment: Alignment.centerLeft,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 50),
                    width: constraints.maxWidth * _scrollProgress,
                    height: 3,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [accent, accent2],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: accent.withValues(alpha: 0.6),
                          blurRadius: 6,
                          offset: const Offset(0, 1),
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
  final VoidCallback onMenuTap;

  _NavDelegate({
    required this.scrollController,
    required this.sectionKeys,
    required this.onMenuTap,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return PortfolioNavBar(
      scrollController: scrollController,
      sectionKeys: sectionKeys,
      onMenuTap: onMenuTap,
    );
  }

  @override
  double get maxExtent => AppSizes.navHeight;
  @override
  double get minExtent => AppSizes.navHeight;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
