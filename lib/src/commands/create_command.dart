import 'dart:io';
import 'package:args/args.dart';
import '../generators/project_generator.dart';
import '../models/project_config.dart';
import '../utils/logger.dart';

class CreateCommand {
  Future<void> run(ArgResults results) async {
    final arguments = results.arguments;

    if (arguments.isEmpty) {
      Logger.error(
          'Project name is required. Usage: fli create <project_name>');
      exit(1);
    }

    final projectName = arguments.first;
    final templateType = results['template'] as String;
    final isInteractive = results['interactive'] as bool;
    final outputDir = results['output'] as String?;

    // Validate project name
    if (!_isValidProjectName(projectName)) {
      Logger.error(
          'Invalid project name. Use lowercase letters, numbers, and underscores only.');
      exit(1);
    }

    // Create project config
    final config = ProjectConfig(
      name: projectName,
      template: templateType,
      outputDirectory: outputDir ?? Directory.current.path,
      isInteractive: isInteractive,
    );

    // Show what we're about to create
    Logger.info('Creating Flutter project: $projectName');
    Logger.info('Template: $templateType');
    Logger.info('Output directory: ${config.outputDirectory}');

    if (isInteractive) {
      final shouldContinue =
          _promptConfirmation('Proceed with project creation?');
      if (!shouldContinue) {
        Logger.info('Project creation cancelled.');
        return;
      }
    }

    // Generate the project
    final generator = ProjectGenerator();
    try {
      await generator.generate(config);
      Logger.success('🎉 Project "$projectName" created successfully!');
      Logger.info('');
      Logger.info('Your Flutter project is ready to use:');
      Logger.info('  cd $projectName');
      Logger.info('  flutter run');
      Logger.info('');
      Logger.info('✨ Features included:');
      Logger.info('  • Complete Flutter project structure');
      Logger.info('  • ${_getTemplateFeatures(templateType)}');
      Logger.info('  • Dependencies installed');
      Logger.info('  • Ready for development');
    } catch (e) {
      Logger.error('Failed to create project: $e');
      exit(1);
    }
  }

  String _getTemplateFeatures(String template) {
    switch (template) {
      case 'basic':
        return 'Clean architecture with core utilities';
      case 'feature_driven':
        return 'Feature-based modular architecture';
      case 'clean_architecture':
        return 'Enterprise-level clean architecture';
      case 'bloc_pattern':
        return 'BLoC pattern for state management';
      case 'provider_pattern':
        return 'Provider pattern for state management';
      default:
        return 'Template-specific architecture';
    }
  }

  bool _isValidProjectName(String name) {
    // Flutter project naming rules
    final regex = RegExp(r'^[a-z][a-z0-9_]*$');
    return regex.hasMatch(name) && !_isDartKeyword(name);
  }

  bool _isDartKeyword(String name) {
    const keywords = [
      'abstract',
      'as',
      'assert',
      'async',
      'await',
      'break',
      'case',
      'catch',
      'class',
      'const',
      'continue',
      'default',
      'deferred',
      'do',
      'dynamic',
      'else',
      'enum',
      'export',
      'extends',
      'external',
      'factory',
      'false',
      'final',
      'finally',
      'for',
      'function',
      'get',
      'hide',
      'if',
      'implements',
      'import',
      'in',
      'interface',
      'is',
      'library',
      'mixin',
      'new',
      'null',
      'of',
      'on',
      'operator',
      'part',
      'rethrow',
      'return',
      'set',
      'show',
      'static',
      'super',
      'switch',
      'sync',
      'this',
      'throw',
      'true',
      'try',
      'typedef',
      'var',
      'void',
      'while',
      'with',
      'yield'
    ];
    return keywords.contains(name);
  }

  bool _promptConfirmation(String message) {
    stdout.write('$message (y/N): ');
    final input = stdin.readLineSync()?.toLowerCase().trim() ?? '';
    return input == 'y' || input == 'yes';
  }
}
