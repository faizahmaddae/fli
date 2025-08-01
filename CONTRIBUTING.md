# Contributing to fli

Thank you for your interest in contributing to `fli`! This document provides guidelines and instructions for contributing to the project.

## Development Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/fli.git
   cd fli
   ```

2. **Install dependencies**
   ```bash
   dart pub get
   ```

3. **Run tests**
   ```bash
   dart test
   ```

4. **Test the CLI locally**
   ```bash
   dart run bin/fli.dart --help
   dart run bin/fli.dart create test_project --template=basic
   ```

## Project Structure

```
fli/
├── bin/
│   └── fli.dart              # CLI entry point
├── lib/
│   ├── fli.dart              # Main library export
│   └── src/
│       ├── cli/
│       │   └── fli_runner.dart    # CLI argument parsing and routing
│       ├── commands/
│       │   ├── create_command.dart    # Create project command
│       │   └── templates_command.dart # List templates command
│       ├── generators/
│       │   └── project_generator.dart # Core project generation logic
│       ├── models/
│       │   └── project_config.dart    # Project configuration model
│       ├── templates/
│       │   ├── project_template.dart       # Abstract template base class
│       │   ├── template_factory.dart       # Template factory
│       │   ├── basic_template.dart         # Basic project template
│       │   ├── feature_driven_template.dart # Feature-driven template
│       │   └── ...                        # Other templates
│       └── utils/
│           └── logger.dart               # Logging utilities
├── test/
│   ├── models/
│   └── templates/
├── pubspec.yaml
├── README.md
├── CHANGELOG.md
└── LICENSE
```

## Adding New Templates

To add a new project template:

1. **Create a new template class** in `lib/src/templates/`
   ```dart
   import 'project_template.dart';
   import '../models/project_config.dart';

   class MyNewTemplate extends ProjectTemplate {
     @override
     String get name => 'my_new_template';
     
     @override
     String get description => 'Description of my new template';
     
     @override
     Future<void> generate(ProjectConfig config) async {
       // Implementation
     }
   }
   ```

2. **Register the template** in `template_factory.dart`
   ```dart
   // Add to imports
   import 'my_new_template.dart';

   // Add to the factory method
   case 'my_new_template':
     return MyNewTemplate();

   // Add to available templates list
   static List<String> get availableTemplates => [
     // ... existing templates
     'my_new_template',
   ];
   ```

3. **Update CLI argument validation** in `fli_runner.dart`
   ```dart
   allowed: ['basic', 'feature_driven', ..., 'my_new_template'],
   ```

4. **Add tests** for your new template

5. **Update documentation** (README.md, templates command output)

## Code Style

- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use `dart format` to format code
- Use meaningful variable and function names
- Add documentation comments for public APIs

## Testing

- Write tests for new functionality
- Ensure all tests pass: `dart test`
- Test CLI commands manually
- Test generated projects can be built with Flutter

## Pull Request Process

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/my-new-feature`
3. Make your changes
4. Add/update tests
5. Update documentation
6. Run tests and ensure they pass
7. Commit your changes with descriptive messages
8. Push to your fork: `git push origin feature/my-new-feature`
9. Create a Pull Request

## Release Process

1. Update version in `pubspec.yaml`
2. Update `CHANGELOG.md`
3. Create a git tag: `git tag v1.x.x`
4. Push tag: `git push origin v1.x.x`
5. Publish to pub.dev: `dart pub publish`

## Ideas for Contributions

- **New Templates**: Clean Architecture, Riverpod, GetX, etc.
- **Enhanced CLI**: Interactive template selection, project configuration options
- **Code Generation**: Generate specific features, screens, or widgets
- **Documentation**: Better examples, video tutorials
- **Testing**: More comprehensive test coverage
- **Performance**: Faster project generation
- **Customization**: Allow users to create custom templates

## Questions?

Feel free to open an issue for any questions or suggestions!
