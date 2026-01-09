# Copilot Instructions for Delivery App

## 1. Big Picture Architecture
- **Feature-based Clean Architecture**: All business logic is organized by feature in `lib/features/`, each split into `domain` (entities, repositories, usecases), `data` (datasources, DTOs, repository impl), and `presentation` (providers, screens, widgets).
- **Core Layer**: Shared utilities, error handling, logging, routing, and network setup are in `lib/core/`.
- **State Management**: Riverpod (`flutter_riverpod`) is used everywhere, with `StateNotifier` for complex state and simple providers for dependencies. Each feature has its own provider files, and notifiers are split for clarity.
- **Navigation**: GoRouter is the main navigation system, with custom context extensions in `core/routing/navigation_helper.dart` for actions like `goToLogin`, `pushSettings`, etc. Never use context after an async gap; always use state-driven navigation via `ref.listen`.
- **API/Data Layer**: Retrofit (`retrofit`) and Dio (`dio`) for HTTP. DTOs are passed directly to endpoints and serialized via Freezed. All API calls are wrapped in repository interfaces and usecases for testability and separation.
- **Error Handling**: Functional error handling with `fpdart` (`Either<Failure, T>`), custom exceptions, and fallback mock data if API fails.
- **Code Generation**: Freezed and build_runner for DTOs, entities, and state classes. Always run codegen after changing DTO/entity/state.

## 2. Feature Architecture Template (Based on Auth Feature)

### Domain Layer Structure
```
domain/
├── entities/           # Business entities (pure Dart classes)
│   ├── auth_entity.dart
│   └── user_entity.dart
├── repositories/       # Repository interfaces
│   ├── auth_repository.dart
│   └── token_storage_repository.dart
└── usecases/          # Business logic use cases
    ├── login_usecase.dart
    ├── register_usecase.dart
    └── refresh_token_usecase.dart
```

### Data Layer Structure
```
data/
├── datasources/       # API and local data sources
│   ├── auth_remote_datasource.dart (interface)
│   └── auth_remote_datasource_impl.dart (Retrofit impl)
├── dtos/             # Data transfer objects (Freezed)
│   ├── login_request_dto.dart
│   ├── auth_response_dto.dart
│   └── refresh_token_response_dto.dart
├── models/           # Local storage models
│   └── token_model.dart
└── repositories_impl/ # Repository implementations
    ├── auth_repository_impl.dart
    └── token_storage_repository_impl.dart
```

### Presentation Layer Structure
```
presentation/
├── providers/        # Riverpod providers and state (SEPARATED FILES)
│   ├── providers.dart          # Barrel export file
│   ├── example_state.dart      # State classes
│   ├── example_notifier.dart   # StateNotifier classes
│   ├── example_providers.dart  # Provider definitions
│   └── example_network_providers.dart # Network/API providers
├── screens/         # UI screens
│   ├── login_screen.dart
│   ├── register_screen.dart
│   └── forgot_password_screen.dart
└── widgets/         # Reusable widgets
    └── token_storage_example.dart
```

## 3. Feature Creation Step-by-Step Guide

### Step 1: Domain Layer (Business Logic)
1. **Create Entity**:
   ```dart
   // domain/entities/example_entity.dart
   class ExampleEntity {
     final String id;
     final String name;
     
     ExampleEntity({required this.id, required this.name});
   }
   ```

2. **Create Repository Interface**:
   ```dart
   // domain/repositories/example_repository.dart
   abstract class ExampleRepository {
     Future<Either<Failure, ExampleEntity>> getExample(String id);
     Future<Either<Failure, List<ExampleEntity>>> getExamples();
   }
   ```

3. **Create UseCase**:
   ```dart
   // domain/usecases/get_example_usecase.dart
   class GetExampleUseCase extends UseCase<ExampleEntity, GetExampleParams> {
     final ExampleRepository repository;
     
     GetExampleUseCase(this.repository);
     
     @override
     Future<Either<Failure, ExampleEntity>> call(GetExampleParams params) async {
       // Add validation if needed
       return await repository.getExample(params.id);
     }
   }
   
   class GetExampleParams {
     final String id;
     GetExampleParams({required this.id});
   }
   ```

### Step 2: Data Layer (Implementation)

## 🔧 STANDARDIZED PATTERNS (MANDATORY FOR ALL MODULES)

### Remote DataSource Implementation Pattern
**ALL remote datasources MUST follow this exact pattern:**

