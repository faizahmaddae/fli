## Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-08-01

### Added
- Initial release of fli CLI tool
- Basic project template
- Feature-driven project template  
- Clean architecture template (basic implementation)
- BLoC pattern template (basic implementation)
- Provider pattern template (basic implementation)
- Interactive CLI with command-line arguments
- Project name validation
- Comprehensive folder structure generation
- Pre-configured pubspec.yaml, analysis_options.yaml, and .gitignore
- Asset directory structure
- Basic test setup

### Features
- `fli create <project_name>` command
- `fli templates` command to list available templates
- `--template` option to specify project template
- `--interactive` flag for interactive mode
- `--output` option to specify output directory
- Clean, organized project structures
- Flutter best practices built-in
- Extensible template system

### Templates
- **basic**: Simple, clean structure for small to medium apps
- **feature_driven**: Feature-based organization for scalable apps
- **clean_architecture**: Clean Architecture with proper separation
- **bloc_pattern**: BLoC pattern implementation
- **provider_pattern**: Provider state management structure
