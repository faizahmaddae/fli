import 'dart:io';
import 'package:path/path.dart' as path;
import '../models/project_config.dart';
import '../templates/template_factory.dart';
import '../utils/logger.dart';

class ProjectGenerator {
  Future<void> generate(ProjectConfig config) async {
    final projectDir = Directory(config.projectPath);

    // Check if directory already exists
    if (await projectDir.exists()) {
      throw Exception('Directory "${config.name}" already exists');
    }

    Logger.step('Creating Flutter project...');
    await _createFlutterProject(config);

    Logger.step('Cleaning up default Flutter files...');
    await _cleanupDefaultFlutterFiles(config);

    Logger.step('Applying template structure...');
    final template = TemplateFactory.getTemplate(config.template);
    await template.generate(config);

    Logger.step('Updating configuration files...');
    await _updateConfigFiles(config);

    Logger.step('Setting up enhanced assets structure...');
    await _enhanceAssetsStructure(config);

    Logger.step('Running flutter pub get...');
    await _runFlutterPubGet(config);

    Logger.success('Project created and ready to use!');
  }

  Future<void> _createFlutterProject(ProjectConfig config) async {
    final parentDir = Directory(config.outputDirectory);

    // Run flutter create command
    final result = await Process.run(
      'flutter',
      [
        'create',
        '--project-name=${config.name}',
        '--platforms=android,ios,web,windows,macos,linux',
        config.name,
      ],
      workingDirectory: parentDir.path,
    );

    if (result.exitCode != 0) {
      throw Exception('Failed to create Flutter project: ${result.stderr}');
    }

    Logger.info('✓ Flutter project initialized successfully');
  }

  Future<void> _cleanupDefaultFlutterFiles(ProjectConfig config) async {
    final projectDir = config.projectPath;

    // Remove default main.dart (will be replaced by template)
    final defaultMain = File(path.join(projectDir, 'lib', 'main.dart'));
    if (await defaultMain.exists()) {
      await defaultMain.delete();
    }

    // Remove default test file (will be replaced by template-specific tests)
    final defaultTest = File(path.join(projectDir, 'test', 'widget_test.dart'));
    if (await defaultTest.exists()) {
      await defaultTest.delete();
    }

    // Remove example README content from test directory
    final testDir = Directory(path.join(projectDir, 'test'));
    if (await testDir.exists()) {
      await for (final entity in testDir.list()) {
        if (entity is File && entity.path.endsWith('_test.dart')) {
          // Keep integration test folder if it exists, remove other default tests
          if (!entity.path.contains('integration_test')) {
            await entity.delete();
          }
        }
      }
    }

    Logger.info('✓ Default Flutter files cleaned up');
  }

  Future<void> _updateConfigFiles(ProjectConfig config) async {
    final projectDir = config.projectPath;

    // Update pubspec.yaml with template-specific dependencies
    await _updatePubspecFile(config);

    // Update analysis_options.yaml with enhanced linting
    final analysisOptionsContent = _generateAnalysisOptionsContent();
    await File(path.join(projectDir, 'analysis_options.yaml'))
        .writeAsString(analysisOptionsContent);

    // Update README.md with template-specific information
    final readmeContent = _generateReadmeContent(config);
    await File(path.join(projectDir, 'README.md')).writeAsString(readmeContent);
  }

  Future<void> _enhanceAssetsStructure(ProjectConfig config) async {
    final assetsDir = path.join(config.projectPath, 'assets');

    // Create enhanced asset directories
    await Directory(path.join(assetsDir, 'images')).create(recursive: true);
    await Directory(path.join(assetsDir, 'icons')).create(recursive: true);
    await Directory(path.join(assetsDir, 'fonts')).create(recursive: true);

    // Create placeholder files to keep directories in git
    await File(path.join(assetsDir, 'images', '.gitkeep')).writeAsString('');
    await File(path.join(assetsDir, 'icons', '.gitkeep')).writeAsString('');
    await File(path.join(assetsDir, 'fonts', '.gitkeep')).writeAsString('');
  }