```dart
class ExampleRemoteDataSourceImpl implements ExampleRemoteDataSource {
  final ExampleApiService _apiService;  // ✅ Private field with underscore

  ExampleRemoteDataSourceImpl(this._apiService);

  @override
  Future<BaseResponseDto<ExampleDto>> getExample(String id) async {
    try {
      AppLogger.d('Getting example with id: $id');  // ✅ Debug log at start
      final response = await _apiService.getExample(id);
      AppLogger.i('Successfully retrieved example');  // ✅ Success log
      return response;  // ✅ Return response directly (no success check)
    } on DioException catch (e) {
      AppLogger.e('Failed to get example with id: $id', e);  // ✅ Error log with context
      throw ResponseHandler.mapDioExceptionToException(e);  // ✅ Use ResponseHandler
    } catch (e) {
      AppLogger.e('Unexpected error getting example', e);  // ✅ Generic error log
      throw Exception('Unexpected error: ${e.toString()}');  // ✅ Generic exception
    }
  }
}
```

### Repository Implementation Pattern
**ALL repositories MUST follow this exact pattern:**

```dart
class ExampleRepositoryImpl implements ExampleRepository {
  final ExampleRemoteDataSource remoteDataSource;

  ExampleRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ExampleEntity>> getExample(String id) async {
    try {
      final response = await remoteDataSource.getExample(id);

      if (response.isSuccess && response.data != null) {
        return right(response.data!.toEntity());
      } else {
        return left(ServerFailure(response.message));
      }
    } on Exception catch (e) {
      return left(mapExceptionToFailure(e));
    } catch (e) {
      return left(const ServerFailure('Unexpected error occurred'));
    }
  }
}
```

### Key Rules:
- **🚫 NEVER** use `Either<Exception, T>` in remote datasources
- **🚫 NEVER** manually check `response.isSuccess` in remote datasources
- **✅ ALWAYS** use `AppLogger.d()`, `AppLogger.i()`, `AppLogger.e()` for logging
- **✅ ALWAYS** use `ResponseHandler.mapDioExceptionToException(e)` for Dio errors
- **✅ ALWAYS** include generic catch block for unexpected errors
- **✅ ALWAYS** use private fields (`_apiService`) in datasources
- **✅ ALWAYS** return `BaseResponseDto<T>` from remote datasources
- **✅ ALWAYS** return `Either<Failure, T>` from repositories

### Logging Standards:
- `AppLogger.d()`: Debug info at method start with parameters
- `AppLogger.i()`: Success messages with result summary
- `AppLogger.e()`: Error messages with context and exception

1. **Create DTO with Freezed**:
   ```dart
   // data/dtos/example_request_dto.dart
   @freezed
   class ExampleRequestDto with _$ExampleRequestDto {
     const factory ExampleRequestDto({
       required String id,
       String? optionalField,
     }) = _ExampleRequestDto;
     
     factory ExampleRequestDto.fromJson(Map<String, dynamic> json) =>
         _$ExampleRequestDtoFromJson(json);
   }
   ```

2. **Create DataSource with Retrofit**:
   ```dart
   // data/datasources/example_remote_datasource_impl.dart
   @RestApi()
   abstract class ExampleApiService {
     factory ExampleApiService(Dio dio) = _ExampleApiService;
     
     @GET('/examples/{id}')
     Future<BaseResponseDto<ExampleDataDto>> getExample(@Path() String id);
     
     @POST('/examples')
     Future<BaseResponseDto<ExampleDataDto>> createExample(@Body() ExampleRequestDto request);
   }
   
   class ExampleRemoteDataSourceImpl implements ExampleRemoteDataSource {
     final ExampleApiService _apiService;

     ExampleRemoteDataSourceImpl(this._apiService);

     @override
     Future<BaseResponseDto<ExampleDataDto>> getExample(String id) async {
       try {
         AppLogger.d('Getting example with id: $id');
         final response = await _apiService.getExample(id);
         AppLogger.i('Successfully retrieved example: ${response.data?.name}');
         return response;
       } on DioException catch (e) {
         AppLogger.e('Failed to get example with id: $id', e);
         throw ResponseHandler.mapDioExceptionToException(e);
       } catch (e) {
         AppLogger.e('Unexpected error getting example', e);
         throw Exception('Unexpected error: ${e.toString()}');
       }
     }

     @override
     Future<BaseResponseDto<ExampleDataDto>> createExample(ExampleRequestDto request) async {
       try {
         AppLogger.d('Creating example');
         final response = await _apiService.createExample(request);
         AppLogger.i('Successfully created example');
         return response;
       } on DioException catch (e) {
         AppLogger.e('Failed to create example', e);
         throw ResponseHandler.mapDioExceptionToException(e);
       } catch (e) {
         AppLogger.e('Unexpected error creating example', e);
         throw Exception('Unexpected error: ${e.toString()}');
       }
     }
   }
   ```

