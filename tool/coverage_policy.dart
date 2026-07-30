import 'dart:io';

const _coveragePath = 'coverage/lcov.info';

bool _isHandwrittenReachableSource(String path) {
  return path.startsWith('lib/') &&
      !path.startsWith('lib/generated/') &&
      !path.endsWith('.g.dart') &&
      !path.endsWith('.freezed.dart') &&
      path != 'lib/firebase_options.dart';
}

void main(List<String> arguments) {
  final coverageFile = File(arguments.firstOrNull ?? _coveragePath);
  if (!coverageFile.existsSync()) {
    stderr.writeln(
      'Missing ${coverageFile.path}. Run `fvm flutter test --coverage` first.',
    );
    exitCode = 2;
    return;
  }

  var source = '';
  var linesFound = 0;
  var linesHit = 0;
  var includedFiles = 0;

  for (final line in coverageFile.readAsLinesSync()) {
    if (line.startsWith('SF:')) {
      source = line.substring(3);
      continue;
    }
    if (!_isHandwrittenReachableSource(source)) continue;
    if (line.startsWith('LF:')) {
      linesFound += int.parse(line.substring(3));
      includedFiles += 1;
    } else if (line.startsWith('LH:')) {
      linesHit += int.parse(line.substring(3));
    }
  }

  if (includedFiles == 0 || linesFound == 0 || linesHit > linesFound) {
    stderr.writeln('Invalid or empty filtered LCOV data.');
    exitCode = 3;
    return;
  }

  final percent = linesHit * 100 / linesFound;
  stdout.writeln(
    'Flutter handwritten reachable coverage: '
    '$linesHit/$linesFound lines (${percent.toStringAsFixed(2)}%) '
    'across $includedFiles files.',
  );
  stdout.writeln(
    'No global threshold in Wave 0; use-case matrix and changed-scope floors '
    'are enforced as slices migrate.',
  );
}

extension<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
