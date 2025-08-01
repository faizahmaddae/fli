import 'package:args/args.dart';
import '../utils/logger.dart';

class TemplatesCommand {
  Future<void> run(ArgResults results) async {
    Logger.info('Available Flutter project templates:');
    Logger.info('');

    final templates = [
      {
        'name': 'basic',
        'description': 'Simple, clean structure for small to medium apps',
        'features': [
          'Clean folder structure',
          'Basic routing setup',
          'Theme configuration'
        ]
      },
      {
        'name': 'feature_driven',
        'description': 'Feature-based organization for scalable apps',
        'features': ['Feature modules', 'Shared components', 'Clean separation']
      },
      {
        'name': 'clean_architecture',
        'description': 'Clean Architecture with proper separation of concerns',
        'features': [
          'Domain layer',
          'Data layer',
          'Presentation layer',
          'Dependency injection'
        ]
      },
      {
        'name': 'bloc_pattern',
        'description': 'BLoC pattern implementation for state management',
        'features': [
          'BLoC setup',
          'Event/State structure',
          'Repository pattern'
        ]
      },
      {
        'name': 'provider_pattern',
        'description': 'Provider state management structure',
        'features': [
          'Provider setup',
          'ChangeNotifier models',
          'Consumer widgets'
        ]
      },
    ];

    for (final template in templates) {
      Logger.info('📦 ${template['name']}');
      Logger.info('   ${template['description']}');
      final features = template['features'] as List<String>;
      for (final feature in features) {
        Logger.info('   • $feature');
      }
      Logger.info('');
    }

    Logger.info('Usage: fli create my_app --template=<template_name>');
    Logger.info('Example: fli create my_app --template=clean_architecture');
  }
}
