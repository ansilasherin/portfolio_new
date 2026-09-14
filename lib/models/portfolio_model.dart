import 'package:flutter/material.dart';

// ── Project Model ──
class Project {
  final String number;
  final String name;
  final String description;
  final List<String> features;
  final List<String> techStack;
  final String githubUrl;
  final String architectureNote;
  final Color darkAccentColor;
  final Color lightAccentColor;
  final bool isFeatured;

  const Project({
    required this.number,
    required this.name,
    required this.description,
    required this.features,
    required this.techStack,
    required this.githubUrl,
    required this.architectureNote,
    required this.darkAccentColor,
    required this.lightAccentColor,
    this.isFeatured = false,
  });

  Color getAccentColor(bool isDark) =>
      isDark ? darkAccentColor : lightAccentColor;
}

// ── Skill Group Model ──
class SkillGroup {
  final String icon;
  final String title;
  final List<String> skills;

  const SkillGroup({
    required this.icon,
    required this.title,
    required this.skills,
  });
}

// ── Blog Post Model ──
class BlogPost {
  final String category;
  final String title;
  final String excerpt;
  final String url;
  final String readTime;

  const BlogPost({
    required this.category,
    required this.title,
    required this.excerpt,
    required this.url,
    this.readTime = '4 min read',
  });
}

// ── Highlight Item Model ──
class HighlightItem {
  final String icon;
  final String title;
  final String description;

  const HighlightItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}

// ── Complete Portfolio Data ──
class PortfolioData {
  static const String name = 'Ansila Sherin Np';
  static const String shortName = 'Ansila';
  static const String role = 'Flutter Developer';
  static const String title =
      'Flutter Developer · Clean Architecture · REST API';
  static const String tagline =
      'I build scalable, production-ready mobile applications using Flutter and Clean Architecture principles — focused on writing clean, maintainable, and testable code.';
  static const String email = 'ansilasherin@gmail.com';
  static const String githubUrl = 'https://github.com/ansilasherin';
  static const String linkedinUrl = 'https://linkedin.com/in/ansilasherin';
  static const String resumeUrl = 'https://drive.google.com';

  // ── Hero Highlights ──
  static const List<HighlightItem> highlights = [
    HighlightItem(
      icon: '🏛',
      title: 'MVVM Architecture',
      description:
          'Consistent separation of Model, ViewModel, and View layers across all projects for maintainable and testable codebases.',
    ),
    HighlightItem(
      icon: '🔗',
      title: 'REST API Integration',
      description:
          'Token-based authentication, JSON parsing, error handling, and persistent session management using SharedPreferences.',
    ),
    HighlightItem(
      icon: '⚡',
      title: 'State Management',
      description:
          'Provider-based reactive state with clean ViewModel-driven UI updates. Efficient rebuilds, no unnecessary re-renders.',
    ),
    HighlightItem(
      icon: '🔥',
      title: 'Firebase & Local Storage',
      description:
          'Firebase Auth, Firestore integration alongside Hive and SharedPreferences for offline-first capabilities.',
    ),
  ];

  // ── Skills & Projects Data ──
  static const List<SkillGroup> skillGroups = [
    SkillGroup(
      icon: '📱',
      title: 'Mobile App Development',
      skills: [
        'Flutter',
        'Dart',
        'MVVM Architecture',
        'Provider',
        'Widget Lifecycle',
        'Custom UI Components',
        'Responsive UI',
      ],
    ),
    SkillGroup(
      icon: '🌐',
      title: 'Backend & APIs',
      skills: [
        'REST APIs',
        'JSON Parsing',
        'Token Authentication',
        'HTTP Package',
        'Firebase Firestore',
        'Error Handling',
      ],
    ),
    SkillGroup(
      icon: '🔧',
      title: 'Tools & Storage',
      skills: [
        'Git & GitHub',
        'Postman',
        'Firebase',
        'Hive',
        'SharedPreferences',
        'SQLite',
        'VS Code',
      ],
    ),
  ];

