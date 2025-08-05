# 🎯 Template Usage Examples

This document provides practical examples of how to use each template effectively with real-world scenarios and code samples.

## 🏁 Quick Start Examples

### Basic Template Example

```bash
# Create a simple todo app
fli create todo_app --template=basic

cd todo_app
flutter pub get
flutter run
```

**Generated project structure for todo app:**
```
todo_app/
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_colors.dart
│   │   │   ├── app_strings.dart
│   │   │   └── app_assets.dart
│   │   ├── theme/
│   │   │   ├── app_theme.dart
│   │   │   └── text_styles.dart
│   │   └── utils/
│   │       ├── helpers.dart
│   │       └── validators.dart
│   ├── screens/
│   │   └── home/
│   │       ├── home_screen.dart
│   │       └── widgets/
│   ├── widgets/
│   │   ├── common/
│   │   └── custom/
│   ├── services/
│   │   ├── api_service.dart
│   │   └── storage_service.dart
│   ├── app.dart
│   └── main.dart
└── test/
```

### Feature Driven Example

```bash
# Create an e-commerce app with features
fli create shop_app --template=feature_driven

cd shop_app
flutter pub get
flutter run
```

**Adding new features to the generated structure:**
```
shop_app/
├── lib/
│   ├── features/
│   │   ├── home/              # Generated
│   │   ├── products/          # Add manually
│   │   │   ├── presentation/
│   │   │   │   ├── pages/
│   │   │   │   └── widgets/
│   │   │   ├── domain/
│   │   │   └── data/
│   │   ├── cart/              # Add manually
│   │   └── profile/           # Add manually
```

## 📋 Detailed Usage Scenarios

### Scenario 1: Small Business App (Basic Template)

**Use Case:** Local restaurant menu app with simple navigation

```bash
fli create restaurant_menu --template=basic
```

**Customization steps:**
1. **Update constants:**
```dart
// lib/core/constants/app_strings.dart
class AppStrings {
  static const String appName = 'Bella Vista Restaurant';
  static const String welcome = 'Welcome to our restaurant';
  static const String menuTitle = 'Our Menu';
}
```

2. **Add menu screens:**
```dart
// lib/screens/menu/menu_screen.dart
class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.menuTitle)),
      body: MenuList(),
    );
  }
}
```

3. **Create custom widgets:**
```dart
// lib/widgets/custom/menu_item_card.dart
class MenuItemCard extends StatelessWidget {
  final MenuItem item;
  
  const MenuItemCard({Key? key, required this.item}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(item.imageUrl),
        ),
        title: Text(item.name),
        subtitle: Text(item.description),
        trailing: Text('\$${item.price}'),
      ),
    );
  }
}
```

### Scenario 2: Social Media App (Feature Driven Template)

**Use Case:** Instagram-like app with multiple distinct features

```bash
fli create social_app --template=feature_driven
```

**Feature organization:**
```
social_app/
├── lib/
│   ├── features/
│   │   ├── auth/
│   │   │   ├── presentation/
│   │   │   │   ├── pages/
│   │   │   │   │   ├── login_page.dart
│   │   │   │   │   └── register_page.dart
│   │   │   │   └── widgets/
│   │   │   │       ├── auth_form.dart
│   │   │   │       └── social_login_buttons.dart
│   │   ├── feed/
│   │   │   ├── presentation/
│   │   │   │   ├── pages/
│   │   │   │   │   └── feed_page.dart
│   │   │   │   └── widgets/
│   │   │   │       ├── post_card.dart
│   │   │   │       └── story_list.dart
│   │   ├── profile/
│   │   └── messaging/
```

**Example feature implementation:**
```dart
// lib/features/feed/presentation/pages/feed_page.dart
class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () => Navigator.pushNamed(context, '/camera'),
          ),
        ],
      ),
      body: Column(
        children: [
          StoryList(),
          Expanded(child: PostList()),
        ],
      ),
    );
  }
}

// lib/features/feed/presentation/widgets/post_card.dart
class PostCard extends StatelessWidget {
  final Post post;
  
  const PostCard({Key? key, required this.post}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          PostHeader(user: post.author),
          PostImage(imageUrl: post.imageUrl),
          PostActions(post: post),
          PostContent(content: post.content),
        ],
      ),
    );
  }
}
```

### Scenario 3: Enterprise Dashboard (Clean Architecture - Planned)

**Use Case:** Business analytics dashboard with complex data flows

```bash
# When available
fli create analytics_dashboard --template=clean_architecture
```

**Planned structure:**
```dart
// lib/features/dashboard/domain/entities/analytics_data.dart
class AnalyticsData {
  final String id;
  final DateTime timestamp;
  final Map<String, dynamic> metrics;
  
  AnalyticsData({
    required this.id,
    required this.timestamp,
    required this.metrics,
  });
}

// lib/features/dashboard/domain/usecases/get_analytics_data.dart
class GetAnalyticsData {
  final AnalyticsRepository repository;
  
  GetAnalyticsData(this.repository);
  
  Future<Either<Failure, AnalyticsData>> call(DateRange dateRange) async {
    return await repository.getAnalyticsData(dateRange);
  }
}

// lib/features/dashboard/presentation/bloc/dashboard_bloc.dart
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetAnalyticsData getAnalyticsData;
  
  DashboardBloc({required this.getAnalyticsData}) : super(DashboardInitial()) {
    on<LoadDashboardData>(_onLoadDashboardData);
  }
  
  void _onLoadDashboardData(
    LoadDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    
    final result = await getAnalyticsData(event.dateRange);
    
    result.fold(
      (failure) => emit(DashboardError(failure.message)),
      (data) => emit(DashboardLoaded(data)),
    );
  }
}
```

