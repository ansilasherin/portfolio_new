import 'package:flutter_portfolio/responsive/responsive.dart';
import 'package:flutter_portfolio/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialIcons extends StatelessWidget {
  const SocialIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return  Positioned(
      right: 5,
      top: Responsive.isMobile(context)
          ? Responsive.heightOfScreen(context) * 0.1
          : Responsive.heightOfScreen(context) * 0.2,
      child: const SizedBox(
        height: 200,
        width: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
       
            SocialIconDesign(
                socialLink: "https://github.com/ansilasherin",
                iconUrl:
                    'https://cdn-icons-png.freepik.com/256/11023/11023876.png'),
            SocialIconDesign(
                socialLink:
                    "https://www.linkedin.com/in/ansila-sherin-7a3110216/",
                iconUrl:
                    'https://static.vecteezy.com/system/resources/previews/016/716/470/non_2x/linkedin-icon-free-png.png'),
          ],
        ),
      ),
    );
  }
}

class SocialIconDesign extends StatelessWidget {
  final String iconUrl;
  final String socialLink;
  const SocialIconDesign({
    super.key,
    required this.iconUrl,
    required this.socialLink,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      backgroundColor: Colors.transparent,
      onPressed: () {
        launchUrl(
          Uri.parse(socialLink),
        );
      },
      child: Image.network(
        iconUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}