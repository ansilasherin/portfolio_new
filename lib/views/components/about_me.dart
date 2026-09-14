
import 'package:flutter_portfolio/responsive/responsive.dart';
import 'package:flutter/material.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isMobile(context) ? 40 : 80,
      ),
      child: Column(
        children: [
          const Center(
            child: Text(
              "About Me",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            "Hello! I'm  Ansila Sherin,\na  Flutter developer specializing in Flutter, Firebase, API integration, and UI design. With a keen eye for detail and a drive for excellence, I strive to create seamless and engaging mobile applications.\n",
            style: TextStyle(
              fontSize: Responsive.isMobile(context) ? 18 : 20,
            ),
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}