3. **Create Repository Implementation**:
   ```dart
   // data/repositories_impl/example_repository_impl.dart
   class ExampleRepositoryImpl implements ExampleRepository {
     final ExampleRemoteDataSource remoteDataSource;

     ExampleRepositoryImpl(this.remoteDataSource);

     @override
     Future<Either<Failure, ExampleEntity>> getExample(String id) async {
       try {
         final response = await remoteDataSource.getExample(id);

         if (response.isSuccess && response.data != null) {
           return right(response.data!.toEntity());
         } else {
           return left(ServerFailure(response.message));
         }
       } on Exception catch (e) {
         return left(mapExceptionToFailure(e));
       } catch (e) {
         return left(const ServerFailure('Unexpected error occurred'));
       }
     }

     @override
     Future<Either<Failure, ExampleEntity>> createExample(ExampleEntity example) async {
       try {
         final request = ExampleRequestDto.fromEntity(example);
         final response = await remoteDataSource.createExample(request);

         if (response.isSuccess && response.data != null) {
           return right(response.data!.toEntity());
         } else {
           return left(ServerFailure(response.message));
         }
       } on Exception catch (e) {
         return left(mapExceptionToFailure(e));
       } catch (e) {
         return left(const ServerFailure('Unexpected error occurred'));
       }
     }
   }
   ```

### Step 3: Presentation Layer (UI & State)
1. **Create State Class**:
   ```dart
   // presentation/providers/example_state.dart
   class ExampleState {
     final bool isLoading;
     final List<ExampleEntity> examples;
     final ExampleEntity? selectedExample;
     final Failure? failure;
     
     const ExampleState({
       this.isLoading = false,
       this.examples = const [],
       this.selectedExample,
       this.failure,
     });
     
     ExampleState copyWith({
       bool? isLoading,
       List<ExampleEntity>? examples,
       ExampleEntity? selectedExample,
       Failure? failure,
       bool clearFailure = false,
     }) {
       return ExampleState(
         isLoading: isLoading ?? this.isLoading,
         examples: examples ?? this.examples,
         selectedExample: selectedExample ?? this.selectedExample,
         failure: clearFailure ? null : (failure ?? this.failure),
       );
     }
   }
   ```

2. **Create StateNotifier**:
   ```dart
   // presentation/providers/example_notifier.dart
   class ExampleNotifier extends StateNotifier<ExampleState> {
     final GetExampleUseCase _getExampleUseCase;
     final GetExamplesUseCase _getExamplesUseCase;
     
     ExampleNotifier({
       required GetExampleUseCase getExampleUseCase,
       required GetExamplesUseCase getExamplesUseCase,
     }) : _getExampleUseCase = getExampleUseCase,
          _getExamplesUseCase = getExamplesUseCase,
          super(const ExampleState());
     
     Future<void> loadExamples() async {
       state = state.copyWith(isLoading: true, clearFailure: true);
       
       final result = await _getExamplesUseCase(NoParams());
       
       result.fold(
         (failure) => state = state.copyWith(
           isLoading: false,
           failure: failure,
         ),
         (examples) => state = state.copyWith(
           isLoading: false,
           examples: examples,
         ),
       );
     }
   }
   ```

3. **Create State Class**:
   ```dart
   // presentation/providers/example_state.dart
   class ExampleState {
     final bool isLoading;
     final List<ExampleEntity> examples;
     final ExampleEntity? selectedExample;
     final Failure? failure;
     
     const ExampleState({
       this.isLoading = false,
       this.examples = const [],
       this.selectedExample,
       this.failure,
     });
     
     ExampleState copyWith({
       bool? isLoading,
       List<ExampleEntity>? examples,
       ExampleEntity? selectedExample,
       Failure? failure,
       bool clearFailure = false,
     }) {
       return ExampleState(
         isLoading: isLoading ?? this.isLoading,
         examples: examples ?? this.examples,
         selectedExample: selectedExample ?? this.selectedExample,
         failure: clearFailure ? null : (failure ?? this.failure),
       );
     }
   }
   ```