  Future<void> _runFlutterPubGet(ProjectConfig config) async {
    final result = await Process.run(
      'flutter',
      ['pub', 'get'],
      workingDirectory: config.projectPath,
    );

    if (result.exitCode != 0) {
      Logger.warning(
          'flutter pub get completed with warnings: ${result.stderr}');
    } else {
      Logger.info('✓ Dependencies installed successfully');
    }
  }

  Future<void> _updatePubspecFile(ProjectConfig config) async {
    final pubspecPath = path.join(config.projectPath, 'pubspec.yaml');
    final existingContent = await File(pubspecPath).readAsString();

    // Parse existing pubspec and enhance it with template-specific dependencies
    final enhancedContent = _enhancePubspecContent(existingContent, config);
    await File(pubspecPath).writeAsString(enhancedContent);
  }

  String _enhancePubspecContent(String existingContent, ProjectConfig config) {
    // Parse the existing pubspec and add template-specific enhancements
    final lines = existingContent.split('\n');
    final enhancedLines = <String>[];
    bool inDependencies = false;
    bool inDevDependencies = false;
    bool inFlutter = false;
    bool hasAddedAssets = false;

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      if (line.startsWith('dependencies:')) {
        inDependencies = true;
        inDevDependencies = false;
        inFlutter = false;
        enhancedLines.add(line);
        continue;
      } else if (line.startsWith('dev_dependencies:')) {
        inDependencies = false;
        inDevDependencies = true;
        inFlutter = false;
        enhancedLines.add(line);
        continue;
      } else if (line.startsWith('flutter:')) {
        inDependencies = false;
        inDevDependencies = false;
        inFlutter = true;
        enhancedLines.add(line);
        continue;
      } else if (line.trim().isEmpty || !line.startsWith(' ')) {
        inDependencies = false;
        inDevDependencies = false;
        if (!line.startsWith('flutter:')) {
          inFlutter = false;
        }
      }

      // Add template-specific dependencies
      if (inDependencies && line.contains('cupertino_icons:')) {
        enhancedLines.add(line);
        // Add common dependencies based on template
        enhancedLines.addAll(_getTemplateDependencies(config.template));
      } else if (inDevDependencies && line.contains('flutter_lints:')) {
        enhancedLines.add('  flutter_lints: ^3.0.0');
        // Add common dev dependencies
        enhancedLines.add('  build_runner: ^2.4.7');
      } else if (inFlutter &&
          line.trim() == 'uses-material-design: true' &&
          !hasAddedAssets) {
        enhancedLines.add(line);
        enhancedLines.add('');
        enhancedLines.add('  assets:');
        enhancedLines.add('    - assets/images/');
        enhancedLines.add('    - assets/icons/');
        enhancedLines.add('');
        enhancedLines.add('  # fonts:');
        enhancedLines.add('  #   - family: CustomFont');
        enhancedLines.add('  #     fonts:');
        enhancedLines
            .add('  #       - asset: assets/fonts/CustomFont-Regular.ttf');
        enhancedLines
            .add('  #       - asset: assets/fonts/CustomFont-Bold.ttf');
        enhancedLines.add('  #         weight: 700');
        hasAddedAssets = true;
      } else {
        enhancedLines.add(line);
      }
    }

