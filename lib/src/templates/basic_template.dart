import 'dart:io';
import 'package:path/path.dart' as path;
import 'project_template.dart';
import '../models/project_config.dart';

class BasicTemplate extends ProjectTemplate {
  @override
  String get name => 'basic';

  @override
  String get description => 'Simple, clean structure for small to medium apps';

  @override
  Future<void> generate(ProjectConfig config) async {
    final projectDir = config.projectPath;

    // Create main directory structure
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
      'lib/screens',
      'lib/widgets',
      'lib/services',
      'test',
      'test/widget_test',
      'test/unit_test',
      'docs',
    ];

    for (final dir in directories) {
      await Directory(path.join(projectDir, dir)).create(recursive: true);
    }
  }

  Future<void> _createSourceFiles(String projectDir, String projectName) async {
    // Create main.dart
    await _createMainFile(projectDir, projectName);

    // Create app.dart
    await _createAppFile(projectDir, projectName);

    // Create core files
    await _createCoreFiles(projectDir);

    // Create screen files
    await _createScreenFiles(projectDir);

    // Create widget files
    await _createWidgetFiles(projectDir);

    // Create test files
    await _createTestFiles(projectDir, projectName);
  }

  Future<void> _createMainFile(String projectDir, String projectName) async {
    final content = '''
import 'package:flutter/material.dart';
import 'package:${_snakeCase(projectName)}/app.dart';

void main() {
  runApp(const MyApp());
}
''';
    await File(path.join(projectDir, 'lib', 'main.dart'))
        .writeAsString(content);
  }

  Future<void> _createAppFile(String projectDir, String projectName) async {
    final className = _pascalCase(projectName);
    final packageName = _snakeCase(projectName);
    final content = '''
import 'package:flutter/material.dart';
import 'package:$packageName/core/theme/app_theme.dart';
import 'package:$packageName/screens/home/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '$className',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
''';
    await File(path.join(projectDir, 'lib', 'app.dart')).writeAsString(content);
  }

  Future<void> _createCoreFiles(String projectDir) async {
    final projectName = path.basename(projectDir);
    final packageName = _snakeCase(projectName);

    // Create app theme
    final themeContent = '''
import 'package:flutter/material.dart';
import 'package:$packageName/core/constants/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
  
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.darkBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}
''';
    await File(path.join(projectDir, 'lib', 'core', 'theme', 'app_theme.dart'))
        .writeAsString(themeContent);

    // Create app colors
    final colorsContent = '''
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2196F3);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color background = Color(0xFFF5F5F5);
  static const Color darkBackground = Color(0xFF121212);
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFB00020);
  static const Color onPrimary = Colors.white;
  static const Color onSecondary = Colors.black;
  static const Color onBackground = Colors.black87;
  static const Color onSurface = Colors.black87;
  static const Color onError = Colors.white;
}
''';
    await File(path.join(
            projectDir, 'lib', 'core', 'constants', 'app_colors.dart'))
        .writeAsString(colorsContent);

    // Create app strings
    final stringsContent = '''
class AppStrings {
  static const String appName = 'My App';
  static const String welcome = 'Welcome!';
  static const String getStarted = 'Get Started';
  static const String home = 'Home';
  static const String settings = 'Settings';
  static const String about = 'About';
}
''';
    await File(path.join(
            projectDir, 'lib', 'core', 'constants', 'app_strings.dart'))
        .writeAsString(stringsContent);

    // Create app utils
    final utilsContent = '''
import 'package:flutter/material.dart';

class AppUtils {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
  
  static Future<bool> showConfirmDialog(
    BuildContext context, {
    required String title,
    required String content,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}
''';
    await File(path.join(projectDir, 'lib', 'core', 'utils', 'app_utils.dart'))
        .writeAsString(utilsContent);
  }

  Future<void> _createScreenFiles(String projectDir) async {
    final projectName = path.basename(projectDir);
    final packageName = _snakeCase(projectName);

    // Create home screen directory
    await Directory(path.join(projectDir, 'lib', 'screens', 'home'))
        .create(recursive: true);

    // Create home screen
    final homeScreenContent = '''
import 'package:flutter/material.dart';
import 'package:$packageName/core/constants/app_strings.dart';
import 'package:$packageName/widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.home),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.welcome,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            CustomButton(
              text: AppStrings.getStarted,
              onPressed: _onGetStartedPressed,
            ),
          ],
        ),
      ),
    );
  }
  
  static void _onGetStartedPressed() {
    // TODO: Implement get started functionality
    // Using print for debugging - remove in production
    // ignore: avoid_print
    print('Get Started pressed!');
  }
}
''';
    await File(
            path.join(projectDir, 'lib', 'screens', 'home', 'home_screen.dart'))
        .writeAsString(homeScreenContent);
  }

  Future<void> _createWidgetFiles(String projectDir) async {
    // Create custom button widget
    final customButtonContent = '''
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
''';
    await File(path.join(projectDir, 'lib', 'widgets', 'custom_button.dart'))
        .writeAsString(customButtonContent);
  }

  Future<void> _createTestFiles(String projectDir, String projectName) async {
    // Create widget test
    final widgetTestContent = '''
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:$projectName/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the welcome text is displayed
    expect(find.text('Welcome!'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });
}
''';
    await File(path.join(projectDir, 'test', 'widget_test', 'app_test.dart'))
        .writeAsString(widgetTestContent);

    // Create unit test example
    final unitTestContent = '''
import 'package:flutter_test/flutter_test.dart';
import 'package:$projectName/core/utils/app_utils.dart';

void main() {
  group('AppUtils', () {
    test('should provide utility functions', () {
      // Example unit test
      expect(AppUtils, isNotNull);
    });
  });
}
''';
    await File(path.join(projectDir, 'test', 'unit_test', 'utils_test.dart'))
        .writeAsString(unitTestContent);
  }

  String _pascalCase(String input) {
    return input
        .split('_')
        .map((word) =>
            word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1))
        .join('');
  }

  String _snakeCase(String input) {
    return input.toLowerCase();
  }
}