4. **Create StateNotifier**:
   ```dart
   // presentation/providers/example_notifier.dart
   class ExampleNotifier extends StateNotifier<ExampleState> {
     final GetExampleUseCase _getExampleUseCase;
     final GetExamplesUseCase _getExamplesUseCase;
     
     ExampleNotifier({
       required GetExampleUseCase getExampleUseCase,
       required GetExamplesUseCase getExamplesUseCase,
     }) : _getExampleUseCase = getExampleUseCase,
          _getExamplesUseCase = getExamplesUseCase,
          super(const ExampleState());
     
     Future<void> loadExamples() async {
       state = state.copyWith(isLoading: true, clearFailure: true);
       
       final result = await _getExamplesUseCase(NoParams());
       
       result.fold(
         (failure) => state = state.copyWith(
           isLoading: false,
           failure: failure,
         ),
         (examples) => state = state.copyWith(
           isLoading: false,
           examples: examples,
         ),
       );
     }
   }
   ```

5. **Create Providers**:
   ```dart
   // presentation/providers/example_providers.dart
   // Network providers
   final exampleApiServiceProvider = Provider<ExampleApiService>((ref) {
     final dio = ref.watch(authenticatedDioProvider);
     return ExampleApiService(dio);
   });
   
   final exampleRemoteDataSourceProvider = Provider<ExampleRemoteDataSource>((ref) {
     final apiService = ref.watch(exampleApiServiceProvider);
     return ExampleRemoteDataSourceImpl(apiService);
   });
   
   // Repository provider
   final exampleRepositoryProvider = Provider<ExampleRepository>((ref) {
     final remoteDataSource = ref.watch(exampleRemoteDataSourceProvider);
     return ExampleRepositoryImpl(remoteDataSource);
   });
   
   // UseCase providers
   final getExampleUseCaseProvider = Provider<GetExampleUseCase>((ref) {
     final repository = ref.watch(exampleRepositoryProvider);
     return GetExampleUseCase(repository);
   });
   
   // StateNotifier provider
   final exampleNotifierProvider = StateNotifierProvider<ExampleNotifier, ExampleState>((ref) {
     final getExampleUseCase = ref.watch(getExampleUseCaseProvider);
     final getExamplesUseCase = ref.watch(getExamplesUseCaseProvider);
     
     return ExampleNotifier(
       getExampleUseCase: getExampleUseCase,
       getExamplesUseCase: getExamplesUseCase,
     );
   });
   ```

6. **Create Barrel Export**:
   ```dart
   // presentation/providers/providers.dart
   export 'example_state.dart';
   export 'example_notifier.dart';
   export 'example_providers.dart';
   export 'example_network_providers.dart';
   ```

4. **Create Screen with State Management**:
   ```dart
   // presentation/screens/example_screen.dart
   class ExampleScreen extends ConsumerStatefulWidget {
     const ExampleScreen({super.key});
     
     @override
     ConsumerState<ExampleScreen> createState() => _ExampleScreenState();
   }
   
   class _ExampleScreenState extends ConsumerState<ExampleScreen> {
     @override
     void initState() {
     super.initState();
     // Load initial data
     WidgetsBinding.instance.addPostFrameCallback((_) {
       ref.read(exampleNotifierProvider.notifier).loadExamples();
     });
   }
     
     @override
     Widget build(BuildContext context) {
       final state = ref.watch(exampleNotifierProvider);
       
       // Listen for navigation or side effects
       ref.listen<ExampleState>(exampleNotifierProvider, (prev, next) {
         if (next.failure != null) {
           context.showErrorToast(next.failure!.message);
         }
       });
       
       return Scaffold(
         appBar: AppBar(
           title: Text('Examples'),
           backgroundColor: context.colors.primary,
         ),
         body: state.isLoading
             ? Center(child: CircularProgressIndicator())
             : ListView.builder(
                 itemCount: state.examples.length,
                 itemBuilder: (context, index) {
                   final example = state.examples[index];
                   return ListTile(
                     title: Text(example.name),
                     subtitle: Text(example.id),
                   );
                 },
               ),
       );
     }
   }
   ```

