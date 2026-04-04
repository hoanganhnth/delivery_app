# Rules: Architecture

## Clean Architecture Layers

```
┌─────────────────────────────────────┐
│         Presentation Layer          │  UI, State, Widgets
│    (providers, screens, widgets)    │
├─────────────────────────────────────┤
│           Domain Layer              │  Business Logic
│  (entities, repositories, usecases) │  Pure Dart, No dependencies
├─────────────────────────────────────┤
│            Data Layer               │  Implementation
│   (dtos, datasources, repo_impl)    │  API, Database, Cache
└─────────────────────────────────────┘
```

## Dependency Rule

```
Presentation → Domain ← Data
     ↓           ↑        ↓
   Widgets    Entities   DTOs
   Screens    UseCases   APIs
   Providers  Repos(I)   Repos(Impl)
```

- **Domain** không phụ thuộc vào bất kỳ layer nào
- **Data** implements interfaces từ Domain
- **Presentation** sử dụng Domain thông qua UseCases

## Layer Responsibilities

### Domain Layer
- Pure Dart classes (no Flutter imports)
- Business entities
- Repository interfaces (abstract classes)
- Use cases (single responsibility)

### Data Layer
- DTOs for API serialization
- Repository implementations
- Remote/Local data sources
- Mappers (DTO → Entity)

### Presentation Layer
- Riverpod providers (generated)
- State classes
- UI screens & widgets
- Navigation logic

## Communication Rules

```dart
// ✅ CORRECT: Presentation → UseCase → Repository → DataSource
final useCase = ref.read(getFeatureUseCaseProvider);
final result = await useCase(params);

// ❌ WRONG: Presentation → Repository directly (skip UseCase)
final repo = ref.read(featureRepositoryProvider);
final result = await repo.get(id);

// ❌ WRONG: Presentation → DataSource directly
final dataSource = ref.read(featureDataSourceProvider);
final response = await dataSource.fetch();
```
