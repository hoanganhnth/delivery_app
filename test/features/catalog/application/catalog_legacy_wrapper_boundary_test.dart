import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../../../tool/architecture_graph.dart';

void main() {
  test('legacy restaurant and search routes do not create a catalog cycle', () {
    final report = analyzeArchitecture(Directory('lib'));

    expect(
      report.cycles,
      isNot(contains(containsAll(<String>['catalog', 'restaurants']))),
    );
    expect(
      report.cycles,
      isNot(contains(containsAll(<String>['catalog', 'search']))),
    );
  });
}
