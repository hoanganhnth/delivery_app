import 'dart:io';

/// A direct dependency between two feature roots.
final class FeatureEdge {
  const FeatureEdge(this.from, this.to);

  final String from;
  final String to;

  @override
  bool operator ==(Object other) =>
      other is FeatureEdge && other.from == from && other.to == to;

  @override
  int get hashCode => Object.hash(from, to);

  @override
  String toString() => '$from -> $to';
}

final class ArchitectureViolation {
  const ArchitectureViolation({required this.path, required this.message});

  final String path;
  final String message;

  @override
  bool operator ==(Object other) =>
      other is ArchitectureViolation &&
      other.path == path &&
      other.message == message;

  @override
  int get hashCode => Object.hash(path, message);

  @override
  String toString() => '$path: $message';
}

final class ArchitectureReport {
  const ArchitectureReport({
    required this.featureEdges,
    required this.cycles,
    required this.violations,
  });

  final Set<FeatureEdge> featureEdges;
  final List<Set<String>> cycles;
  final List<ArchitectureViolation> violations;
}

/// Parses source imports and reports feature graph edges, cycles and strict
/// boundary violations without loading Flutter or package dependencies.
ArchitectureReport analyzeArchitecture(Directory libRoot) {
  final featureRoot = Directory('${libRoot.path}/features');
  final featureNames = featureRoot.existsSync()
      ? featureRoot
            .listSync()
            .whereType<Directory>()
            .map((directory) => _basename(directory.path))
            .toSet()
      : <String>{};

  final edges = <FeatureEdge>{};
  final violations = <ArchitectureViolation>[];
  if (!libRoot.existsSync()) {
    return ArchitectureReport(
      featureEdges: edges,
      cycles: const [],
      violations: const [
        ArchitectureViolation(path: 'lib', message: 'missing lib directory'),
      ],
    );
  }

  for (final file in _dartFiles(libRoot)) {
    final path = _relativeToWorkingTree(file.path, libRoot);
    if (_isGenerated(path)) continue;
    final source = file.readAsStringSync();
    final fromFeature = _featureOf(path);

    for (final importedPath in _imports(file, source, libRoot, featureNames)) {
      final toFeature = _featureOf(importedPath);
      if (fromFeature != null &&
          toFeature != null &&
          fromFeature != toFeature) {
        edges.add(FeatureEdge(fromFeature, toFeature));
      }
      if (path.startsWith('lib/core/') && toFeature != null) {
        violations.add(
          ArchitectureViolation(
            path: path,
            message: 'core imports feature internals',
          ),
        );
      }
    }

    if (_isPresentationUi(path)) {
      if (source.contains('package:flutter_riverpod/') ||
          source.contains('package:riverpod')) {
        violations.add(
          ArchitectureViolation(
            path: path,
            message: 'presentation view imports Riverpod',
          ),
        );
      }
      if (source.contains('/data/')) {
        violations.add(
          ArchitectureViolation(
            path: path,
            message: 'presentation view imports data layer',
          ),
        );
      }
      if (RegExp(
        r'context\.(go|push|pop)|Navigator\.|showDialog\(|showModalBottomSheet\(',
      ).hasMatch(source)) {
        violations.add(
          ArchitectureViolation(
            path: path,
            message: 'presentation view performs navigation',
          ),
        );
      }
    }

    if (path.contains('/domain/')) {
      if (source.contains('package:flutter/') ||
          source.contains('package:flutter_')) {
        violations.add(
          ArchitectureViolation(path: path, message: 'domain imports Flutter'),
        );
      }
      if (source.contains('/data/')) {
        violations.add(
          ArchitectureViolation(
            path: path,
            message: 'domain imports data layer',
          ),
        );
      }
    }

    if (path.contains('/application/') || path.contains('/di/')) {
      if (RegExp(r'features/[^/]+/presentation/').hasMatch(source)) {
        violations.add(
          ArchitectureViolation(
            path: path,
            message: 'application/DI imports feature presentation',
          ),
        );
      }
    }
  }

  return ArchitectureReport(
    featureEdges: Set.unmodifiable(edges),
    cycles: _findCycles(edges),
    violations: List.unmodifiable(violations),
  );
}

