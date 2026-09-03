import 'package:delivery_app/core/design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app button exposes disabled and loading semantics', (
    tester,
  ) async {
    var presses = 0;
    await _pump(
      tester,
      Column(
        children: [
          AppButton(
            label: 'Continue',
            semanticLabel: 'Continue to checkout',
            onPressed: () => presses++,
          ),
          AppButton(
            label: 'Saving',
            semanticLabel: 'Saving order',
            isLoading: true,
            onPressed: () => presses++,
          ),
        ],
      ),
    );

    final enabledSemantics = tester.getSemantics(
      find.bySemanticsLabel('Continue to checkout'),
    );
    expect(enabledSemantics.hasFlag(SemanticsFlag.isButton), isTrue);
    expect(enabledSemantics.hasFlag(SemanticsFlag.isEnabled), isTrue);

    final loadingSemantics = tester.getSemantics(
      find.bySemanticsLabel('Saving order'),
    );
    expect(loadingSemantics.hasFlag(SemanticsFlag.isButton), isTrue);
    expect(loadingSemantics.hasFlag(SemanticsFlag.isEnabled), isFalse);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.tap(find.text('Continue'));
    await tester.tap(find.bySemanticsLabel('Saving order'));
    expect(presses, 1);
  });

  testWidgets('icon button has a named 48 logical-pixel touch target', (
    tester,
  ) async {
    await _pump(
      tester,
      AppIconButton(
        tooltip: 'Open cart',
        icon: Icons.shopping_bag_outlined,
        onPressed: () {},
      ),
    );

    expect(find.bySemanticsLabel('Open cart'), findsOneWidget);
    expect(tester.getSize(find.byType(AppIconButton)), const Size(48, 48));
  });

  testWidgets('field and search primitives preserve labels and callbacks', (
    tester,
  ) async {
    final changes = <String>[];
    final searches = <String>[];
    await _pump(
      tester,
      Column(
        children: [
          AppTextField(
            label: 'Order note',
            hintText: 'Add a note',
            onChanged: changes.add,
          ),
          AppSearchField(
            hintText: 'Search dishes',
            semanticLabel: 'Search the menu',
            onSubmitted: searches.add,
          ),
        ],
      ),
    );

    expect(find.text('Order note'), findsOneWidget);
    expect(find.bySemanticsLabel('Search the menu'), findsOneWidget);
    await tester.enterText(find.byType(TextField).first, 'No chilli');
    await tester.enterText(find.byType(TextField).last, 'Rice');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    expect(changes, contains('No chilli'));
    expect(searches, ['Rice']);
  });

  testWidgets(
    'surface, badges, image feedback and sticky action are composable',
    (tester) async {
      await _pump(
        tester,
        Scaffold(
          body: ListView(
            children: [
              const AppSectionHeading(
                title: 'Featured',
                actionLabel: 'See all',
              ),
              const AppSurfaceCard(child: Text('Surface content')),
              const Wrap(
                children: [
                  AppChip(label: 'Fast delivery', selected: true),
                  AppBadge(label: 'New'),
                ],
              ),
              const AppImage(imageUrl: null, semanticLabel: 'Restaurant image'),
              AppStateFeedback.empty(
                title: 'Nothing here',
                message: 'Try another filter',
                actionLabel: 'Reset',
                onAction: () {},
              ),
            ],
          ),
          bottomNavigationBar: AppStickyAction(
            child: AppButton(label: 'Continue', onPressed: () {}),
          ),
        ),
      );

      expect(find.text('Surface content'), findsOneWidget);
      expect(find.text('Fast delivery'), findsOneWidget);
      expect(find.text('New'), findsOneWidget);
      expect(find.bySemanticsLabel('Restaurant image'), findsOneWidget);
      expect(find.text('Nothing here'), findsOneWidget);
      expect(find.byType(SafeArea), findsWidgets);
    },
  );
}

Future<void> _pump(WidgetTester tester, Widget child) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(390, 812);
  addTearDown(tester.view.reset);
  return tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light.themeData,
      home: Scaffold(body: child),
    ),
  );
}
