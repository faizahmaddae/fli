## Changelog

All notable changes to this- Comprehensive documentation in `doc/` directoryproject will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2025-08-05

### 🚀 Major Features Added
- **Automatic Flutter Project Creation**: No more need to run `flutter create .` manually!
  - fli now automatically runs `flutter create` as part of the project generation
  - Template structure is applied on top of a proper Flutter project
  - Dependencies are automatically installed with `flutter pub get`
- **Enhanced Project Generation**:
  - Proper package imports throughout generated code
  - Clean integration with Flutter's standard project structure
  - Automatic cleanup of default Flutter boilerplate files
  - Template-specific tests that actually work

### ✨ Improvements
- **Better User Experience**: One command now creates a complete, ready-to-use Flutter project
- **Proper Package Structure**: All generated files use correct package imports
- **Enhanced README**: Generated projects include comprehensive documentation
- **Template-Specific Dependencies**: Each template gets appropriate dependencies automatically
- **Improved Error Handling**: Better feedback during project creation process

### 🧪 Quality Improvements  
- Generated projects pass `flutter analyze` with minimal warnings
- All template tests run successfully
- Projects can be built immediately without additional setup
- Comprehensive documentation for each template type

### 🛠️ Developer Experience
- **No Manual Steps Required**: Generated projects are immediately runnable
- **Better CLI Feedback**: Clear progress indicators and success messages
- **Template Features Summary**: Users see what features are included with their chosen template

## [1.0.1] - 2025-08-01

### Added
- Comprehensive documentation in `doc/` directory
  - **templates.md**: Detailed template guide with structure explanations and use cases
  - **architecture.md**: Design patterns, conventions, and architectural principles  
  - **examples.md**: Real-world usage scenarios and practical implementation examples
  - **README.md**: Documentation index and navigation guide
- Updated main README.md with links to comprehensive documentation

### Fixed
- Updated version number after successful initial publication to pub.dev

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
