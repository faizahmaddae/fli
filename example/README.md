# Examples

This directory contains example projects generated with different `fli` templates to showcase the project structures.

## Basic Template Example

The basic template creates a simple, clean structure suitable for small to medium apps:

```bash
fli create my_basic_app --template=basic
```

**Generated Structure:**
```
my_basic_app/
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_colors.dart
│   │   │   └── app_strings.dart
│   │   ├── theme/
│   │   │   └── app_theme.dart
│   │   └── utils/
│   │       └── app_utils.dart
│   ├── screens/
│   │   └── home/
│   │       └── home_screen.dart
│   ├── widgets/
│   │   └── custom_button.dart
│   ├── services/
│   ├── app.dart
│   └── main.dart
├── test/
│   ├── widget_test/
│   └── unit_test/
├── assets/
│   ├── images/
│   ├── icons/
│   └── fonts/
├── doc/
├── pubspec.yaml
├── analysis_options.yaml
├── .gitignore
└── README.md
```

## Feature-Driven Template Example

The feature-driven template organizes code by features for better scalability:

```bash
fli create my_feature_app --template=feature_driven
```

**Generated Structure:**
```
my_feature_app/
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   ├── theme/
│   │   ├── utils/
│   │   └── services/
│   ├── features/
│   │   └── home/
│   │       └── presentation/
│   │           ├── pages/
│   │           │   └── home_page.dart
│   │           └── widgets/
│   │               └── home_content.dart
│   ├── shared/
│   │   ├── widgets/
│   │   │   └── custom_card.dart
│   │   └── services/
│   ├── app.dart
│   └── main.dart
├── test/
│   ├── features/
│   └── shared/
└── ...
```

## Running the Examples

To test any of the examples:

1. Navigate to the generated project directory
2. Install dependencies: `flutter pub get`
3. Run the app: `flutter run`

Each example includes:
- ✅ Proper folder structure
- ✅ Theme configuration
- ✅ Basic routing setup  
- ✅ Reusable widgets
- ✅ Test structure
- ✅ Documentation
- ✅ Linting rules
- ✅ Git configuration

## Customizing Generated Projects

After generating a project with `fli`, you can:

1. **Add dependencies** to `pubspec.yaml`
2. **Configure themes** in `lib/core/theme/`
3. **Add new screens** following the established pattern
4. **Implement state management** (Provider, BLoC, Riverpod, etc.)
5. **Add API services** in the `services/` directory
6. **Write tests** in the `test/` directory

## Next Steps

- Explore the generated code structure
- Read the generated README.md for project-specific information
- Check out the Contributing Guide for adding new templates
- Share your feedback and suggestions!
