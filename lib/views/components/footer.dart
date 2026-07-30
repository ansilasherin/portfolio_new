import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('© Copyright 2024'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Built with ❤ by",
            ),
            TextButton(
                onPressed: () {},
                child: const Text(
                  "Ansila Sherin",
                ))
          ],
        )
      ],
    );
  }
}
// git commit -m "web hostingg"
// git remote add origin https://github.com/ansilasherin/ansila.github.io.git
//<base href="/ansila.github.io.git/">
