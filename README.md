# fli

A powerful CLI tool for generating clean and standardized Flutter project structures.

## 🚀 Why fli?

Every Flutter developer has faced this problem: inconsistent project structures across different projects and teams. `fli` solves this by providing:

- **Standardized Structure**: Clean, organized folder structures that scale
- **Multiple Templates**: Choose from various architectural patterns
- **Best Practices**: Built-in Flutter and Dart best practices
- **Developer Friendly**: Simple commands, interactive prompts
- **Extensible**: Easy to customize and extend

## 📦 Installation

### Option 1: Install from pub.dev (Recommended)

```bash
dart pub global activate fli
```

### Option 2: Install from source

```bash
git clone https://github.com/faizahmaddae/fli.git
cd fli
dart pub global activate --source path .
```

### Option 3: Quick install script

```bash
curl -fsSL https://raw.githubusercontent.com/faizahmaddae/fli/main/install.sh | bash
```

**Note:** Make sure `~/.pub-cache/bin` is in your PATH to use `fli` directly.

## 🛠️ Usage

### Generate a new Flutter project (Complete & Ready to Use!)

```bash
fli create my_app
```

**That's it!** Your Flutter project is completely ready to use. No need to run `flutter create .` or `flutter pub get` manually.

### Interactive mode with template selection

```bash
fli create my_app --interactive
```

### Choose a specific template

```bash
fli create my_app --template=clean_architecture
```

### What you get out of the box:
- ✅ **Complete Flutter project** with all platform support
- ✅ **Template structure applied** with best practices
- ✅ **Dependencies installed** and ready to use  
- ✅ **Tests included** and passing
- ✅ **Documentation generated** with template-specific guides
- ✅ **Ready to run** with `flutter run`

### Available templates

- `basic` - Simple, clean structure for small to medium apps
- `feature_driven` - Feature-based organization
- `clean_architecture` - Clean Architecture with proper separation
- `bloc_pattern` - BLoC pattern implementation
- `provider_pattern` - Provider state management structure

## 🏗️ Generated Structure Example

```
my_app/
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   ├── errors/
│   │   ├── theme/
│   │   └── utils/
│   ├── features/
│   │   └── home/
│   │       ├── data/
│   │       ├── domain/
│   │       └── presentation/
│   ├── shared/
│   │   ├── widgets/
│   │   └── services/
│   └── main.dart
├── test/
├── assets/
│   ├── images/
│   ├── icons/
│   └── fonts/
└── docs/
```

## 🎯 Commands

- `fli create <project_name>` - Create a new Flutter project
- `fli templates` - List available templates
- `fli --help` - Show help information
- `fli --version` - Show version

## 📚 Documentation

For comprehensive documentation, examples, and architectural guides:

### 📋 [Complete Template Documentation](./docs/README.md)
- **[Template Guide](./docs/templates.md)** - Detailed overview of all templates with structure explanations
- **[Architecture Guide](./docs/architecture.md)** - Design patterns, conventions, and best practices
- **[Usage Examples](./docs/examples.md)** - Real-world scenarios and practical implementation examples

### 🚀 Quick Links
- **[Basic Template](./docs/templates.md#basic-template)** - Simple apps and prototypes
- **[Feature Driven](./docs/templates.md#feature-driven-template)** - Scalable feature-based architecture  
- **[Clean Architecture](./docs/templates.md#clean-architecture-template)** - Enterprise-level applications
- **[State Management](./docs/templates.md#bloc-pattern-template)** - BLoC and Provider patterns

## 🤝 Contributing

We welcome contributions! Please feel free to submit issues and pull requests.

### Contributing to Documentation
Found something unclear or want to add examples? Check out our [documentation contribution guide](./docs/README.md#contributing).

## 📄 License

MIT License - see LICENSE file for details.
