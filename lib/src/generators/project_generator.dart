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

    Logger.step('Creating project directory...');
    await projectDir.create(recursive: true);

    Logger.step('Generating project structure...');
    final template = TemplateFactory.getTemplate(config.template);
    await template.generate(config);

    Logger.step('Creating configuration files...');
    await _createConfigFiles(config);

    Logger.step('Setting up assets directory...');
    await _createAssetsStructure(config);

    Logger.success('Project structure created successfully!');
  }

  Future<void> _createConfigFiles(ProjectConfig config) async {
    final projectDir = config.projectPath;

    // Create pubspec.yaml
    final pubspecContent = _generatePubspecContent(config);
    await File(path.join(projectDir, 'pubspec.yaml'))
        .writeAsString(pubspecContent);

    // Create analysis_options.yaml
    final analysisOptionsContent = _generateAnalysisOptionsContent();
    await File(path.join(projectDir, 'analysis_options.yaml'))
        .writeAsString(analysisOptionsContent);

    // Create .gitignore
    final gitignoreContent = _generateGitignoreContent();
    await File(path.join(projectDir, '.gitignore'))
        .writeAsString(gitignoreContent);

    // Create README.md
    final readmeContent = _generateReadmeContent(config);
    await File(path.join(projectDir, 'README.md')).writeAsString(readmeContent);
  }

  Future<void> _createAssetsStructure(ProjectConfig config) async {
    final assetsDir = path.join(config.projectPath, 'assets');

    // Create asset directories
    await Directory(path.join(assetsDir, 'images')).create(recursive: true);
    await Directory(path.join(assetsDir, 'icons')).create(recursive: true);
    await Directory(path.join(assetsDir, 'fonts')).create(recursive: true);

    // Create placeholder files to keep directories in git
    await File(path.join(assetsDir, 'images', '.gitkeep')).writeAsString('');
    await File(path.join(assetsDir, 'icons', '.gitkeep')).writeAsString('');
    await File(path.join(assetsDir, 'fonts', '.gitkeep')).writeAsString('');
  }

  String _generatePubspecContent(ProjectConfig config) {
    return '''
name: ${config.name}
description: A new Flutter project created with fli.
publish_to: 'none'

version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.6

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0

flutter:
  uses-material-design: true
  
  assets:
    - assets/images/
    - assets/icons/
    
  # fonts:
  #   - family: CustomFont
  #     fonts:
  #       - asset: assets/fonts/CustomFont-Regular.ttf
  #       - asset: assets/fonts/CustomFont-Bold.ttf
  #         weight: 700
''';
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

  String _generateGitignoreContent() {
    return '''
# Miscellaneous
*.class
*.log
*.pyc
*.swp
.DS_Store
.atom/
.buildlog/
.history
.svn/
migrate_working_dir/

# IntelliJ related
*.iml
*.ipr
*.iws
.idea/

# The .vscode folder contains launch configuration and tasks you configure in
# VS Code which you may wish to be included in version control, so this line
# is commented out by default.
#.vscode/

# Flutter/Dart/Pub related
**/doc/api/
**/ios/Flutter/.last_build_id
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
.packages
.pub-cache/
.pub/
/build/

# Symbolication related
app.*.symbols

# Obfuscation related
app.*.map.json

# Android Studio will place build artifacts here
/android/app/debug
/android/app/profile
/android/app/release
''';
  }

  String _generateReadmeContent(ProjectConfig config) {
    return '''
# ${config.name}

A new Flutter project created with fli.

## Getting Started

This project uses the **${config.template}** template structure for clean and maintainable code.

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)

### Installation

1. Clone this repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the app

### Project Structure

This project follows the ${config.template} architecture pattern for better organization and scalability.

### Features

- Clean architecture
- Proper folder structure
- Linting rules configured
- Ready for development

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License.
''';
  }
}