    return enhancedLines.join('\n');
  }

  List<String> _getTemplateDependencies(String template) {
    switch (template) {
      case 'bloc_pattern':
        return [
          '  flutter_bloc: ^8.1.3',
          '  equatable: ^2.0.5',
        ];
      case 'provider_pattern':
        return [
          '  provider: ^6.1.1',
        ];
      case 'clean_architecture':
        return [
          '  get_it: ^7.6.4',
          '  dartz: ^0.10.1',
        ];
      case 'feature_driven':
        return [
          '  go_router: ^12.1.3',
        ];
      default:
        return [
          '  http: ^1.1.0',
          '  shared_preferences: ^2.2.2',
        ];
    }
  }

  String _generateAnalysisOptionsContent() {
    return '''
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    prefer_single_quotes: true
    sort_constructors_first: true
    sort_unnamed_constructors_first: true
    always_use_package_imports: true
    avoid_print: true
    prefer_const_constructors: true
    prefer_const_literals_to_create_immutables: true
    sized_box_for_whitespace: true
    use_key_in_widget_constructors: true
''';
  }

  String _generateReadmeContent(ProjectConfig config) {
    final templateDescription = _getTemplateDescription(config.template);

    return '''
# ${config.name}

A Flutter project created with **fli** using the **${config.template}** template.

## 🏗️ Architecture

This project follows the **${config.template}** architecture pattern for clean, maintainable, and scalable code.

$templateDescription

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)

### Installation
1. Navigate to the project directory: `cd ${config.name}`
2. Install dependencies: `flutter pub get` 
3. Run the app: `flutter run`

### Available Commands
- `flutter run` - Run the app in debug mode
- `flutter build` - Build the app for release
- `flutter test` - Run all tests
- `flutter analyze` - Analyze code for issues

## 📁 Project Structure

This project is organized following the **${config.template}** pattern:

${_getProjectStructureDescription(config.template)}

## 🧪 Testing

Run tests with:
```bash
flutter test
```

## 🚀 Deployment

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 📚 Learn More

- [fli Documentation](https://github.com/faizahmaddae/fli#readme)
- [Flutter Documentation](https://flutter.dev/docs)
- [Template Architecture Guide](https://github.com/faizahmaddae/fli/blob/main/docs/templates.md#${config.template}-template)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Commit changes: `git commit -am 'Add feature'`
4. Push to branch: `git push origin feature-name`
5. Create a Pull Request

---

Created with ❤️ using [fli](https://pub.dev/packages/fli) v1.0.1
''';
  }

  String _getTemplateDescription(String template) {
    switch (template) {
      case 'basic':
        return '''
### Basic Template Features:
- ✅ Clean folder organization
- ✅ Theme management (light/dark mode)
- ✅ Constant management
- ✅ Basic service layer
- ✅ Widget organization
- ✅ Test structure

Perfect for small to medium applications with straightforward requirements.''';

      case 'feature_driven':
        return '''
### Feature Driven Template Features:
- ✅ Feature-based organization
- ✅ Scalable architecture
- ✅ Shared component system
- ✅ Service layer separation
- ✅ Clean navigation structure
- ✅ Modular testing approach

Ideal for medium to large applications with distinct feature sets.''';

      case 'clean_architecture':
        return '''
### Clean Architecture Template Features:
- ✅ Dependency inversion principle
- ✅ Repository pattern
- ✅ Use case pattern
- ✅ Entity-based domain modeling
- ✅ Error handling layer
- ✅ Comprehensive testing structure

Best for enterprise applications with complex business logic.''';

      case 'bloc_pattern':
        return '''
### BLoC Pattern Template Features:
- ✅ BLoC state management
- ✅ Event-driven architecture
- ✅ Repository pattern integration
- ✅ Stream-based data flow
- ✅ Comprehensive testing setup
- ✅ DevTools integration

Perfect for applications with complex state management needs.''';

      case 'provider_pattern':
        return '''
### Provider Pattern Template Features:
- ✅ Provider-based state management
- ✅ Consumer widget pattern
- ✅ ChangeNotifier implementation
- ✅ Dependency injection
- ✅ Multi-provider setup
- ✅ Testing utilities

Great for medium complexity applications with simpler state management.''';

      default:
        return 'A well-structured Flutter application with best practices built-in.';
    }
  }

  String _getProjectStructureDescription(String template) {
    switch (template) {
      case 'basic':
        return '''
```
lib/
├── core/                    # Shared infrastructure
│   ├── constants/          # App-wide constants
│   ├── theme/             # Theming and styling
│   └── utils/             # Helper functions
├── screens/               # Application screens
├── widgets/               # Reusable UI components
├── services/              # Business logic and API calls
└── main.dart              # Application entry point
```''';

      case 'feature_driven':
        return '''
```
lib/
├── core/                    # Shared infrastructure
├── features/                # Feature modules
│   └── [feature_name]/
│       ├── presentation/    # UI layer
│       ├── domain/         # Business logic
│       └── data/           # Data layer
├── shared/                  # Shared components
│   ├── widgets/            # Common UI components
│   └── services/           # Shared business logic
└── main.dart               # Application entry point
```''';

      default:
        return '''
```
lib/
├── [template_structure]/    # Template-specific organization
└── main.dart               # Application entry point
```

See the template documentation for detailed structure information.''';
    }
  }
}
