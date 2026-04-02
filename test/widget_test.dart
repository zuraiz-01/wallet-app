import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_app/app/app.dart';

void main() {
  testWidgets('wallet app renders onboarding view', (tester) async {
    await tester.pumpWidget(const WalletApp());

    expect(find.text('Welcome to Walletly'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });
}