Iterable<File> _dartFiles(Directory directory) sync* {
  for (final entity in directory.listSync(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) yield entity;
  }
}

Iterable<String> _imports(
  File sourceFile,
  String source,
  Directory libRoot,
  Set<String> featureNames,
) sync* {
  final importPattern = RegExp(
    r'''(?:import|export)\s+['"]([^'"]+)['"]''',
    multiLine: true,
  );
  for (final match in importPattern.allMatches(source)) {
    final specifier = match.group(1)!;
    if (specifier.startsWith('dart:') ||
        specifier.startsWith('package:flutter') ||
        specifier.startsWith('package:riverpod') ||
        specifier.startsWith('package:')) {
      if (!specifier.startsWith('package:delivery_app/')) continue;
      final target = specifier.substring('package:delivery_app/'.length);
      if (target.startsWith('features/')) yield 'lib/$target';
      continue;
    }
    if (!specifier.startsWith('.')) continue;
    final resolved = File('${sourceFile.parent.path}/$specifier').absolute.path;
    if (!resolved.startsWith(libRoot.absolute.path)) continue;
    final relative = _relativeToWorkingTree(resolved, libRoot);
    if (_featureOf(relative) != null) yield relative;
  }
}

String? _featureOf(String path) {
  final match = RegExp(r'^lib/features/([^/]+)/').firstMatch(path);
  final feature = match?.group(1);
  // The path is already rooted below lib/features. Do not rely on directory
  // enumeration here: temporary fixtures and symlinked worktrees can expose a
  // valid source path before a directory entry is visible to listSync().
  return feature;
}

List<Set<String>> _findCycles(Set<FeatureEdge> edges) {
  final graph = <String, Set<String>>{};
  for (final edge in edges) {
    graph.putIfAbsent(edge.from, () => <String>{}).add(edge.to);
    graph.putIfAbsent(edge.to, () => <String>{});
  }

  final indexByNode = <String, int>{};
  final lowLink = <String, int>{};
  final stack = <String>[];
  final onStack = <String>{};
  final components = <Set<String>>[];
  var index = 0;

  void visit(String node) {
    indexByNode[node] = index;
    lowLink[node] = index;
    index += 1;
    stack.add(node);
    onStack.add(node);

    for (final next in graph[node]!) {
      if (!indexByNode.containsKey(next)) {
        visit(next);
        lowLink[node] = lowLink[node]!.min(lowLink[next]!);
      } else if (onStack.contains(next)) {
        lowLink[node] = lowLink[node]!.min(indexByNode[next]!);
      }
    }

    if (lowLink[node] == indexByNode[node]) {
      final component = <String>{};
      String current;
      do {
        current = stack.removeLast();
        onStack.remove(current);
        component.add(current);
      } while (current != node);
      final selfLoop = component.length == 1 && graph[node]!.contains(node);
      if (component.length > 1 || selfLoop) components.add(component);
    }
  }

  for (final node in graph.keys) {
    if (!indexByNode.containsKey(node)) visit(node);
  }
  return List.unmodifiable(components);
}

extension on int {
  int min(int other) => this < other ? this : other;
}

bool _isPresentationUi(String path) =>
    path.contains('/presentation/views/') ||
    path.contains('/presentation/components/') ||
    path.contains('/presentation/widgets/');

bool _isGenerated(String path) =>
    path.endsWith('.g.dart') || path.endsWith('.freezed.dart');

String _relativeToWorkingTree(String path, Directory libRoot) {
  final normalized = path.replaceAll('\\', '/');
  final libPath = libRoot.absolute.path.replaceAll('\\', '/');
  final index = normalized.indexOf('$libPath/');
  if (index == -1) return normalized;
  final start = (index + libPath.length + 1).toInt();
  return 'lib/${normalized.substring(start)}';
}

String _basename(String path) => path.replaceAll('\\', '/').split('/').last;
