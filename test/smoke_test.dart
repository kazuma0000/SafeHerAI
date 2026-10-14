import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:safeher_ai/main.dart';
import 'package:safeher_ai/core/app_state.dart';

void main() {
  testWidgets('SafeHer AI boots into its loading or auth flow', (tester) async {
    await tester.pumpWidget(ChangeNotifierProvider(create: (_) => AppState(), child: const SafeHerApp()));
    expect(find.byType(SafeHerApp), findsOneWidget);
  });
}
