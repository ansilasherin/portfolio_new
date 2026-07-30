import 'package:flutter_portfolio/responsive/responsive.dart';
import 'package:flutter_portfolio/utils/colors.dart';
import 'package:flutter/material.dart';

class ProfileAndIntro extends StatelessWidget {
  const ProfileAndIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          children: [
            SizedBox(
              width: Responsive.isMobile(context)
                  // it take full widt in mobile screen but only tkes half width in web and desktop
                  ? Responsive.widthOfScreen(context)
                  : Responsive.widthOfScreen(context) / 2,
              height: Responsive.isMobile(context)
                  ? Responsive.heightOfScreen(context) / 3
                  : Responsive.heightOfScreen(context) - 70,
              child: Image.network("https://cdni.iconscout.com/illustration/premium/thumb/web-development-service-illustration-download-in-svg-png-gif-file-formats--programmer-working-website-developer-pack-people-illustrations-3766902.png?f=webp"),
            ),
            SizedBox(
              width: Responsive.isMobile(context)
                  // it take full widt in mobile screen but only tkes half width in web and desktop
                  ? Responsive.widthOfScreen(context)
                  : Responsive.widthOfScreen(context) / 2,
              height: Responsive.isMobile(context)
                  ? Responsive.heightOfScreen(context) / 3
                  : Responsive.heightOfScreen(context) - 70,
              child: Center(
                child: SizedBox(
                  height: 250,
                  width: Responsive.isMobile(context)
                      ? Responsive.widthOfScreen(context) * 0.85
                      : 450,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: const[
                         BoxShadow(
                          color: Colors.grey,
                          blurRadius: 8,
                          spreadRadius: 5,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hello!",
                            style: TextStyle(
                              fontSize: Responsive.isMobile(context)?36:40,
                              color: Colors.red,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const Text(
                            "I'm Ansila Sherin,\na Flutter Developer & Content Creator\nSpecializing in Flutter App Decelopemnt and UI Design.",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}