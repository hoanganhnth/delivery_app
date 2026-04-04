# Delivery App - Flutter Copilot Instructions

> **Tech Stack**: Flutter 3.x, Riverpod Generator, Freezed, Retrofit, GoRouter, fpdart

---

## 📚 Documentation Structure

**Skills (How-to)**: `.github/copilot/skills/` - Patterns for Riverpod, API, Theme, Navigation, Freezed, Testing  
**Rules (Constraints)**: `.github/copilot/rules/` - Code style, Architecture, Error handling, Anti-patterns, Commands

---

## Architecture Overview

```
lib/
├── core/                    # Shared utilities, theme, routing, network
├── features/                # Feature-based modules
│   └── [feature]/
│       ├── domain/          # Entities, Repository interfaces, UseCases
│       ├── data/            # DTOs, DataSources, Repository implementations
│       └── presentation/    # Providers, Screens, Widgets
└── l10n/                    # Localization
```

---

## Core Rules (Always Apply)

### ✅ ALWAYS
- Use `@riverpod` annotation for all providers
- Use `@freezed` for DTOs and State classes (or plain class with manual copyWith)
- Use `Either<Failure, T>` in repositories
- Use `context.colors.*` for colors (never hardcode)
- Use `ref.listen` for navigation/side effects
- Run codegen after changes: `fvm dart run build_runner build --delete-conflicting-outputs`

### ❌ NEVER
- Write manual providers (use generator)
- Use `dynamic` types
- Hardcode colors: `Color(0xFF...)`
- Use `BuildContext` after `await`
- Return `Either` from datasources (throw instead)
- Skip error handling

---

## Feature Checklist Automation

> Khi tạo xong tính năng mới, hãy cập nhật checklist vào `lib/features/[feature]/README.md` để theo dõi tiến độ.


## Commands

```bash
fvm flutter run                                                    # Run
fvm dart run build_runner build --delete-conflicting-outputs       # Codegen
fvm flutter analyze                                                # Analyze
fvm flutter test                                                   # Test
```