## 4. Code Generation Workflow
## 4. Code Generation Workflow
- **Build/Codegen**: `fvm dart run build_runner build --delete-conflicting-outputs`
- **Watch Mode**: `fvm dart run build_runner watch --delete-conflicting-outputs`
- **Dependency Management**: `fvm flutter pub get`
- **Testing**: `fvm flutter test` (tests are organized by feature, focus on provider and notifier logic)
- **Lint/Analyze**: `fvm dart analyze` or `fvm flutter analyze`
- **Localization**: ARB files in `lib/l10n/`, build with `fvm flutter pub run intl_utils:generate`
- **Mock Data**: Always provide fallback mock data for API failures using `MockExampleService` classes

## 5. Developer Workflows & Commands

## 5. Developer Workflows & Commands
### Quick Commands
- **Start Development**: `fvm flutter run`
- **Build & Watch**: `fvm dart run build_runner watch --delete-conflicting-outputs`
- **Full Rebuild**: `fvm dart run build_runner build --delete-conflicting-outputs`
- **Get Dependencies**: `fvm flutter pub get`
- **Clean & Rebuild**: `fvm flutter clean && fvm flutter pub get && fvm dart run build_runner build --delete-conflicting-outputs`
-- **analyze**: `fvm flutter analyze `

### Feature Creation Checklist
1. **Create Domain Layer**: entities, repositories (interfaces), usecases
2. **Create Data Layer**: DTOs (with Freezed), datasources (with Retrofit), repository implementations
3. **Run Codegen**: `fvm dart run build_runner build --delete-conflicting-outputs`
4. **Create Presentation Layer**: state classes, notifiers, providers, screens, widgets
5. **Add to Routing**: Update routes in `core/routing/`
6. **Add Tests**: Unit tests for usecases, notifiers, and repositories
7. **Update Localization**: Add ARB entries if needed

## 6. Project-Specific Patterns & Conventions
- **Provider Structure**:
  Each feature has its own providers split into separate files for better organization:
  - `*_state.dart`: State classes (e.g., `cart_state.dart`)
  - `*_notifier.dart`: StateNotifier classes (e.g., `cart_notifier.dart`)
  - `*_providers.dart`: Provider definitions and dependency injection
  - `providers.dart`: Barrel export file for all provider files
  - Notifiers are split for clarity (e.g., `restaurants_notifier.dart`, `restaurant_detail_notifier.dart`)
- **Async Navigation**:  
  Avoid using `BuildContext` across async gaps. Use `ref.listen` for state-driven navigation (see `ProfilePage`).
- **DTOs as Query**:  
  Retrofit endpoints accept DTOs directly for query serialization. No manual map needed.
- **Global State Reset**:  
  On logout, call `appInitializerServiceProvider.clearDataAfterLogout()` to reset all state.
- **Cross-feature Communication**:  
  Use shared providers and navigation helpers for communication between features.
- **App Initialization**:  
  Use `appInitializerServiceProvider` for global reset and startup logic.
- **Testing**:  
  Tests are feature-based, focus on provider and notifier logic. Use mock services for fallback and isolation.

## 7. Integration Points
- **Firebase**: Used for core and analytics.
- **Google Nav Bar**: For bottom navigation.
- **Localization**: ARB files, `intl_utils`.
- **External APIs**: All API calls go through repository/usecase pattern for testability.

## 8. Key Files & Directories
- `lib/features/`: Feature-based organization (auth, restaurants, profile, etc.)
- `lib/core/`: Constants, error, logger, network, utils, widgets, routing.
- `lib/features/restaurants/presentation/providers/`: Provider and notifier split into separate files (state, notifier, providers, barrel export).
- `lib/features/cart/presentation/providers/`: Example of clean provider separation (cart_state.dart, cart_notifier.dart, cart_providers.dart, providers.dart).
- `lib/features/profile/presentation/pages/profile_page.dart`: Example of Riverpod listen for navigation and logout flow.
- `lib/features/restaurants/data/datasources/restaurant_remote_datasource_impl.dart`: API integration, DTO direct passing.
- `lib/l10n/`: Localization ARB files.

## 9. Example Patterns
- **Logout Flow**:
  ```dart
  ref.listen<AuthState>(authStateProvider, (prev, next) {
    if (prev?.isAuthenticated == true && !next.isAuthenticated) {
      context.goToLogin();
      ref.read(appInitializerServiceProvider).clearDataAfterLogout();
    }
  });
  ```