  static const List<Project> projects = [
    Project(
      number: 'Project 01 · Featured',
      name: 'Water Pipeline\nManagement System',
      description:
          'A digital complaint management system for municipalities, enabling residents to report water pipeline issues and track resolution status through a structured lifecycle — from registration through to resolution.',
      features: [
        'Complaint posting with image upload and location tagging',
        'Status lifecycle: Registered → In Progress → Resolved',
        'Service provider directory with connection request system',
        'Admin monitoring panel with complaint analytics',
        'Token-based auth with persistent session via SharedPreferences',
      ],
      techStack: [
        'Flutter',
        'MVVM',
        'Provider',
        'REST API',
        'SharedPreferences',
        'Image Picker'
      ],
      githubUrl: 'https://github.com/ansilasherin',
      architectureNote:
          '"Implemented token-based auth with REST API and persistent session handling. ViewModels hold all business logic; the UI layer is purely presentational."',
      darkAccentColor: Color(0xFF00D4B1),
      lightAccentColor: Color(0xFF00A88F),
      isFeatured: true,
    ),
    Project(
      number: 'Project 02',
      name: 'Restaurant\nReservation App',
      description:
          'A table booking and reservation management system that allows customers to browse available tables, select time slots, and manage reservations — with a clean, fast UI and reliable state management.',
      features: [
        'Table browsing with real-time availability status',
        'Reservation creation with date and time slot selection',
        'Booking history and active reservation management',
        'Provider-driven state with ViewModel separation',
      ],
      techStack: ['Flutter', 'MVVM', 'Provider', 'REST API', 'Firebase'],
      githubUrl: 'https://github.com/ansilasherin',
      architectureNote:
          '"State is managed through a ReservationViewModel extending ChangeNotifier. The repository layer abstracts all API calls, keeping ViewModels clean."',
      darkAccentColor: Color(0xFF6C63FF),
      lightAccentColor: Color(0xFF5A52E0),
    ),
    Project(
      number: 'Project 03',
      name: 'E-Commerce\nCart System',
      description:
          'A full product browsing and cart management application with real-time total calculation, quantity management, and a clean checkout flow — driven by reactive Provider state management.',
      features: [
        'Product listing with category filtering and search',
        'Add to cart, quantity adjustment, and item removal',
        'Real-time total calculation with discount logic',
        'Provider-based cart state shared across the widget tree',
      ],
      techStack: ['Flutter', 'Provider', 'MVVM', 'Hive', 'REST API'],
      githubUrl: 'https://github.com/ansilasherin',
      architectureNote:
          '"CartViewModel exposes reactive streams. Product, Cart, and Order are clean model classes with no UI dependencies. Hive provides local cart persistence."',
      darkAccentColor: Color(0xFFF6C90E),
      lightAccentColor: Color(0xFFD97706),
    ),
  ];

  static const List<BlogPost> blogPosts = [
    BlogPost(
      category: 'Architecture',
      title: 'How to Implement MVVM Architecture in Flutter from Scratch',
      excerpt:
          'A practical, step-by-step guide to structuring Flutter apps with proper Model-ViewModel separation using ChangeNotifier and Provider.',
      url: 'https://medium.com',
      readTime: '5 min read',
    ),
    BlogPost(
      category: 'State Management',
      title: 'Provider vs setState: When to Use Which and Why It Matters',
      excerpt:
          'A clear breakdown of both approaches, their performance implications, and the exact scenarios where each one belongs in a production app.',
      url: 'https://medium.com',
      readTime: '4 min read',
    ),
    BlogPost(
      category: 'API Integration',
      title: 'Token-Based API Auth in Flutter with Session Persistence',
      excerpt:
          'How to implement secure token storage using SharedPreferences, handle token expiry gracefully, and structure your API service layer cleanly.',
      url: 'https://medium.com',
      readTime: '6 min read',
    ),
  ];
}