## 🔧 Common Customization Patterns

### Adding New Screens (Basic Template)

1. **Create screen file:**
```dart
// lib/screens/settings/settings_screen.dart
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: SettingsBody(),
    );
  }
}
```

2. **Add navigation:**
```dart
// lib/app.dart - Add route
MaterialApp(
  routes: {
    '/': (context) => HomeScreen(),
    '/settings': (context) => SettingsScreen(),
  },
)
```

3. **Create navigation action:**
```dart
// From any screen
Navigator.pushNamed(context, '/settings');
```

### Adding New Features (Feature Driven Template)

1. **Create feature structure:**
```bash
mkdir -p lib/features/notifications/presentation/{pages,widgets}
mkdir -p lib/features/notifications/{domain,data}
```

2. **Implement feature pages:**
```dart
// lib/features/notifications/presentation/pages/notifications_page.dart
class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      body: NotificationsList(),
    );
  }
}
```

3. **Add to navigation:**
```dart
// lib/core/services/navigation_service.dart
class NavigationService {
  static void goToNotifications(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => NotificationsPage()),
    );
  }
}
```

### Theme Customization

**Update app theme:**
```dart
// lib/core/theme/app_theme.dart
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      cardTheme: CardTheme(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
```

**Add custom colors:**
```dart
// lib/core/constants/app_colors.dart
class AppColors {
  static const Color primary = Color(0xFF2196F3);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFB00020);
  
  // Custom colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
}
```

## 📱 Integration Examples

### API Integration

**Basic template API service:**
```dart
// lib/services/api_service.dart
class ApiService {
  static const String baseUrl = 'https://api.example.com';
  
  static Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));
    
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
  
  static Future<Product> createProduct(Product product) async {
    final response = await http.post(
      Uri.parse('$baseUrl/products'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );
    
    if (response.statusCode == 201) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create product');
    }
  }
}
```

### Local Storage Integration

**Storage service implementation:**
```dart
// lib/services/storage_service.dart
class StorageService {
  static const String _userKey = 'user_data';
  static const String _settingsKey = 'app_settings';
  
  static Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, json.encode(user.toJson()));
  }
  
  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(_userKey);
    
    if (userData != null) {
      return User.fromJson(json.decode(userData));
    }
    return null;
  }
  
  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
```

### State Management Integration (Planned)

**Provider pattern example:**
```dart
// With Provider template
class UserProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  
  User? get user => _user;
  bool get isLoading => _isLoading;
  
  Future<void> loadUser() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      _user = await ApiService.getCurrentUser();
    } catch (e) {
      _user = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

// Usage in widget
Consumer<UserProvider>(
  builder: (context, userProvider, child) {
    if (userProvider.isLoading) {
      return CircularProgressIndicator();
    }
    
    final user = userProvider.user;
    if (user == null) {
      return Text('No user logged in');
    }
    
    return Text('Welcome, ${user.name}!');
  },
)
```

## 🧪 Testing Examples

### Widget Testing

```dart
// test/screens/home/home_screen_test.dart
void main() {
  group('HomeScreen', () {
    testWidgets('should display app title', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: HomeScreen()),
      );
      
      expect(find.text('Home'), findsOneWidget);
    });
    
    testWidgets('should navigate to settings on button tap', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HomeScreen(),
          routes: {'/settings': (context) => SettingsScreen()},
        ),
      );
      
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();
      
      expect(find.byType(SettingsScreen), findsOneWidget);
    });
  });
}
```

### Unit Testing

```dart
// test/services/api_service_test.dart
void main() {
  group('ApiService', () {
    test('should return products when API call is successful', () async {
      // Mock the HTTP client
      final mockClient = MockClient((request) async {
        return Response(
          json.encode([
            {'id': 1, 'name': 'Product 1', 'price': 29.99}
          ]),
          200,
        );
      });
      
      // Use the mock client
      final products = await ApiService.getProducts();
      
      expect(products, isA<List<Product>>());
      expect(products.length, equals(1));
      expect(products.first.name, equals('Product 1'));
    });
  });
}
```

## 🚀 Deployment Examples

### Building for Production

```bash
# Build for Android
flutter build apk --release

# Build for iOS
flutter build ios --release

# Build for Web
flutter build web --release

# Build for Desktop
flutter build windows --release
flutter build macos --release
flutter build linux --release
```

### Environment Configuration

```dart
// lib/core/constants/environment.dart
class Environment {
  static const bool isProduction = bool.fromEnvironment('PRODUCTION');
  static const String apiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'https://api.example.com',
  );
  static const String appName = String.fromEnvironment(
    'APP_NAME',
    defaultValue: 'My App',
  );
}

// Usage
flutter build apk --dart-define=PRODUCTION=true --dart-define=API_URL=https://prod.api.com
```

---

## 💡 Pro Tips

### Development Workflow
1. **Start with the appropriate template** for your project size
2. **Follow the established patterns** when adding new features
3. **Keep feature folders self-contained** in feature-driven templates
4. **Use shared components** for common UI elements
5. **Write tests** as you develop features

### Performance Optimization
1. **Use const constructors** where possible
2. **Implement proper disposal** of resources
3. **Optimize image loading** with proper caching
4. **Use lazy loading** for large lists
5. **Profile your app** regularly during development

### Code Organization
1. **Group imports** by type (dart, flutter, packages, relative)
2. **Use barrel exports** for cleaner imports
3. **Keep files small** and focused on single responsibility
4. **Document complex business logic**
5. **Use meaningful names** for classes and methods

---

*These examples show practical usage patterns. Adapt them to your specific needs and requirements.*