- **Provider Usage**:
  ```dart
  final restaurantsState = ref.watch(restaurantsNotifierProvider);
  ref.read(restaurantsNotifierProvider.notifier).loadRestaurants();
  ```
- **DTO to Retrofit**:
  ```dart
  // Pass DTO directly, no manual map
  final response = await _apiService.getRestaurants(requestDto);
  ```
- **Fallback Data**:
  ```dart
  // Always fallback to mock if API fails
  final restaurants = MockRestaurantService.getMockRestaurants();
  ```

## 10. Theme System & UI Styling

### Theme Architecture
The app uses a comprehensive theme system with multiple theme variants:
```
lib/core/theme/
├── app_colors.dart          # Color schemes interface
├── app_dimensions.dart      # Spacing, sizing constants  
├── app_text_styles.dart     # Typography system
├── app_theme.dart          # Main theme configuration
├── theme_extensions.dart    # Context/Ref extensions
├── theme_provider.dart     # Riverpod theme state
└── theme.dart              # Barrel export
```

### Theme Usage Patterns
- **Access Colors in Widgets**:
  ```dart
  // Using BuildContext extension
  Container(
    color: context.colors.primary,
    child: Text('Hello', style: TextStyle(color: context.colors.onPrimary))
  )
  
  // Using WidgetRef extension
  Consumer(builder: (context, ref, child) {
    final colors = ref.colors;
    return Container(color: colors.surface);
  })
  ```

- **Theme Provider Usage**:
  ```dart
  // Watch current theme
  final currentTheme = ref.watch(themeNotifierProvider);
  
  // Change theme
  ref.read(themeNotifierProvider.notifier).setTheme(AppThemeType.dark);
  
  // Toggle theme
  ref.read(themeNotifierProvider.notifier).toggleTheme();
  ```

- **Theme-Aware Components**:
  ```dart
  // Always use theme colors, never hardcoded
  Card(
    color: context.colors.cardBackground,
    elevation: AppDimensions.elevationSmall,
    child: Padding(
      padding: EdgeInsets.all(AppDimensions.paddingMedium),
      child: Text('Content', style: context.textStyles.bodyMedium)
    )
  )
  ```

### Theme Implementation Rules
- **Color Usage**: Always use `context.colors.colorName` or `ref.colors.colorName`
- **Typography**: Use `context.textStyles.styleName` for consistent text styling
- **Dimensions**: Use `AppDimensions.constantName` for spacing/sizing
- **Status Colors**: Use semantic colors (`success`, `error`, `warning`, `info`)
- **Theme Switching**: Persist theme choice using SharedPreferences
- **Dark/Light Detection**: Use `context.isDarkTheme` or `context.isLightTheme`

### Adding New Themes
1. **Add to AppThemeType enum** in `app_theme.dart`
2. **Create color implementation** in `app_colors.dart`
3. **Update theme factory** in `AppTheme.fromType()`
4. **Test with theme switcher** in settings/profile

## 11. Advanced Patterns & Gotchas
- **Codegen**: Always run build_runner after changing DTO/entity/state.
- **Freezed/Retrofit**: Ensure DTOs have `@JsonSerializable()` and factory `fromJson`.
- **Navigation**: Never use context after await, always use state-driven navigation.
- **Mock Data**: `MockRestaurantService` always provides fallback for API calls.
- **Testing**: Tests are feature-based, focus on provider and notifier logic.
- **Localization**: Always update ARB files and run codegen after changing translations.
- **Theme**: Never hardcode colors/dimensions, always use theme system extensions.

## 12. Commit Message Guidelines

### Commit Message Format
- **Format**: `type(scope): description`
- **Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`
- **Examples**:
  - `feat(auth): add login with email validation`
  - `fix(ui): resolve theme color inconsistency`
  - `refactor(restaurants): split provider into separate files`
  - `test(auth): add unit tests for login usecase`

### Commit Message Best Practices
- Use imperative mood: "add", "fix", "update", not "added", "fixed"
- Keep first line under 50 characters
- Add detailed description for complex changes
- Reference issue numbers: `fix(auth): resolve login issue #123`
- Group related changes in single commit
- Limit 100 characters per line in body

### AI Commit Message Generation
When generating commit messages, follow this pattern:
1. Analyze changed files and their purpose
2. Determine appropriate type based on changes
3. Write clear, concise description
4. Include scope if applicable (feature name)
---

