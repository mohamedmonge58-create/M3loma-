import 'dart:io';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    printHelp();
    return;
  }

  switch (arguments[0]) {
    case 'create':
      createProjectStructure();
      break;

    case 'feature':
      if (arguments.length < 2) {
        print('❌ Please provide a feature name.');
        print('Example: monge feature movies');
        return;
      }

      createFeature(arguments[1]);
      break;

    default:
      print('❌ Unknown command: ${arguments[0]}');
      printHelp();
  }
}

// ============================================================
// HELP
// ============================================================

void printHelp() {
  print('''
╔══════════════════════════════════════════╗
║        MONGE FLUTTER GENERATOR           ║
╚══════════════════════════════════════════╝

Commands:

  monge create

      Creates the complete Flutter architecture.

  monge feature <name>

      Creates a complete feature.

Examples:

  monge create

  monge feature auth

  monge feature movies

''');
}

// ============================================================
// CREATE COMPLETE PROJECT STRUCTURE
// ============================================================

void createProjectStructure() {
  print('');
  print('🚀 Creating complete Flutter architecture...');
  print('');

  final directories = <String>[
    // ========================================================
    // ASSETS
    // ========================================================

    'assets/images',
    'assets/images/logos',
    'assets/images/backgrounds',
    'assets/images/placeholders',

    'assets/icons',
    'assets/icons/navigation',
    'assets/icons/actions',

    'assets/animations',

    'assets/json',

    'assets/fonts',

    // ========================================================
    // CORE
    // ========================================================

    'lib/core/constants',

    'lib/core/di',

    'lib/core/error',

    'lib/core/network',

    'lib/core/router',

    'lib/core/services',

    'lib/core/theme',

    'lib/core/utils',

    'lib/core/widgets',

    // ========================================================
    // APP
    // ========================================================

    'lib/app',

    // ========================================================
    // FEATURES
    // ========================================================

    'lib/features/auth/data/datasources',
    'lib/features/auth/data/models',
    'lib/features/auth/data/repositories',

    'lib/features/auth/domain/entities',
    'lib/features/auth/domain/repositories',
    'lib/features/auth/domain/usecases',

    'lib/features/auth/presentation/cubit',
    'lib/features/auth/presentation/pages',
    'lib/features/auth/presentation/widgets',

    'lib/features/home/data/datasources',
    'lib/features/home/data/models',
    'lib/features/home/data/repositories',

    'lib/features/home/domain/entities',
    'lib/features/home/domain/repositories',
    'lib/features/home/domain/usecases',

    'lib/features/home/presentation/cubit',
    'lib/features/home/presentation/pages',
    'lib/features/home/presentation/widgets',

    'lib/features/splash/presentation/pages',

    // ========================================================
    // TEST
    // ========================================================

    'test',
  ];

  for (final path in directories) {
    createDirectory(path);
  }

  // ==========================================================
  // CORE FILES
  // ==========================================================

  createFile(
    'lib/core/constants/app_constants.dart',
    '''
class AppConstants {
  AppConstants._();

  static const String appName = 'My App';
}
''',
  );

  createFile(
    'lib/core/constants/api_constants.dart',
    '''
class ApiConstants {
  ApiConstants._();

  static const String baseUrl = '';

  static const String login = '/login';
  static const String register = '/register';
}
''',
  );

  createFile(
    'lib/core/constants/storage_keys.dart',
    '''
class StorageKeys {
  StorageKeys._();

  static const String token = 'token';
  static const String userId = 'user_id';
  static const String onboardingCompleted =
      'onboarding_completed';
}
''',
  );

  // ==========================================================
  // ERROR
  // ==========================================================

  createFile(
    'lib/core/error/exceptions.dart',
    '''
class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class CacheException implements Exception {
  final String message;

  CacheException(this.message);
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);
}
''',
  );

  createFile(
    'lib/core/error/failures.dart',
    '''
abstract class Failure {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}
''',
  );

  // ==========================================================
  // NETWORK
  // ==========================================================

  createFile(
    'lib/core/network/api_client.dart',
    '''
import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient(this.dio);

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    return dio.get<T>(
      path,
      queryParameters: queryParameters,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) {
    return dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
  }) {
    return dio.put<T>(
      path,
      data: data,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
  }) {
    return dio.delete<T>(
      path,
      data: data,
    );
  }
}
''',
  );

  createFile(
    'lib/core/network/api_result.dart',
    '''
sealed class ApiResult<T> {
  const ApiResult();
}

class ApiSuccess<T> extends ApiResult<T> {
  final T data;

  const ApiSuccess(this.data);
}

class ApiError<T> extends ApiResult<T> {
  final String message;

  const ApiError(this.message);
}
''',
  );

  createFile(
    'lib/core/network/network_info.dart',
    '''
abstract class NetworkInfo {
  Future<bool> get isConnected;
}
''',
  );

  // ==========================================================
  // ROUTER
  // ==========================================================

  createFile(
    'lib/core/router/app_routes.dart',
    '''
class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
}
''',
  );

  createFile(
    'lib/core/router/app_router.dart',
    '''
import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import 'app_routes.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
        );

      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );

      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterPage(),
        );

      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Route not found'),
            ),
          ),
        );
    }
  }
}
''',
  );

  // ==========================================================
  // THEME
  // ==========================================================

  createFile(
    'lib/core/theme/app_colors.dart',
    '''
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Colors.blue;
  static const Color background = Colors.white;
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static const Color red = Colors.red;
  static const Color green = Colors.green;
}
''',
  );

  createFile(
    'lib/core/theme/app_text_styles.dart',
    '''
import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 14,
  );
}
''',
  );

  createFile(
    'lib/core/theme/app_theme.dart',
    '''
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: AppColors.primary,
  );
}
''',
  );

  // ==========================================================
  // SERVICES
  // ==========================================================

  createFile(
    'lib/core/services/loading_service.dart',
    '''
import 'package:flutter/material.dart';

class LoadingService {
  LoadingService._();

  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(
      context,
      rootNavigator: true,
    ).pop();
  }
}
''',
  );

  createFile(
    'lib/core/services/storage_service.dart',
    '''
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferences preferences;

  StorageService(this.preferences);

  Future<void> saveString(
    String key,
    String value,
  ) async {
    await preferences.setString(key, value);
  }

  String? getString(String key) {
    return preferences.getString(key);
  }

  Future<void> remove(String key) async {
    await preferences.remove(key);
  }

  Future<void> clear() async {
    await preferences.clear();
  }
}
''',
  );

  createFile(
    'lib/core/services/cache_service.dart',
    '''
class CacheService {
  CacheService._();

  static final CacheService instance =
      CacheService._();

  final Map<String, dynamic> _cache = {};

  void save<T>(String key, T value) {
    _cache[key] = value;
  }

  T? get<T>(String key) {
    return _cache[key] as T?;
  }

  void remove(String key) {
    _cache.remove(key);
  }

  void clear() {
    _cache.clear();
  }
}
''',
  );

  // ==========================================================
  // DI
  // ==========================================================

  createFile(
    'lib/core/di/injection.dart',
    '''
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Register dependencies here.
}
''',
  );

  // ==========================================================
  // UTILS
  // ==========================================================

  createFile(
    'lib/core/utils/validators.dart',
    '''
class Validators {
  Validators._();

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final regex = RegExp(
      r'^[^@]+@[^@]+\\\\.[^@]+',
    );

    if (!regex.hasMatch(value)) {
      return 'Enter a valid email';
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  static String? required(
    String? value, {
    String message = 'This field is required',
  }) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }

    return null;
  }
}
''',
  );

  createFile(
    'lib/core/utils/extensions.dart',
    '''
extension StringExtensions on String? {
  bool get isNullOrEmpty {
    return this == null || this!.trim().isEmpty;
  }
}
''',
  );

  // ==========================================================
  // WIDGETS
  // ==========================================================

  createFile(
    'lib/core/widgets/app_button.dart',
    '''
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(text),
      ),
    );
  }
}
''',
  );

  createFile(
    'lib/core/widgets/app_text_field.dart',
    '''
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;

  const AppTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
''',
  );

  createFile(
    'lib/core/widgets/app_loading.dart',
    '''
import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
''',
  );

  createFile(
    'lib/core/widgets/app_error.dart',
    '''
import 'package:flutter/material.dart';

class AppError extends StatelessWidget {
  final String message;

  const AppError({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
''',
  );

  // ==========================================================
  // APP
  // ==========================================================

  createFile(
    'lib/app/app.dart',
    '''
import 'package:flutter/material.dart';

import '../core/router/app_router.dart';
import '../core/router/app_routes.dart';
import '../core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      initialRoute: AppRoutes.splash,

      onGenerateRoute:
          AppRouter.onGenerateRoute,
    );
  }
}
''',
  );

  createFile(
    'lib/main.dart',
    '''
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  runApp(
    const MyApp(),
  );
}
''',
  );

  // ==========================================================
  // SPLASH
  // ==========================================================

  createFile(
    'lib/features/splash/presentation/pages/splash_page.dart',
    '''
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() =>
      _SplashPageState();
}

class _SplashPageState
    extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    _start();
  }

  Future<void> _start() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!mounted) return;

    // Add navigation logic here.
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 100,
        ),
      ),
    );
  }
}
''',
  );

  // ==========================================================
  // PUBSPEC
  // ==========================================================

  updatePubspec();

  print('');
  print('╔══════════════════════════════════════════╗');
  print('║     ARCHITECTURE CREATED SUCCESSFULLY   ║');
  print('╚══════════════════════════════════════════╝');
  print('');
  print('Next: flutter pub get');
  print('');
}

