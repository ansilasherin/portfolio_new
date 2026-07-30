
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/responsive/responsive.dart';
import 'package:flutter_portfolio/utils/colors.dart';
import 'package:flutter_portfolio/views/components/about_me.dart';
import 'package:flutter_portfolio/views/components/contact_form.dart';
import 'package:flutter_portfolio/views/components/drawer.dart';
import 'package:flutter_portfolio/views/components/footer.dart';
import 'package:flutter_portfolio/views/components/profile_and_intro.dart';
import 'package:flutter_portfolio/views/components/recent_project.dart';
import 'package:flutter_portfolio/views/components/social_icon.dart';
import 'package:flutter_portfolio/views/components/top_skill.dart';
import 'package:flutter_portfolio/views/components/topbar.dart';

class DeveloperPortFolio extends StatelessWidget {
  DeveloperPortFolio({super.key});
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "Ansila Sherin",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            color: textColor,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 3,
        toolbarHeight: 70,
        actions: [
          Responsive.isMobile(context)
              ? Padding(
                  padding: const EdgeInsets.only(right: 13),
                  child: IconButton(
                    onPressed: () {
                      _globalKey.currentState!.openEndDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: textColor,
                      size: 35,
                    ),
                  ),
                )
              : TopBar(
                  scrollController: _scrollController,
                ),
        ],
      ),
      endDrawer: Responsive.isMobile(context)
          ? MyDrawer(scrollController: _scrollController)
          : null,
      body: SafeArea(
        child: Stack(
          children: [
       
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  const ProfileAndIntro(),
                  SizedBox(height: Responsive.isMobile(context) ? 40 : 0),
                  const AboutMe(),
                  const SizedBox(height: 55),
                  const TopSkills(),
                  const SizedBox(height: 55),
                  const RecentProject(),
                  const SizedBox(height: 55),
                  const ContactForm(),
                  const SizedBox(height: 55),
                  const Footer(),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            const SocialIcons()
          ],
        ),
      ),
    );
  }
}