## 📋 STANDARDIZED IMPLEMENTATION CHECKLIST

### For ALL New Features/Modules:

#### ✅ **Domain Layer**:
- [ ] Create entities in `domain/entities/`
- [ ] Create repository interfaces in `domain/repositories/`
- [ ] Create usecases in `domain/usecases/`

#### ✅ **Data Layer**:
- [ ] Create DTOs with Freezed in `data/dtos/`
- [ ] Create Retrofit API service in datasource implementation
- [ ] **MANDATORY**: Follow exact RemoteDataSource pattern:
  ```dart
  class FeatureRemoteDataSourceImpl implements FeatureRemoteDataSource {
    final FeatureApiService _apiService;  // ✅ Private field
    
    FeatureRemoteDataSourceImpl(this._apiService);
    
    @override
    Future<BaseResponseDto<FeatureDto>> method() async {
      try {
        AppLogger.d('Getting [resource]');  // ✅ Debug log
        final response = await _apiService.method();
        AppLogger.i('Successfully retrieved [resource]');  // ✅ Success log
        return response;  // ✅ Return directly, no success check
      } on DioException catch (e) {
        AppLogger.e('Failed to get [resource]', e);  // ✅ Error log with context
        throw ResponseHandler.mapDioExceptionToException(e);  // ✅ Use ResponseHandler
      } catch (e) {
        AppLogger.e('Unexpected error getting [resource]', e);  // ✅ Generic error log
        throw Exception('Unexpected error: ${e.toString()}');  // ✅ Generic exception
      }
    }
  }
  ```
- [ ] **MANDATORY**: Follow exact Repository pattern:
  ```dart
  class FeatureRepositoryImpl implements FeatureRepository {
    final FeatureRemoteDataSource remoteDataSource;
    
    FeatureRepositoryImpl(this.remoteDataSource);
    
    @override
    Future<Either<Failure, FeatureEntity>> method() async {
      try {
        final response = await remoteDataSource.method();
        
        if (response.isSuccess && response.data != null) {
          return right(response.data!.toEntity());
        } else {
          return left(ServerFailure(response.message));
        }
      } on Exception catch (e) {
        return left(mapExceptionToFailure(e));
      } catch (e) {
        return left(const ServerFailure('Unexpected error occurred'));
      }
    }
  }
  ```

#### ✅ **Presentation Layer**:
- [ ] Create state classes in `presentation/providers/feature_state.dart`
- [ ] Create notifiers in `presentation/providers/feature_notifier.dart`
- [ ] Create providers in `presentation/providers/feature_providers.dart`
- [ ] Create barrel export in `presentation/providers/providers.dart`
- [ ] Create screens and widgets following the established patterns

#### ✅ **Code Generation**:
- [ ] Run `fvm dart run build_runner build --delete-conflicting-outputs`
- [ ] Verify all generated files are created correctly

#### ✅ **Testing**:
- [ ] Create unit tests following the established patterns
- [ ] Update test mocks to match new datasource signatures
- [ ] Run tests to ensure everything works

### 🚫 **STRICTLY FORBIDDEN PATTERNS**:
- **❌ NEVER** use `Either<Exception, T>` in remote datasources
- **❌ NEVER** manually check `response.isSuccess` in remote datasources
- **❌ NEVER** return `Either` from remote datasources
- **❌ NEVER** use inconsistent logging patterns
- **❌ NEVER** skip DioException handling
- **❌ NEVER** use public fields in datasources (always `_fieldName`)

### 📝 **Implementation Notes**:
- **BaseResponseDto<T>**: Always return this from remote datasources
- **Either<Failure, T>**: Always return this from repositories
- **AppLogger**: Always use for consistent logging
- **ResponseHandler**: Always use for DioException mapping
- **Private fields**: Always use `_` prefix in datasources
- **Clean separation**: Remote datasources throw exceptions, repositories convert to Either
- **Documentation:** DO NOT create `.md` files (README, SUMMARY, ARCHITECTURE, etc.) unless explicitly requested

For any new feature, follow the clean architecture pattern, create domain/data/presentation layers, and always provide Riverpod providers split into separate files (state, notifier, providers, barrel export). Use DTOs for all API calls, and ensure fallback data is available for offline or error scenarios. Use `ref.listen` for navigation and global state changes. All integration and workflow steps should be automated and documented in this file for future agents.
