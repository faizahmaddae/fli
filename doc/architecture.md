# 🏗️ Architecture Guide

This document explains the architectural decisions and patterns used in the fli CLI tool templates.

## 📐 Design Principles

### 1. **Separation of Concerns**
Each template separates different aspects of the application:
- **Presentation**: UI components and screens
- **Business Logic**: Application rules and data processing
- **Data**: External data sources and local storage

### 2. **Scalability**
Templates are designed to grow with your application:
- **Modular structure**: Easy to add new features
- **Clear boundaries**: Well-defined interfaces between layers
- **Consistent patterns**: Predictable code organization

### 3. **Maintainability**
Code organization that makes maintenance easier:
- **Clear naming conventions**: Self-documenting code
- **Logical grouping**: Related files are co-located
- **Minimal dependencies**: Reduced coupling between components

## 🎯 Template Architecture Comparison

### Basic Template Architecture
```
┌─────────────────┐
│   Presentation  │  ← Screens, Widgets
├─────────────────┤
│     Services    │  ← API, Storage
├─────────────────┤
│      Core       │  ← Theme, Constants, Utils
└─────────────────┘
```

**Characteristics:**
- Simple 3-layer architecture
- Direct service calls from UI
- Minimal abstraction
- Perfect for small to medium apps

### Feature Driven Architecture
```
┌─────────────────────────────────────┐
│            Shared Layer             │  ← Common widgets, services
├─────────────────────────────────────┤
│  Feature A  │  Feature B  │  ...    │  ← Self-contained features
│ ┌─────────┐ │ ┌─────────┐ │         │
│ │Presentation│ │Presentation│         │
│ ├─────────┤ │ ├─────────┤ │         │
│ │ Logic   │ │ │ Logic   │ │         │
│ ├─────────┤ │ ├─────────┤ │         │
│ │  Data   │ │ │  Data   │ │         │
│ └─────────┘ │ └─────────┘ │         │
├─────────────────────────────────────┤
│              Core Layer             │  ← Infrastructure
└─────────────────────────────────────┘
```

**Characteristics:**
- Feature-based vertical slicing
- Each feature is self-contained
- Shared resources at appropriate levels
- Excellent for team development

### Clean Architecture (Planned)
```
┌─────────────────────────────────────┐
│           Presentation              │  ← UI, State Management
├─────────────────────────────────────┤
│             Domain                  │  ← Entities, Use Cases
├─────────────────────────────────────┤
│              Data                   │  ← Repositories, Data Sources
├─────────────────────────────────────┤
│           External                  │  ← API, Database, Services
└─────────────────────────────────────┘
```

**Characteristics:**
- Dependency inversion principle
- Business logic independence
- High testability
- Maximum flexibility

## 📁 Folder Structure Conventions

### Core Directory Structure
All templates follow these core conventions:

```
lib/
├── core/                    # Shared infrastructure
│   ├── constants/          # App-wide constants
│   ├── theme/             # Theming and styling
│   ├── utils/             # Helper functions
│   └── services/          # Core services
├── [architecture_specific]/
└── main.dart              # Application entry point
```

### Test Directory Structure
```
test/
├── [architecture_specific]/  # Tests mirroring lib structure
├── helpers/                  # Test utilities
└── fixtures/                # Test data
```

## 🎨 Naming Conventions

### Files and Directories
- **snake_case** for file and directory names
- **Descriptive names** that indicate purpose
- **Consistent suffixes**: `_screen.dart`, `_widget.dart`, `_service.dart`

### Classes and Variables
- **PascalCase** for class names
- **camelCase** for variable and method names
- **SCREAMING_SNAKE_CASE** for constants

### Examples
```dart
// ✅ Good
class UserProfileScreen extends StatelessWidget { }
final userApiService = UserApiService();
const String API_BASE_URL = 'https://api.example.com';

// ❌ Avoid
class userprofilescreen extends StatelessWidget { }
final UserApiService = UserApiService();
const String apiBaseUrl = 'https://api.example.com';
```

## 🔧 Service Layer Patterns

### Basic Template Services
```dart
// Simple service with direct implementation
class ApiService {
  static Future<List<User>> getUsers() async {
    // Direct HTTP call
  }
}
```

### Feature Driven Services
```dart
// Feature-specific services with shared base
abstract class BaseApiService {
  String get baseUrl;
  Future<T> request<T>();
}

class UserApiService extends BaseApiService {
  @override
  String get baseUrl => '/users';
  
  Future<List<User>> getUsers() async {
    return request<List<User>>();
  }
}
```