// ============================================================
// CREATE FEATURE
// ============================================================

void createFeature(String featureName) {
  final name = normalize(featureName);
  final pascalName = toPascalCase(name);

  final base = 'lib/features/$name';

  print('');
  print('🚀 Creating feature: $name');
  print('');

  final directories = [
    '$base/data/datasources',
    '$base/data/models',
    '$base/data/repositories',

    '$base/domain/entities',
    '$base/domain/repositories',
    '$base/domain/usecases',

    '$base/presentation/cubit',
    '$base/presentation/pages',
    '$base/presentation/widgets',
  ];

  for (final path in directories) {
    createDirectory(path);
  }

  createFile(
    '$base/domain/entities/${name}_entity.dart',
    '''
class ${pascalName}Entity {
  const ${pascalName}Entity();
}
''',
  );

  createFile(
    '$base/data/models/${name}_model.dart',
    '''
import '../../domain/entities/${name}_entity.dart';

class ${pascalName}Model extends ${pascalName}Entity {
  const ${pascalName}Model();

  factory ${pascalName}Model.fromJson(
    Map<String, dynamic> json,
  ) {
    return const ${pascalName}Model();
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}
''',
  );

  createFile(
    '$base/domain/repositories/${name}_repository.dart',
    '''
import '../entities/${name}_entity.dart';

abstract class ${pascalName}Repository {
  Future<${pascalName}Entity> getData();
}
''',
  );

  createFile(
    '$base/data/datasources/${name}_remote_data_source.dart',
    '''
import '../models/${name}_model.dart';

abstract class ${pascalName}RemoteDataSource {
  Future<${pascalName}Model> getData();
}
''',
  );

  createFile(
    '$base/data/repositories/${name}_repository_impl.dart',
    '''
import '../../domain/entities/${name}_entity.dart';
import '../../domain/repositories/${name}_repository.dart';
import '../datasources/${name}_remote_data_source.dart';

class ${pascalName}RepositoryImpl
    implements ${pascalName}Repository {

  final ${pascalName}RemoteDataSource remoteDataSource;

  ${pascalName}RepositoryImpl(
    this.remoteDataSource,
  );

  @override
  Future<${pascalName}Entity> getData() {
    return remoteDataSource.getData();
  }
}
''',
  );

  createFile(
    '$base/domain/usecases/get_${name}_usecase.dart',
    '''
import '../entities/${name}_entity.dart';
import '../repositories/${name}_repository.dart';

class Get${pascalName}UseCase {
  final ${pascalName}Repository repository;

  Get${pascalName}UseCase(this.repository);

  Future<${pascalName}Entity> call() {
    return repository.getData();
  }
}
''',
  );

  createFile(
    '$base/presentation/cubit/${name}_state.dart',
    '''
sealed class ${pascalName}State {
  const ${pascalName}State();
}

class ${pascalName}Initial extends ${pascalName}State {}

class ${pascalName}Loading extends ${pascalName}State {}

class ${pascalName}Success extends ${pascalName}State {}

class ${pascalName}Error extends ${pascalName}State {
  final String message;

  const ${pascalName}Error(this.message);
}
''',
  );

  createFile(
    '$base/presentation/cubit/${name}_cubit.dart',
    '''
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_${name}_usecase.dart';
import '${name}_state.dart';

class ${pascalName}Cubit
    extends Cubit<${pascalName}State> {

  final Get${pascalName}UseCase get${pascalName}UseCase;

  ${pascalName}Cubit(
    this.get${pascalName}UseCase,
  ) : super(${pascalName}Initial());

  Future<void> load() async {
    emit(${pascalName}Loading());

    try {
      await get${pascalName}UseCase();

      emit(${pascalName}Success());
    } catch (e) {
      emit(${pascalName}Error(e.toString()));
    }
  }
}
''',
  );

  createFile(
    '$base/presentation/pages/${name}_page.dart',
    '''
import 'package:flutter/material.dart';

class ${pascalName}Page extends StatelessWidget {
  const ${pascalName}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('$pascalName'),
      ),
      body: const Center(
        child: Text('$pascalName Page'),
      ),
    );
  }
}
''',
  );

  createFile(
    '$base/presentation/widgets/${name}_item.dart',
    '''
import 'package:flutter/material.dart';

class ${pascalName}Item extends StatelessWidget {
  const ${pascalName}Item({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Text('$pascalName Item'),
    );
  }
}
''',
  );

  print('');
  print('✓ Feature "$name" created successfully.');
  print('');
}

