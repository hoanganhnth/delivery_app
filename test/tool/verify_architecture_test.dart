import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../tool/architecture_graph.dart';

void main() {
  test('reports feature-to-feature edges and cycles', () {
    final root = Directory.systemTemp.createTempSync('architecture_graph_');
    addTearDown(() => root.deleteSync(recursive: true));

    final lib = Directory('${root.path}/lib/features')
      ..createSync(recursive: true);
    Directory('${lib.path}/catalog').createSync(recursive: true);
    Directory('${lib.path}/restaurants').createSync(recursive: true);
    File('${lib.path}/catalog/application.dart').writeAsStringSync(
      "import 'package:delivery_app/features/restaurants/domain/entity.dart';",
    );
    File('${lib.path}/restaurants/domain.dart').writeAsStringSync(
      "import 'package:delivery_app/features/catalog/domain/entity.dart';",
    );
    final report = analyzeArchitecture(Directory('${root.path}/lib'));

    expect(
      report.featureEdges,
      contains(FeatureEdge('catalog', 'restaurants')),
    );
    expect(
      report.featureEdges,
      contains(FeatureEdge('restaurants', 'catalog')),
    );
    expect(
      report.cycles,
      contains(containsAll(<String>['catalog', 'restaurants'])),
    );
  });

  test('reports core imports of feature internals', () {
    final root = Directory.systemTemp.createTempSync('architecture_graph_');
    addTearDown(() => root.deleteSync(recursive: true));

    final core = Directory('${root.path}/lib/core/routing')
      ..createSync(recursive: true);
    Directory('${root.path}/lib/features/catalog').createSync(recursive: true);
    File('${core.path}/router.dart').writeAsStringSync(
      "import 'package:delivery_app/features/catalog/presentation/page.dart';",
    );

    final report = analyzeArchitecture(Directory('${root.path}/lib'));

    expect(
      report.violations,
      contains(
        const ArchitectureViolation(
          path: 'lib/core/routing/router.dart',
          message: 'core imports feature internals',
        ),
      ),
    );
  });
}
