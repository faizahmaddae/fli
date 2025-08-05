# 📚 fli Documentation

Welcome to the comprehensive documentation for **fli** - Flutter Layer Infrastructure CLI tool.

## 🗂️ Documentation Index

### 📋 [Template Documentation](./templates.md)
Complete guide to all available templates with detailed structure explanations, use cases, and generated code examples.

**What you'll find:**
- Template overview and comparison table
- Detailed structure for each template
- When to use each template
- Generated files explanation
- Current implementation status
- Future roadmap

### 🏗️ [Architecture Guide](./architecture.md)
Deep dive into the architectural patterns and design principles used across templates.

**What you'll find:**
- Design principles and patterns
- Architecture comparison between templates
- Folder structure conventions
- Naming conventions
- Service layer patterns
- State management approaches
- Testing strategies
- Migration paths between templates

### 📱 [Usage Examples](./examples.md)
Practical examples and real-world scenarios for using each template effectively.

**What you'll find:**
- Quick start examples
- Detailed usage scenarios
- Customization patterns
- API integration examples
- Local storage integration
- State management examples
- Testing examples
- Deployment guides
- Pro tips and best practices

## 🚀 Quick Navigation

### For New Users
1. Start with **[Template Documentation](./templates.md)** to understand available options
2. Read **[Usage Examples](./examples.md)** for practical implementation
3. Reference **[Architecture Guide](./architecture.md)** for deeper understanding

### For Experienced Developers
1. Jump to **[Architecture Guide](./architecture.md)** for technical details
2. Use **[Template Documentation](./templates.md)** as reference
3. Check **[Usage Examples](./examples.md)** for advanced patterns

### For Team Leads
1. Review **[Template Documentation](./templates.md)** for team standardization
2. Study **[Architecture Guide](./architecture.md)** for architectural decisions
3. Share **[Usage Examples](./examples.md)** with your team

## 📊 Template Selection Guide

| Project Type | Team Size | Complexity | Recommended Template |
|--------------|-----------|------------|---------------------|
| MVP/Prototype | 1-2 | Low | [Basic](./templates.md#basic-template) |
| Small App | 1-3 | Low-Medium | [Basic](./templates.md#basic-template) |
| Medium App | 2-5 | Medium | [Feature Driven](./templates.md#feature-driven-template) |
| Large App | 5+ | High | [Clean Architecture](./templates.md#clean-architecture-template) |
| State-Heavy | Any | Medium-High | [BLoC Pattern](./templates.md#bloc-pattern-template) |
| Simple State | Any | Medium | [Provider Pattern](./templates.md#provider-pattern-template) |

## 🛠️ Getting Started

### Installation
```bash
# Install from pub.dev
dart pub global activate fli

# Verify installation
fli --version
```

### Create Your First Project
```bash
# Interactive mode (recommended for beginners)
fli create my_app --interactive

# Quick start with basic template
fli create my_app --template=basic

# Advanced template
fli create my_app --template=feature_driven
```

### Explore Generated Structure
```bash
cd my_app
ls -la lib/
flutter test
flutter run
```

## 📖 Additional Resources

### Command Reference
```bash
fli --help              # Show all available commands
fli create --help       # Show create command options
fli templates           # List all available templates
fli --version          # Show current version
```

### Template Commands
```bash
fli create <name>                    # Interactive template selection
fli create <name> --template=basic   # Basic template
fli create <name> --template=feature_driven  # Feature-driven template
fli create <name> --template=clean_architecture  # Clean architecture
fli create <name> --template=bloc_pattern        # BLoC pattern
fli create <name> --template=provider_pattern    # Provider pattern
```

### Development Workflow
1. **Choose template** based on project requirements
2. **Generate project** with fli create
3. **Customize structure** following template patterns
4. **Add features** using established conventions
5. **Test regularly** with generated test structure
6. **Deploy** using Flutter build commands

## 🔗 External Links

- **GitHub Repository**: [https://github.com/faizahmaddae/fli](https://github.com/faizahmaddae/fli)
- **pub.dev Package**: [https://pub.dev/packages/fli](https://pub.dev/packages/fli)
- **Issue Tracker**: [https://github.com/faizahmaddae/fli/issues](https://github.com/faizahmaddae/fli/issues)
- **Flutter Documentation**: [https://flutter.dev/docs](https://flutter.dev/docs)
- **Dart Documentation**: [https://dart.dev/guides](https://dart.dev/guides)

## 🤝 Contributing

### Documentation Improvements
- Found a typo or unclear explanation?
- Want to add more examples?
- Have suggestions for better organization?

**Contribute to documentation:**
1. Fork the repository
2. Edit the relevant `.md` files in the `docs/` folder
3. Submit a pull request

### Template Enhancements
- Ideas for new templates?
- Improvements to existing templates?
- Bug fixes or optimizations?

**Contribute to templates:**
1. Check the [issues](https://github.com/faizahmaddae/fli/issues) for planned work
2. Create an issue for discussion
3. Fork and implement your changes
4. Submit a pull request

## 📞 Support

### Getting Help
1. **Documentation**: Check this documentation first
2. **Issues**: Search [existing issues](https://github.com/faizahmaddae/fli/issues)
3. **New Issue**: Create a new issue with details
4. **Discussions**: Join GitHub discussions for questions

### Reporting Bugs
When reporting bugs, please include:
- fli version (`fli --version`)
- Flutter version (`flutter --version`)
- Operating system
- Complete error message
- Steps to reproduce

### Feature Requests
For feature requests, please include:
- Use case description
- Expected behavior
- Example of how it would work
- Possible implementation approach

---

## 📝 Documentation Updates

This documentation is continuously updated with:
- New template features
- Updated examples
- Community feedback
- Best practice improvements

**Last updated**: August 2025  
**fli version**: 1.0.1  
**Documentation version**: 1.0.0

---

*Happy coding with fli! 🚀*
