import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_app/app/app.dart';

void main() {
  testWidgets('wallet app renders onboarding placeholder', (tester) async {
    await tester.pumpWidget(const WalletApp());

    expect(find.text('Onboarding'), findsOneWidget);
    expect(find.textContaining('will be designed'), findsOneWidget);
  });
}
