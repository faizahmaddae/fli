# 📋 fli Templates Documentation

This document provides detailed information about all available templates in the fli CLI tool. Each template is designed for specific use cases and architectural patterns to help you create well-structured Flutter applications.

## 🎯 Template Overview

| Template | Use Case | Complexity | State Management | Architecture |
|----------|----------|------------|------------------|--------------|
| [Basic](#basic-template) | Small to medium apps | ⭐ | Built-in | Simple MVC |
| [Feature Driven](#feature-driven-template) | Scalable apps | ⭐⭐ | Flexible | Feature-based |
| [Clean Architecture](#clean-architecture-template) | Large applications | ⭐⭐⭐ | Any | Clean Architecture |
| [BLoC Pattern](#bloc-pattern-template) | Complex state | ⭐⭐⭐ | BLoC | Layered |
| [Provider Pattern](#provider-pattern-template) | Medium complexity | ⭐⭐ | Provider | MVVM |

---

## 📱 Basic Template

### Overview
The **Basic Template** provides a simple, clean structure perfect for small to medium-sized Flutter applications. It follows Flutter's standard conventions while adding organizational improvements.

### When to Use
- Small to medium applications
- Prototypes and MVPs  
- Learning projects
- Apps with straightforward functionality

### Project Structure
```
my_app/
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_colors.dart      # Color palette
│   │   │   ├── app_strings.dart     # String constants
│   │   │   └── app_assets.dart      # Asset paths
│   │   ├── theme/
│   │   │   ├── app_theme.dart       # Theme configuration
│   │   │   └── text_styles.dart     # Text styling
│   │   └── utils/
│   │       ├── helpers.dart         # Helper functions
│   │       └── validators.dart      # Input validation
│   ├── screens/
│   │   └── home/
│   │       ├── home_screen.dart     # Main home screen
│   │       └── widgets/             # Screen-specific widgets
│   ├── widgets/
│   │   ├── common/                  # Reusable widgets
│   │   └── custom/                  # Custom components
│   ├── services/
│   │   ├── api_service.dart         # API communication
│   │   └── storage_service.dart     # Local storage
│   ├── app.dart                     # App configuration
│   └── main.dart                    # Entry point
├── test/
│   ├── widget_test/                 # Widget tests
│   └── unit_test/                   # Unit tests
└── doc/
    └── README.md                    # Project documentation
```

### Generated Files

#### Core Files
- **`app_theme.dart`**: Material Design theme configuration with light/dark mode support
- **`app_colors.dart`**: Centralized color palette management
- **`app_strings.dart`**: String constants for internationalization ready structure
- **`helpers.dart`**: Common utility functions and extensions

#### Screen Structure
- **`home_screen.dart`**: Main landing screen with basic navigation setup
- **Screen-specific widgets**: Organized in dedicated widget folders

#### Services
- **`api_service.dart`**: HTTP client setup with error handling
- **`storage_service.dart`**: SharedPreferences wrapper for local data

### Key Features
- ✅ Clean folder organization
- ✅ Theme management (light/dark mode)
- ✅ Constant management
- ✅ Basic service layer
- ✅ Widget organization
- ✅ Test structure

### Usage
```bash
fli create my_app --template=basic
```

### Best For
- First-time Flutter developers
- Simple applications
- Rapid prototyping
- Educational projects

---

## 🏗️ Feature Driven Template

### Overview
The **Feature Driven Template** organizes code by features rather than file types. Each feature contains all its related files (UI, logic, models) in one place, making it easier to maintain and scale.

### When to Use
- Medium to large applications
- Team development
- Modular architecture needs
- Apps with distinct feature sets

### Project Structure
```
my_app/
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_constants.dart   # Global constants
│   │   │   └── api_constants.dart   # API endpoints
│   │   ├── theme/
│   │   │   ├── app_theme.dart       # Global theming
│   │   │   ├── app_colors.dart      # Color system
│   │   │   └── text_styles.dart     # Typography
│   │   ├── utils/
│   │   │   ├── extensions.dart      # Dart extensions
│   │   │   ├── helpers.dart         # Utility functions
│   │   │   └── validators.dart      # Form validation
│   │   └── services/
│   │       ├── navigation_service.dart  # Route management
│   │       ├── storage_service.dart     # Data persistence
│   │       └── network_service.dart     # HTTP client
│   ├── features/
│   │   └── home/
│   │       ├── presentation/
│   │       │   ├── pages/
│   │       │   │   └── home_page.dart   # Feature screen
│   │       │   └── widgets/
│   │       │       ├── home_app_bar.dart    # Feature widgets
│   │       │       └── home_content.dart
│   │       ├── domain/              # Business logic (planned)
│   │       └── data/                # Data layer (planned)
│   ├── shared/
│   │   ├── widgets/
│   │   │   ├── custom_button.dart   # Reusable components
│   │   │   ├── loading_widget.dart
│   │   │   └── error_widget.dart
│   │   └── services/
│   │       ├── api_service.dart     # Shared API logic
│   │       └── auth_service.dart    # Authentication
│   ├── app.dart                     # App configuration
│   └── main.dart                    # Entry point
├── test/
│   ├── features/                    # Feature-specific tests
│   └── shared/                      # Shared component tests
└── doc/
    ├── features/                    # Feature documentation
    └── architecture.md              # Architecture guide
```

### Key Concepts

#### Feature Organization
Each feature is self-contained with:
- **Presentation Layer**: Pages and widgets
- **Domain Layer**: Business logic (planned for expansion)
- **Data Layer**: Models and repositories (planned for expansion)

#### Shared Resources
- **Widgets**: Components used across multiple features
- **Services**: Business logic shared between features
- **Utils**: Helper functions and extensions

### Generated Files

#### Core Infrastructure
- **Navigation service**: Centralized route management
- **Network service**: HTTP client with interceptors
- **Storage service**: Local data persistence

#### Feature Structure
- **Home feature**: Complete example with page and widgets
- **Shared widgets**: Reusable UI components
- **Service layer**: Feature-agnostic business logic

### Key Features
- ✅ Feature-based organization
- ✅ Scalable architecture
- ✅ Shared component system
- ✅ Service layer separation
- ✅ Clean navigation structure
- ✅ Modular testing approach

### Usage
```bash
fli create my_app --template=feature_driven
```

### Best For
- Medium to large applications
- Team collaboration
- Modular development
- Scalable architecture needs

---

## 🏛️ Clean Architecture Template

### Overview
The **Clean Architecture Template** implements Uncle Bob's Clean Architecture principles with proper separation of concerns. Currently builds upon the basic template with plans for full Clean Architecture implementation.

### When to Use
- Large, complex applications
- Enterprise-level projects
- Long-term maintainability focus
- Team with Clean Architecture experience

### Current Implementation
```
my_app/
├── lib/
│   ├── core/                        # Shared core functionality
│   ├── features/                    # Feature modules
│   ├── presentation/                # UI layer
│   ├── domain/                      # Business logic (planned)
│   ├── data/                        # Data layer (planned)
│   └── main.dart
```

### Planned Architecture
```
my_app/
├── lib/
│   ├── core/
│   │   ├── errors/
│   │   │   ├── exceptions.dart      # Custom exceptions
│   │   │   └── failures.dart        # Error handling
│   │   ├── usecases/
│   │   │   └── usecase.dart         # Base use case
│   │   ├── utils/
│   │   └── network/
│   ├── features/
│   │   └── [feature_name]/
│   │       ├── data/
│   │       │   ├── datasources/     # Remote/Local data sources
│   │       │   ├── models/          # Data models
│   │       │   └── repositories/    # Repository implementations
│   │       ├── domain/
│   │       │   ├── entities/        # Business entities
│   │       │   ├── repositories/    # Repository interfaces
│   │       │   └── usecases/        # Business use cases
│   │       └── presentation/
│   │           ├── bloc/            # State management
│   │           ├── pages/           # UI screens
│   │           └── widgets/         # UI components
│   └── main.dart
```

### Clean Architecture Principles
1. **Dependency Inversion**: Dependencies point inward
2. **Separation of Concerns**: Each layer has specific responsibilities
3. **Testability**: Easy to unit test business logic
4. **Independence**: UI, database, and frameworks are details

### Key Features (Planned)
- ✅ Dependency injection
- ✅ Repository pattern
- ✅ Use case pattern
- ✅ Entity-based domain modeling
- ✅ Error handling layer
- ✅ Comprehensive testing structure

### Usage
```bash
fli create my_app --template=clean_architecture
```

### Current Status
> **Note**: This template currently uses the basic template structure. Full Clean Architecture implementation is planned for future releases.

### Best For
- Enterprise applications
- Complex business logic
- Long-term projects
- Experienced development teams

---

## 🎪 BLoC Pattern Template

### Overview
The **BLoC Pattern Template** implements Business Logic Components for predictable state management. Currently builds upon the basic template with plans for full BLoC implementation.

### When to Use
- Complex state management needs
- Predictable state flow requirements
- Testing-focused development
- Separation of UI and business logic

### Current Implementation
Based on basic template structure with BLoC integration planned.

### Planned Architecture
```
my_app/
├── lib/
│   ├── blocs/
│   │   ├── auth/
│   │   │   ├── auth_bloc.dart       # Authentication BLoC
│   │   │   ├── auth_event.dart      # Auth events
│   │   │   └── auth_state.dart      # Auth states
│   │   └── home/
│   │       ├── home_bloc.dart       # Home feature BLoC
│   │       ├── home_event.dart      # Home events
│   │       └── home_state.dart      # Home states
│   ├── models/
│   │   ├── user_model.dart          # Data models
│   │   └── response_model.dart
│   ├── repositories/
│   │   ├── auth_repository.dart     # Data repositories
│   │   └── user_repository.dart
│   ├── services/
│   │   ├── api_service.dart         # External services
│   │   └── storage_service.dart
│   ├── ui/
│   │   ├── screens/
│   │   │   ├── home_screen.dart     # UI screens
│   │   │   └── login_screen.dart
│   │   └── widgets/
│   │       ├── custom_button.dart   # Reusable widgets
│   │       └── loading_indicator.dart
│   └── main.dart
```

### BLoC Pattern Benefits
- **Predictable State**: All state changes are explicit
- **Separation of Concerns**: UI and business logic separated
- **Testability**: Easy to test business logic
- **Time Travel**: Debug state changes over time

### Key Features (Planned)
- ✅ BLoC state management
- ✅ Event-driven architecture
- ✅ Repository pattern integration
- ✅ Stream-based data flow
- ✅ Comprehensive testing setup
- ✅ DevTools integration

### Dependencies (Planned)
```yaml
dependencies:
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5
  bloc: ^8.1.2

dev_dependencies:
  bloc_test: ^9.1.4
  mocktail: ^0.3.0
```

### Usage
```bash
fli create my_app --template=bloc_pattern
```

### Current Status
> **Note**: This template currently uses the basic template structure. Full BLoC pattern implementation is planned for future releases.

### Best For
- Complex state management
- Large applications
- Team development
- Test-driven development

---

## 📦 Provider Pattern Template

### Overview
The **Provider Pattern Template** implements the Provider package for simpler state management compared to BLoC. Currently builds upon the basic template with plans for full Provider implementation.

### When to Use
- Medium complexity state management
- Simpler alternative to BLoC
- Reactive programming patterns
- Dependency injection needs

### Current Implementation
Based on basic template structure with Provider integration planned.

### Planned Architecture
```
my_app/
├── lib/
│   ├── providers/
│   │   ├── auth_provider.dart       # Authentication provider
│   │   ├── theme_provider.dart      # Theme state provider
│   │   └── user_provider.dart       # User data provider
│   ├── models/
│   │   ├── user_model.dart          # Data models
│   │   └── app_model.dart
│   ├── services/
│   │   ├── auth_service.dart        # Business services
│   │   ├── api_service.dart
│   │   └── storage_service.dart
│   ├── ui/
│   │   ├── screens/
│   │   │   ├── home_screen.dart     # UI screens
│   │   │   └── profile_screen.dart
│   │   └── widgets/
│   │       ├── consumer_widgets.dart    # Provider consumers
│   │       └── common_widgets.dart
│   ├── utils/
│   │   ├── constants.dart           # App constants
│   │   └── helpers.dart
│   └── main.dart
```

### Provider Pattern Benefits
- **Simplicity**: Easier to learn than BLoC
- **Performance**: Efficient rebuilds with Consumer
- **Flexibility**: Works with various state management approaches
- **Integration**: Seamless with existing Flutter widgets

### Key Features (Planned)
- ✅ Provider-based state management
- ✅ Consumer widget pattern
- ✅ ChangeNotifier implementation
- ✅ Dependency injection
- ✅ Multi-provider setup
- ✅ Testing utilities

### Dependencies (Planned)
```yaml
dependencies:
  provider: ^6.0.5
  shared_preferences: ^2.2.2

dev_dependencies:
  mockito: ^5.4.2
  build_runner: ^2.4.7
```

### Usage
```bash
fli create my_app --template=provider_pattern
```

### Current Status
> **Note**: This template currently uses the basic template structure. Full Provider pattern implementation is planned for future releases.

### Best For
- Medium complexity applications
- Simpler state management needs
- Rapid development
- Provider package familiarity

---

## 🚀 Getting Started

### Choose Your Template

1. **Starting out?** → Use **Basic Template**
2. **Building something bigger?** → Use **Feature Driven Template**  
3. **Enterprise app?** → Use **Clean Architecture Template**
4. **Complex state?** → Use **BLoC Pattern Template**
5. **Simple state management?** → Use **Provider Pattern Template**

### Command Examples

```bash
# Interactive template selection
fli create my_app --interactive

# Specific template
fli create my_app --template=feature_driven

# List all available templates
fli templates
```

### Next Steps

1. **Explore the generated structure**
2. **Read the feature documentation** in `doc/`
3. **Run the generated tests**: `flutter test`
4. **Start building your features**
5. **Follow the architectural patterns** established by the template

---

## 📝 Contributing

Found a bug or want to suggest improvements to the templates? 

1. Check existing [issues](https://github.com/faizahmaddae/fli/issues)
2. Create a new issue with template feedback
3. Submit a pull request with improvements

---

## 🔮 Roadmap

### Upcoming Template Features

- **Clean Architecture**: Full implementation with dependency injection
- **BLoC Pattern**: Complete BLoC setup with flutter_bloc
- **Provider Pattern**: Full Provider integration with dependency injection
- **Riverpod Template**: Modern state management with Riverpod
- **GetX Template**: GetX framework integration
- **Custom Templates**: User-defined template support

### Template Enhancements

- **Testing**: Comprehensive test setup for each template
- **CI/CD**: GitHub Actions workflow generation
- **Documentation**: Auto-generated feature documentation
- **Examples**: Sample implementations for each pattern

---

*Last updated: August 2025*
