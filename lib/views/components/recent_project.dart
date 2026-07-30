import 'package:flutter_portfolio/models/project_model.dart';
import 'package:flutter_portfolio/responsive/responsive.dart';
import 'package:flutter_portfolio/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RecentProject extends StatelessWidget {
  const RecentProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Some of My Recent Projects",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}

class ProjectCard extends StatelessWidget {
  final ProjectModel projectModel;
  final String url;
  const ProjectCard({super.key, required this.projectModel, required this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: DecoratedBox(
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
            spreadRadius: 3,
          ),
        ], borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: SizedBox(
          width: Responsive.isMobile(context)
              ? Responsive.widthOfScreen(context) * 0.9
              : Responsive.widthOfScreen(context) / 4,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Image.network(projectModel.imgURL),
              ),
              Text(
                projectModel.projectName,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  projectModel.description!,
                  maxLines: 5,
                  style: const TextStyle(
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //     top: 15,
              //     bottom: 6,
              //   ),
              //   child: TextButton(
              //     onPressed: () {
              //       launchUrl(
              //         Uri.parse(url),
              //       );
              //     },
              //     child: const Text(
              //       "Check In Out",
              //       style: TextStyle(fontSize: 17),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}