// ============================================================
// PUBSPEC
// ============================================================

void updatePubspec() {
  final file = File('pubspec.yaml');

  if (!file.existsSync()) {
    print('⚠️ pubspec.yaml not found.');
    return;
  }

  var content = file.readAsStringSync();

  final dependencies = '''
  dio: ^5.8.0+1
  flutter_bloc: ^9.1.1
  get_it: ^8.2.0
  go_router: ^16.0.0
  shared_preferences: ^2.5.3
  cached_network_image: ^3.4.1
''';

  if (!content.contains('dio:')) {
    content = content.replaceFirst(
      'dependencies:',
      'dependencies:\\n$dependencies',
    );
  }

  if (!content.contains('assets/images/')) {
    if (content.contains('flutter:')) {
      content = content.replaceFirst(
        'flutter:',
        '''flutter:

  uses-material-design: true

  assets:
    - assets/images/
    - assets/icons/
    - assets/animations/
    - assets/json/
''',
      );
    }
  }

  file.writeAsStringSync(content);

  print('✓ pubspec.yaml updated.');
}

// ============================================================
// HELPERS
// ============================================================

void createDirectory(String path) {
  Directory(path).createSync(recursive: true);
  print('✓ $path');
}

void createFile(
    String path,
    String content,
    ) {
  final file = File(path);

  file.parent.createSync(recursive: true);

  if (file.existsSync()) {
    print('⚠️ Already exists: $path');
    return;
  }

  file.writeAsStringSync(content.trim());

  print('✓ $path');
}

String normalize(String value) {
  return value
      .trim()
      .replaceAll('-', '_')
      .replaceAll(' ', '_')
      .toLowerCase();
}

String toPascalCase(String value) {
  return value
      .split('_')
      .where((part) => part.isNotEmpty)
      .map(
        (part) =>
    '${part[0].toUpperCase()}${part.substring(1)}',
  )
      .join();
}
