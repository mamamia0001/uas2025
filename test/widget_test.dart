import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:uas2025/main.dart';

void main() {
  testWidgets('Pokemon list CRUD operations', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify the initial state of the app.
    expect(find.text('Pokemon List'), findsOneWidget);
    expect(find.byType(ListTile), findsNothing); // No Pokemon initially

    // Add a new Pokemon.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify that we navigated to the add Pokemon page.
    expect(find.text('Tambah Pokemon'), findsOneWidget);

    // Enter a new Pokemon name.
    await tester.enterText(find.byType(TextField), 'Pikachu');
    await tester.tap(find.text('Tambah'));
    await tester.pumpAndSettle();

    // Verify that the new Pokemon is added to the list.
    expect(find.text('Pikachu'), findsOneWidget);

    // Edit the Pokemon name.
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();

    // Verify that we navigated to the edit Pokemon page.
    expect(find.text('Edit Pokemon'), findsOneWidget);

    // Change the name of the Pokemon.
    await tester.enterText(find.byType(TextField), 'Raichu');
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    // Verify that the Pokemon name is updated.
    expect(find.text('Raichu'), findsOneWidget);
    expect(find.text('Pikachu'), findsNothing);

    // Delete the Pokemon.
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();

    // Verify that the Pokemon is removed from the list.
    expect(find.byType(ListTile), findsNothing);
  });
}
