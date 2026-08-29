import 'dart:io';

import 'architecture_graph.dart';

/// Lightweight dependency-direction guard for the customer app.
///
/// During migration the default mode checks only new view/component folders.
/// Once the legacy graph is gone CI invokes this script with `--strict`, which
/// also enforces the same purity rules for every presentation widget. Pages
/// and native platform adapters are explicit composition boundaries.
void main(List<String> arguments) {
  final strict = arguments.contains('--strict');
  final root = Directory('lib');
  if (!root.existsSync()) {
    stderr.writeln('Missing lib/; run this command from delivery_app.');
    exitCode = 2;
    return;
  }

  final violations = <String>[];
  if (strict) {
    final report = analyzeArchitecture(root);
    for (final violation in report.violations) {
      violations.add('${violation.path}: ${violation.message}');
    }
    for (final edge in report.featureEdges) {
      stderr.writeln('Feature dependency: $edge');
    }
    for (final cycle in report.cycles) {
      stderr.writeln('Feature cycle: ${cycle.join(' -> ')}');
      violations.add(
        'features/${cycle.join(' <-> ')}: feature dependency cycle',
      );
    }
  }
  for (final file in _dartFiles(root)) {
    final path = _relative(file.path);
    if (_isGenerated(path)) continue;
    final source = file.readAsStringSync();

    final mustBePurePresentation = strict
        ? _isPresentationUi(path)
        : _isMigrationPurePresentation(path);
    if (mustBePurePresentation) {
      _check(
        path,
        source,
        violations,
        'presentation view imports Riverpod',
        source.contains("package:flutter_riverpod/") ||
            source.contains("package:riverpod"),
      );
      _check(
        path,
        source,
        violations,
        'presentation view imports data layer',
        source.contains('/data/'),
      );
      _check(
        path,
        source,
        violations,
        'presentation view performs navigation',
        RegExp(
          r'context\.(go|push|pop)|Navigator\.|showDialog\(|showModalBottomSheet\(',
        ).hasMatch(source),
      );
    }

    if (strict && path.contains('/domain/')) {
      _check(
        path,
        source,
        violations,
        'domain imports Flutter',
        source.contains("package:flutter/") ||
            source.contains("package:flutter_"),
      );
      _check(
        path,
        source,
        violations,
        'domain imports data layer',
        source.contains('/data/'),
      );
    }

    if (strict && _isFeatureApplicationOrDi(path)) {
      _check(
        path,
        source,
        violations,
        'application/DI imports feature presentation',
        RegExp(r'features/[^/]+/presentation/').hasMatch(source),
      );
    }

    if (strict) {
      _check(
        path,
        source,
        violations,
        'presentation owns a provider',
        path.contains('/presentation/providers/'),
      );
    }

    if (strict &&
        path.startsWith('lib/core/') &&
        !_isCoreCompositionBoundary(path)) {
      _check(
        path,
        source,
        violations,
        'core imports feature internals',
        source.contains('/features/'),
      );
    }
  }

  if (violations.isNotEmpty) {
    stderr.writeln('Architecture violations (${violations.length}):');
    for (final violation in violations) {
      stderr.writeln(' - $violation');
    }
    exitCode = 1;
    return;
  }

  stdout.writeln(
    'Architecture guard passed (${strict ? 'strict' : 'migration'} mode).',
  );
}

Iterable<File> _dartFiles(Directory directory) sync* {
  for (final entity in directory.listSync(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) yield entity;
  }
}

String _relative(String path) {
  final normalized = path.replaceAll('\\', '/');
  final index = normalized.lastIndexOf('/lib/');
  return index == -1 ? normalized : normalized.substring(index + 1);
}

bool _isGenerated(String path) =>
    path.endsWith('.g.dart') || path.endsWith('.freezed.dart');

bool _isMigrationPurePresentation(String path) =>
    path.contains('/presentation/views/') ||
    path.contains('/presentation/components/') ||
    path.contains('/presentation/pure_views/');

bool _isPresentationUi(String path) =>
    _isMigrationPurePresentation(path) ||
    path.contains('/presentation/widgets/');

/// Presentation is a leaf: feature state and dependency wiring belong in
/// `application/` and `di/`, never under presentation. Core's reusable MVVM
/// support is intentionally not matched by this feature-path rule.
bool _isFeatureApplicationOrDi(String path) =>
    path.contains('/application/') || path.contains('/di/');

/// These files compose application features at process boundaries (router,
/// persistence/bootstrap and push wake-up). They are adapters, not generic
/// core utilities, so feature imports are intentional and are kept explicit.
bool _isCoreCompositionBoundary(String path) => switch (path) {
  'lib/core/app_dependencies.dart' ||
  'lib/core/storage/adapter/hive_registry.dart' ||
  'lib/core/services/push_notification_service.dart' ||
  'lib/core/services/app_initializer/_riverpod/app_initializer_provider.dart' =>
    true,
  _ when path.startsWith('lib/core/routing/') => true,
  _ when path.startsWith('lib/core/services/push/') => true,
  _ => false,
};

void _check(
  String path,
  String source,
  List<String> violations,
  String label,
  bool failed,
) {
  if (failed) violations.add('$path: $label');
}
