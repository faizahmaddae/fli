/// A powerful CLI tool for generating clean and standardized Flutter project structures.
/// 
/// The **fli** (Flutter Layer Infrastructure) package provides a command-line interface
/// for creating well-organized Flutter projects with various architectural patterns.
/// 
/// ## Features
/// 
/// - **Multiple Templates**: Choose from basic, feature-driven, clean architecture, 
///   BLoC pattern, and provider pattern templates
/// - **Standardized Structure**: Consistent, scalable project organization
/// - **Best Practices**: Built-in Flutter and Dart best practices
/// - **Developer Friendly**: Simple commands with intuitive options
/// - **Extensible**: Easy to customize and extend with new templates
/// 
/// ## Usage
/// 
/// ```bash
/// # Install globally
/// dart pub global activate fli
/// 
/// # Create a new project
/// fli create my_app --template=basic
/// 
/// # List available templates
/// fli templates
/// 
/// # Get help
/// fli --help
/// ```
/// 
/// ## Available Templates
/// 
/// - **basic**: Simple, clean structure for small to medium apps
/// - **feature_driven**: Feature-based organization for scalable apps
/// - **clean_architecture**: Clean Architecture with proper separation
/// - **bloc_pattern**: BLoC pattern implementation for state management
/// - **provider_pattern**: Provider state management structure
/// 
/// ## Examples
/// 
/// ```bash
/// # Create with specific template
/// fli create my_app --template=feature_driven
/// 
/// # Interactive mode
/// fli create my_app --interactive
/// 
/// # Custom output directory
/// fli create my_app --output=/path/to/projects
/// ```
library fli;

export 'src/cli/fli_runner.dart' show runFli;
