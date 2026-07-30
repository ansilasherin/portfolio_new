class ProjectModel {
  final String imgURL;
  final String projectName;
  final String? description;

  ProjectModel({
    required this.imgURL,
    required this.projectName,
    this.description,
  });
}
// this is the mode that i have already created.
List<ProjectModel> projects = [
  ProjectModel(
    description:
        "A Vehicle Services app that combines vehicle servicing and online selling is a comprehensive platform designed to address the needs ofvehicle owners. This type of app offers a wide range of features and services to cater to both vehicle maintenance and buying/selling vehicles and automotive parts  .",
    imgURL: 'assets/images/vehh.png',
    projectName: 'Vehicle Services App',
  ),
  ProjectModel(
    description:
        "An E-commerce App using the Provider package in Flutter allows users to browse, search, and purchase products. The Provider package manages the state of the application, ensuring smooth navigation and data updates across different parts of the app.",
    imgURL: 'assets/images/ecom.png',
    projectName: 'E-commerce App',
  ),
  ProjectModel(
    description:
        "A News App using an API provides users with the latest news articles and updates by fetching data from various news sources. The app can categorize news by topics such as sports, technology, politics, and entertainment, and often includes features like search, bookmarking, and push notifications for breaking news",
    imgURL: 'assets/images/newsicon.png',
    projectName: 'News App',
  ),
 
];