### Clean Architecture Services (Planned)
```dart
// Repository pattern with dependency injection
abstract class UserRepository {
  Future<Either<Failure, List<User>>> getUsers();
}

class UserRepositoryImpl implements UserRepository {
  final UserDataSource remoteDataSource;
  final UserDataSource localDataSource;
  
  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  
  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    // Implementation with error handling
  }
}
```

## 📱 State Management Patterns

### Basic Template (StatefulWidget)
```dart
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];
  
  @override
  void initState() {
    super.initState();
    _loadUsers();
  }
  
  void _loadUsers() async {
    final loadedUsers = await ApiService.getUsers();
    setState(() {
      users = loadedUsers;
    });
  }
}
```

### Provider Pattern (Planned)
```dart
class UserProvider extends ChangeNotifier {
  List<User> _users = [];
  List<User> get users => _users;
  
  Future<void> loadUsers() async {
    _users = await userRepository.getUsers();
    notifyListeners();
  }
}

// In UI
Consumer<UserProvider>(
  builder: (context, userProvider, child) {
    return ListView.builder(
      itemCount: userProvider.users.length,
      itemBuilder: (context, index) {
        return UserTile(user: userProvider.users[index]);
      },
    );
  },
)
```

### BLoC Pattern (Planned)
```dart
// Events
abstract class UserEvent {}
class LoadUsers extends UserEvent {}

// States
abstract class UserState {}
class UserLoading extends UserState {}
class UserLoaded extends UserState {
  final List<User> users;
  UserLoaded(this.users);
}

// BLoC
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  
  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<LoadUsers>(_onLoadUsers);
  }
  
  void _onLoadUsers(LoadUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final users = await userRepository.getUsers();
    emit(UserLoaded(users));
  }
}
```

## 🧪 Testing Strategy

### Test Structure
Each template includes a comprehensive testing strategy:

```
test/
├── unit/                   # Unit tests for business logic
├── widget/                 # Widget tests for UI components
├── integration/            # Integration tests
└── helpers/               # Test utilities and mocks
```

### Testing Patterns

#### Basic Template Testing
```dart
// Unit test example
void main() {
  group('ApiService', () {
    test('should return list of users when API call is successful', () async {
      // Arrange
      final mockClient = MockHttpClient();
      // ... setup

      // Act
      final result = await ApiService.getUsers();

      // Assert
      expect(result, isA<List<User>>());
    });
  });
}
```

#### Feature Driven Testing
```dart
// Feature test example
void main() {
  group('Home Feature', () {
    testWidgets('should display users when loaded successfully', (tester) async {
      // Arrange
      await tester.pumpWidget(MaterialApp(home: HomePage()));

      // Act
      await tester.pump();

      // Assert
      expect(find.byType(UserTile), findsWidgets);
    });
  });
}
```

## 📦 Dependencies Management

### Basic Template Dependencies
- **Minimal dependencies**: Only essential packages
- **Flutter SDK**: Standard widgets and services
- **Common packages**: `http`, `shared_preferences`

### Feature Driven Dependencies
- **Modular dependencies**: Feature-specific packages
- **Shared dependencies**: Common utilities
- **Development tools**: Testing and analysis tools

### Advanced Template Dependencies (Planned)
- **State management**: `flutter_bloc`, `provider`, `riverpod`
- **Dependency injection**: `get_it`, `injectable`
- **Code generation**: `build_runner`, `json_annotation`

## 🔄 Migration Paths

### From Basic to Feature Driven
1. **Group related files** into feature folders
2. **Extract shared widgets** to shared folder
3. **Refactor services** to feature-specific implementation
4. **Update imports** to reflect new structure

### From Feature Driven to Clean Architecture
1. **Define domain entities** and use cases
2. **Create repository abstractions** 
3. **Implement data sources**
4. **Add dependency injection**
5. **Update tests** to match new structure

## 🎯 Best Practices

### Code Organization
- **Group by feature**, not by file type
- **Keep related files close** together
- **Use consistent naming** throughout the project
- **Minimize dependencies** between features

### Performance
- **Lazy loading** for features and services
- **Efficient state management** patterns
- **Minimal widget rebuilds**
- **Resource optimization**

### Maintainability
- **Clear documentation** for complex logic
- **Consistent code style** using linting rules
- **Regular refactoring** to improve structure
- **Comprehensive testing** coverage

---

## 🔮 Future Enhancements

### Template Evolution
- **Automated migration** tools between templates
- **Custom template** creation support
- **AI-powered** code generation
- **Performance optimization** built-in

### Developer Experience
- **IDE integration** with template-specific snippets
- **Visual documentation** with diagrams
- **Interactive tutorials** for each template
- **Best practice enforcement** tools

---

*This architecture guide is living documentation that evolves with the templates.*
