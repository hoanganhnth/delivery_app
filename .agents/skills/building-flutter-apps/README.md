# Flutter Riverpod Clean Architecture Skill

> Flutter clean architecture patterns with Riverpod 3.x codegen, Freezed 3.x sealed classes, GoRouter, and Hive CE persistence.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B.svg)](https://flutter.dev)
[![Riverpod](https://img.shields.io/badge/Riverpod-3.x-00B4D8.svg)](https://riverpod.dev)

> **Disclaimer:** This is an unofficial community resource. It is not affiliated with, endorsed by, or sponsored by Google, the Flutter team, or the Riverpod maintainers. "Flutter" is a trademark of Google LLC. "Riverpod" is maintained by Remi Rousselet.

## Installation

```bash
npx skills add sgaabdu4/building-flutter-apps
```

Or manually clone into `~/.claude/skills/`:

```bash
git clone https://github.com/sgaabdu4/building-flutter-apps ~/.claude/skills/building-flutter-apps
```

## What's Included

This skill provides AI agents with comprehensive guidance for Flutter development using modern best practices:

### Core Stack
| Package | Version | Purpose |
|---------|---------|---------|
| flutter_riverpod | ^3.1.0 | State management |
| riverpod_annotation | ^4.0.0 | Codegen annotations |
| riverpod_generator | 4.0.0+1 | Provider code generation |
| freezed | ^3.2.0 | Immutable data classes, unions |
| go_router | ^16.2.0 | Declarative routing |
| hive / hive_flutter | ^2.2.3 / ^1.1.0 | Binary local persistence |

### Architecture
Four-layer clean architecture:
```
lib/
├── core/           # Shared: theme, utils, widgets, navigation, services
├── features/       # Feature modules (auth, products, home, ...)
│   └── feature_x/
│       ├── data/           # Models, datasources
│       ├── domain/         # Entities (pure Dart)
│       ├── repositories/   # Data orchestration
│       └── presentation/   # Notifiers, screens, widgets
└── main.dart
```

### Key Patterns
- **Codegen-only providers** — No `StateProvider`, `StateNotifierProvider`, or legacy providers
- **Sealed classes** — Exhaustive pattern matching with Dart's native `switch`
- **Interface contracts** — `abstract interface class` for every repository and datasource
- **No prop drilling** — Child widgets watch providers directly
- **Async safety** — `if (!ref.mounted) return;` guards after every `await`
- **Unified Ref** — Single `Ref` type (no `AutoDisposeRef`, `ExampleRef`)
- **Widget classes only** — No helper methods (`_buildXxx`)
- **No `dynamic`** — Use `Object?` or a proper type
- **Enforcement** — Every reference file has MUST/NEVER rules at the top

## Reference & Rules Files

| Topic | File |
|-------|------|
| Riverpod Generator, Notifier, State | [riverpod.md](references/riverpod.md) |
| API Layer, Datasource, Repository | [api-layer.md](references/api-layer.md) |
| Freezed, DTO, Entity, State | [freezed.md](references/freezed.md) |
| Navigation, GoRouter | [navigation.md](references/navigation.md) |
| Theme, Styling, Typography | [theme.md](references/theme.md) |
| Testing (Unit/Widget) | [testing.md](references/testing.md) |
| Hive persistence, Local storage | [hive-persistence.md](references/hive-persistence.md) |
| UI Optimizations, Anti-jank | [flutter-optimizations.md](references/flutter-optimizations.md) |
| Commands & Build Scripts | [commands.md](rules/commands.md) |
| Architecture Rules | [architecture.md](rules/architecture.md) |
| Code Style & Organization | [code-style.md](rules/code-style.md) |
| Error Handling | [error-handling.md](rules/error-handling.md) |
| Forbidden Anti-Patterns | [forbidden.md](rules/forbidden.md) |

## Compatible Agents

- [Claude Code](https://code.claude.com/)
- [Cursor](https://cursor.sh/)
- [Windsurf](https://windsurf.ai/)
- Any agent supporting the [Agent Skills](https://agentskills.io/) standard

## Usage

Once installed, the skill automatically activates when you:
- Build, review, or refactor Flutter apps
- Work with Riverpod state management
- Implement Freezed data classes
- Set up GoRouter navigation

Or invoke directly:
```
/building-flutter-apps
```

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/add-pattern`)
3. Follow existing documentation style
4. Submit a pull request

### Guidelines
- Keep SKILL.md under 500 lines
- Add detailed patterns to `references/` files
- Include working code examples
- Test with Riverpod 3.x and Freezed 3.x
- Follow the architecture guidelines

## License

MIT — see [LICENSE](LICENSE)

## Resources

- [Riverpod Documentation](https://riverpod.dev)
- [Freezed Package](https://pub.dev/packages/freezed)
- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Flutter Documentation](https://flutter.dev/docs)
