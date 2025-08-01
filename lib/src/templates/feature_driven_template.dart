import 'dart:io';
import 'package:path/path.dart' as path;
import 'project_template.dart';
import '../models/project_config.dart';

class FeatureDrivenTemplate extends ProjectTemplate {
  @override
  String get name => 'feature_driven';

  @override
  String get description => 'Feature-based organization for scalable apps';

  @override
  Future<void> generate(ProjectConfig config) async {
    final projectDir = config.projectPath;

    // Create feature-driven directory structure
    await _createDirectoryStructure(projectDir);

    // Create source files
    await _createSourceFiles(projectDir, config.name);
  }

  Future<void> _createDirectoryStructure(String projectDir) async {
    final directories = [
      'lib',
      'lib/core',
      'lib/core/constants',
      'lib/core/theme',
      'lib/core/utils',
      'lib/core/services',
      'lib/features',
      'lib/features/home',
      'lib/features/home/presentation',
      'lib/features/home/presentation/pages',
      'lib/features/home/presentation/widgets',
      'lib/shared',
      'lib/shared/widgets',
      'lib/shared/services',
      'test',
      'test/features',
      'test/shared',
    ];

    for (final dir in directories) {
      await Directory(path.join(projectDir, dir)).create(recursive: true);
    }
  }

  Future<void> _createSourceFiles(String projectDir, String projectName) async {
    // Create main app structure
    await _createMainFile(projectDir, projectName);
    await _createAppFile(projectDir, projectName);

    // Create core files
    await _createCoreFiles(projectDir);

    // Create feature structure
    await _createFeatureFiles(projectDir);

    // Create shared components
    await _createSharedFiles(projectDir);
  }

  Future<void> _createMainFile(String projectDir, String projectName) async {
    final content = '''
import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  runApp(const MyApp());
}
''';
    await File(path.join(projectDir, 'lib', 'main.dart'))
        .writeAsString(content);
  }

  Future<void> _createAppFile(String projectDir, String projectName) async {
    final content = '''
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/home/presentation/pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feature Driven App',
      theme: AppTheme.lightTheme,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
''';
    await File(path.join(projectDir, 'lib', 'app.dart')).writeAsString(content);
  }

  Future<void> _createCoreFiles(String projectDir) async {
    // App theme
    final themeContent = '''
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.grey[50],
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}
''';
    await File(path.join(projectDir, 'lib', 'core', 'theme', 'app_theme.dart'))
        .writeAsString(themeContent);

    // App constants
    final constantsContent = '''
class AppConstants {
  static const String appName = 'Feature Driven App';
  static const String baseUrl = 'https://api.example.com';
}
''';
    await File(path.join(
            projectDir, 'lib', 'core', 'constants', 'app_constants.dart'))
        .writeAsString(constantsContent);
  }

  Future<void> _createFeatureFiles(String projectDir) async {
    // Home feature page
    final homePageContent = '''
import 'package:flutter/material.dart';
import '../widgets/home_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const HomeContent(),
    );
  }
}
''';
    await File(path.join(projectDir, 'lib', 'features', 'home', 'presentation',
            'pages', 'home_page.dart'))
        .writeAsString(homePageContent);

    // Home feature widget
    final homeContentContent = '''
import 'package:flutter/material.dart';
import '../../../../shared/widgets/custom_card.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomCard(
            title: 'Welcome to Feature Driven Architecture',
            subtitle: 'Each feature is self-contained and modular',
          ),
        ],
      ),
    );
  }
}
''';
    await File(path.join(projectDir, 'lib', 'features', 'home', 'presentation',
            'widgets', 'home_content.dart'))
        .writeAsString(homeContentContent);
  }

  Future<void> _createSharedFiles(String projectDir) async {
    // Shared custom card widget
    final customCardContent = '''
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const CustomCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
''';
    await File(path.join(
            projectDir, 'lib', 'shared', 'widgets', 'custom_card.dart'))
        .writeAsString(customCardContent);
  }
}
