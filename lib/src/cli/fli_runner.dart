import 'dart:io';
import 'package:args/args.dart';
import '../commands/create_command.dart';
import '../commands/templates_command.dart';
import '../utils/logger.dart';

void runFli(List<String> arguments) async {
  final parser = ArgParser();

  // Global options
  parser.addFlag(
    'help',
    abbr: 'h',
    help: 'Show help information',
    negatable: false,
  );

  parser.addFlag(
    'version',
    abbr: 'v',
    help: 'Show version information',
    negatable: false,
  );

  // Commands
  parser.addCommand('create', _createCreateCommand());
  parser.addCommand('templates', _createTemplatesCommand());

  try {
    final results = parser.parse(arguments);

    if (results['help'] as bool) {
      _showHelp(parser);
      return;
    }

    if (results['version'] as bool) {
      _showVersion();
      return;
    }

    if (results.command == null) {
      Logger.error('No command specified. Use --help for available commands.');
      exit(1);
    }

    switch (results.command!.name) {
      case 'create':
        await CreateCommand().run(results.command!);
        break;
      case 'templates':
        await TemplatesCommand().run(results.command!);
        break;
      default:
        Logger.error('Unknown command: ${results.command!.name}');
        exit(1);
    }
  } catch (e) {
    Logger.error('Error: $e');
    exit(1);
  }
}

ArgParser _createCreateCommand() {
  final parser = ArgParser();

  parser.addOption(
    'template',
    abbr: 't',
    help: 'Template to use for the project',
    defaultsTo: 'basic',
    allowed: [
      'basic',
      'feature_driven',
      'clean_architecture',
      'bloc_pattern',
      'provider_pattern'
    ],
  );

  parser.addFlag(
    'interactive',
    abbr: 'i',
    help: 'Run in interactive mode',
    negatable: false,
  );

  parser.addOption(
    'output',
    abbr: 'o',
    help: 'Output directory (defaults to current directory)',
  );

  return parser;
}

ArgParser _createTemplatesCommand() {
  return ArgParser();
}

void _showHelp(ArgParser parser) {
  print('''
fli - Flutter project structure generator

Usage: fli <command> [arguments]

Global options:
${parser.usage}

Available commands:
  create      Create a new Flutter project with clean structure
  templates   List available project templates

Run "fli <command> --help" for more information about a command.
''');
}

void _showVersion() {
  print('fli version 1.0.0');
}
